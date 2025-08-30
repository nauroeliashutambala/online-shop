<?php
require_once("../../config/conexao.php");
header('Content-Type: application/json; charset=utf-8');

// Verifica conexão
if (!isset($mysqli) || !($mysqli instanceof mysqli)) {
    echo json_encode([['status' => 'erro', 'msg' => 'Conexão inválida']]);
    exit;
}

// Query base
$sql = "SELECT id_servico, titulo, preco_base, categoria, descricao, data_criacao
        FROM servicos
        WHERE status = 'ativo'";

$params = [];
$types  = "";

// Filtro de pesquisa
if (!empty($_GET['search'])) {
    $sql .= " AND titulo LIKE ?";
    $params[] = '%' . $_GET['search'] . '%';
    $types .= 's';
}

$sql .= " ORDER BY data_criacao DESC LIMIT 12";

// Executa query
if (!empty($params)) {
    $stmt = $mysqli->prepare($sql);
    if ($stmt === false) {
        echo json_encode([['status' => 'erro', 'msg' => $mysqli->error]]);
        exit;
    }
    $stmt->bind_param($types, ...$params);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $result = $mysqli->query($sql);
    if ($result === false) {
        echo json_encode([['status' => 'erro', 'msg' => $mysqli->error]]);
        exit;
    }
}

// Monta array de produtos
$produtos = [];
while ($row = $result->fetch_assoc()) {
    $produtos[] = [
        'id'        => $row['id_servico'],
        'nome'      => $row['titulo'],
        'preco'     => (float)$row['preco_base'], // número puro
        'imagem'    => 'assets/img/folder.jpg',   // fixa, pois a tabela não tem coluna imagem
        'categoria' => $row['categoria'],
        'descricao' => $row['descricao']
    ];
}

// Retorna JSON
echo json_encode($produtos, JSON_UNESCAPED_UNICODE);

if (isset($stmt) && $stmt instanceof mysqli_stmt) {
    $stmt->close();
}
$mysqli->close();
