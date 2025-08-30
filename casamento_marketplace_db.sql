-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30-Ago-2025 às 21:02
-- Versão do servidor: 10.4.28-MariaDB
-- versão do PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `casamento_marketplace`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `avaliacoes`
--

CREATE TABLE `avaliacoes` (
  `id_avaliacao` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `nota` tinyint(4) NOT NULL CHECK (`nota` between 1 and 5),
  `comentario` text DEFAULT NULL,
  `data_avaliacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `avaliacoes`
--

INSERT INTO `avaliacoes` (`id_avaliacao`, `id_cliente`, `id_servico`, `nota`, `comentario`, `data_avaliacao`) VALUES
(1, 1, 1, 5, 'Espaço maravilhoso, recomendo muito!', '2025-08-13 14:12:44'),
(2, 2, 3, 4, 'Decoração muito bonita, mas atrasou um pouco na entrega.', '2025-08-13 14:12:44'),
(3, 1, 5, 5, 'Fotos incríveis, melhor escolha que fiz!', '2025-08-13 14:12:44');

-- --------------------------------------------------------

--
-- Estrutura da tabela `chats`
--

CREATE TABLE `chats` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fornecedor_id` int(11) NOT NULL,
  `criado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `chat_mensagens`
--

CREATE TABLE `chat_mensagens` (
  `id` int(11) NOT NULL,
  `remetente` enum('usuario','fornecedor') NOT NULL,
  `texto` text NOT NULL,
  `hora` datetime DEFAULT current_timestamp(),
  `id_chat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `chat_mensagens`
--

INSERT INTO `chat_mensagens` (`id`, `remetente`, `texto`, `hora`, `id_chat`) VALUES
(1, 'usuario', 'Oiii', '2025-08-16 13:01:45', 1),
(2, 'fornecedor', 'Helloo', '2025-08-16 13:01:50', 1),
(3, 'usuario', 'ssqq', '2025-08-16 13:02:18', 1),
(4, 'usuario', 'Gostaria de arrendar o seu espaço ainda hoje', '2025-08-16 13:03:42', 1),
(5, 'fornecedor', 'Estamos abertos nestes dias 12, 13, 14', '2025-08-16 13:04:05', 1),
(6, 'usuario', 'nhiioeed', '2025-08-16 13:46:24', 1),
(7, 'usuario', 'dd', '2025-08-16 13:46:28', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `favoritos`
--

CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `data_favorito` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fotos_servico`
--

CREATE TABLE `fotos_servico` (
  `id_foto` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `url_foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `fotos_servico`
--

INSERT INTO `fotos_servico` (`id_foto`, `id_servico`, `url_foto`) VALUES
(1, 1, 'fotos/salao_lux1.jpg'),
(2, 1, 'fotos/salao_lux2.jpg'),
(3, 2, 'fotos/salao_jardim1.jpg'),
(4, 3, 'fotos/decor_classica1.jpg'),
(5, 4, 'fotos/decor_tematica1.jpg'),
(6, 5, 'fotos/fotografia_premium1.jpg');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pagamentos`
--

CREATE TABLE `pagamentos` (
  `id_pagamento` int(11) NOT NULL,
  `id_reserva` int(11) NOT NULL,
  `valor_pago` decimal(10,2) NOT NULL,
  `metodo` enum('multicaixa','transferencia','cartao') NOT NULL,
  `status` enum('pendente','pago','falhou') DEFAULT 'pendente',
  `data_pagamento` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pagamentos`
--

INSERT INTO `pagamentos` (`id_pagamento`, `id_reserva`, `valor_pago`, `metodo`, `status`, `data_pagamento`) VALUES
(1, 1, 250000.00, 'multicaixa', 'pago', '2025-08-13 14:12:44'),
(2, 2, 80000.00, 'transferencia', 'pendente', '2025-08-13 14:12:44'),
(3, 3, 100000.00, 'cartao', 'pago', '2025-08-13 14:12:44');

-- --------------------------------------------------------

--
-- Estrutura da tabela `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `data_evento` date NOT NULL,
  `status` enum('pendente','confirmada','cancelada') DEFAULT 'pendente',
  `data_reserva` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `id_cliente`, `id_servico`, `data_evento`, `status`, `data_reserva`) VALUES
(1, 1, 1, '2025-09-15', 'confirmada', '2025-08-13 14:12:44'),
(2, 2, 3, '2025-10-10', 'pendente', '2025-08-13 14:12:44'),
(3, 1, 5, '2025-09-15', 'confirmada', '2025-08-13 14:12:44');

-- --------------------------------------------------------

--
-- Estrutura da tabela `servicos`
--

CREATE TABLE `servicos` (
  `id_servico` int(11) NOT NULL,
  `id_fornecedor` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text NOT NULL,
  `categoria` enum('salão de eventos','decoração','fotografia','buffet','outro') NOT NULL,
  `preco_base` decimal(10,2) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `status` enum('ativo','inativo') DEFAULT 'ativo',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `servicos`
--

INSERT INTO `servicos` (`id_servico`, `id_fornecedor`, `titulo`, `descricao`, `categoria`, `preco_base`, `cidade`, `bairro`, `status`, `data_criacao`) VALUES
(1, 3, 'Salão Lux 500 Pessoas', 'Salão climatizado para até 500 pessoas com estacionamento.', 'salão de eventos', 250000.00, 'Lubango', 'Centro', 'ativo', '2025-08-13 14:12:44'),
(2, 3, 'Salão VIP Jardim', 'Espaço ao ar livre com jardins e piscina.', 'salão de eventos', 300000.00, 'Lubango', 'Bairro da Nossa Senhora', 'ativo', '2025-08-13 14:12:44'),
(3, 4, 'Decoração Clássica', 'Decoração elegante com flores e luzes.', 'decoração', 80000.00, 'Lubango', 'Santo António', 'ativo', '2025-08-13 14:12:44'),
(4, 4, 'Decoração Temática', 'Decoração personalizada conforme o tema do evento.', 'decoração', 120000.00, 'Lubango', 'Centro', 'ativo', '2025-08-13 14:12:44'),
(5, 5, 'Pacote Fotografia Premium', 'Cobertura completa com álbum impresso e fotos digitais.', 'fotografia', 100000.00, 'Lubango', 'Centro', 'ativo', '2025-08-13 14:12:44'),
(6, 7, 'Atendente de bar e lojas', 'Podes agendar servicos neste quintal e manter tudo legal', 'decoração', 123000.00, 'Lubango', 'Comercial', 'ativo', '2025-08-28 14:22:31'),
(7, 7, 'Decorador profissional', 'Podes agendar servicos neste quintal e manter tudo legal', 'decoração', 123000.00, 'Lubango', 'Comercial', 'ativo', '2025-08-28 14:23:28'),
(8, 7, 'Decorador profissional e ativo', 'Podes agendar servicos neste quintal e manter tudo legal', 'decoração', 123000.00, 'Lubango', 'Comercial', 'ativo', '2025-08-28 14:23:38');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `tipo` enum('cliente','fornecedor','admin') NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nome`, `email`, `senha_hash`, `telefone`, `tipo`, `data_cadastro`) VALUES
(1, 'Ana Silva', 'ana@email.com', 'hash123', '923456789', 'cliente', '2025-08-13 14:12:44'),
(2, 'Carlos Mendes', 'carlos@email.com', 'hash123', '924567890', 'cliente', '2025-08-13 14:12:44'),
(3, 'Espaço Lux Eventos', 'lux@eventos.com', 'hash123', '922345678', 'fornecedor', '2025-08-13 14:12:44'),
(4, 'Decorações Bela Festa', 'bela@decor.com', 'hash123', '923987654', 'fornecedor', '2025-08-13 14:12:44'),
(5, 'João Fotografia', 'joao@foto.com', 'hash123', '921234567', 'fornecedor', '2025-08-13 14:12:44'),
(6, 'Admin Site', 'admin@casamento.com', 'hashadmin', '900000000', 'admin', '2025-08-13 14:12:44'),
(7, 'Nauro Elias Hutambala', 'nauro@gmail.com', '$2y$10$si6sEWwKBsRKQozdELgpVeGBVkhBSQtt7uH3P0B4iCIg/3JwveDu2', '924595755', 'cliente', '2025-08-16 12:44:23'),
(8, 'Mateus pilha', 'naur@gmail.com', '$2y$10$zBlvqXBuPJkWx1S0fpl3i.HhPzX85yuhhjzkXgh.bOcpvw083alzS', '924595755', 'fornecedor', '2025-08-16 14:46:38'),
(9, 'Nauro Elias Hutambala', 'nauro1@gmail.com', '$2y$10$TEipgc7WU51X9byneBTh2.ENurTFl.npYuqnOkcvwQyva25lwwrB6', '924595755', 'fornecedor', '2025-08-17 16:03:01');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  ADD PRIMARY KEY (`id_avaliacao`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_servico` (`id_servico`);

--
-- Índices para tabela `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_chat` (`usuario_id`,`fornecedor_id`);

--
-- Índices para tabela `chat_mensagens`
--
ALTER TABLE `chat_mensagens`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `fotos_servico`
--
ALTER TABLE `fotos_servico`
  ADD PRIMARY KEY (`id_foto`),
  ADD KEY `id_servico` (`id_servico`);

--
-- Índices para tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`id_pagamento`),
  ADD KEY `id_reserva` (`id_reserva`);

--
-- Índices para tabela `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_servico` (`id_servico`);

--
-- Índices para tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id_servico`),
  ADD KEY `id_fornecedor` (`id_fornecedor`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  MODIFY `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `chat_mensagens`
--
ALTER TABLE `chat_mensagens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fotos_servico`
--
ALTER TABLE `fotos_servico`
  MODIFY `id_foto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `id_pagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id_servico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  ADD CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`);

--
-- Limitadores para a tabela `fotos_servico`
--
ALTER TABLE `fotos_servico`
  ADD CONSTRAINT `fotos_servico_ibfk_1` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`);

--
-- Limitadores para a tabela `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`);

--
-- Limitadores para a tabela `servicos`
--
ALTER TABLE `servicos`
  ADD CONSTRAINT `servicos_ibfk_1` FOREIGN KEY (`id_fornecedor`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
