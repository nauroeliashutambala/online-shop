<?php
require_once("../../config/conexao.php");
session_start();
header('Content-Type: application/json');

// Verificar login
if (!isset($_SESSION['id_usuario'])) {
    echo json_encode(['status' => 'erro', 'msg' => 'Você precisa estar logado']);
    exit;
}

$dados = json_decode(file_get_contents("php://input"), true);

if (!isset($dados['id_produto'])) {
    echo json_encode(['status' => 'erro', 'msg' => 'Produto inválido']);
    exit;
}

$id_usuario = $_SESSION['id_usuario'];
$id_produto = intval($dados['id_produto']);

// Verificar se já está favoritado
$sql = "SELECT 1 FROM favoritos WHERE id_usuario = ? AND id_produto = ?";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("ii", $id_usuario, $id_produto);
$stmt->execute();
$res = $stmt->get_result();

if ($res->num_rows > 0) {
    echo json_encode(['status' => 'ok', 'msg' => 'Já favoritado']);
    exit;
}

// Inserir favorito
$sql = "INSERT INTO favoritos (id_usuario, id_produto, data_favorito) VALUES (?, ?, NOW())";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("ii", $id_usuario, $id_produto);

if ($stmt->execute()) {
    echo json_encode(['status' => 'ok', 'msg' => 'Favoritado com sucesso']);
} else {
    echo json_encode(['status' => 'erro', 'msg' => 'Erro ao favoritar']);
}

$stmt->close();
$mysqli->close();
