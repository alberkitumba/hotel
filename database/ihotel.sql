-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: hotel
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `funcao` text DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,'Gerente Geral','Gerenciar ├íreas do hotel de uma forma sistem├ítica e un├¡stica, olhando o hotel como um todo','2022-05-13'),(2,'Recepcionista','Registrar a entrada e sa├¡da dos hospedes, dar suporte aos hospedes, atender o telefone, cuidar da recep├º├úo como um todo, zelar pelo bem-estar dos hospedes','2022-05-13'),(3,'Governan├ºa','Fazer com que os hospedes se sintam em casa mesmo estando fora dela, cuida da higiene, do asseio do ambiente deixando tudo organizado e visivelmente bonito para receber os hospedes','2022-05-13');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `bi` varchar(14) DEFAULT NULL,
  `genero` enum('Masculino','Femenino') NOT NULL,
  `contacto` varchar(20) DEFAULT NULL,
  `endereco` tinytext DEFAULT NULL,
  `avatar` varchar(225) DEFAULT NULL,
  `salario` decimal(10,2) NOT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  `cargo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `bi` (`bi`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `funcionarios_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (1,'Hello World','12wm82j303is82','Masculino','987654321','Viana, Estalagem',NULL,80000.00,'2022-05-13',2),(2,'Lorem Ipsum','wearefireuknow','Femenino','1234567890','Luanda, Angola',NULL,50000.00,'2022-05-13',NULL),(4,'Rema','dayonedaytwo','Masculino','999999999','Heart',NULL,100000.00,'2022-05-14',1);
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospedes`
--

DROP TABLE IF EXISTS `hospedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `contacto` varchar(20) DEFAULT NULL,
  `bi` varchar(14) DEFAULT NULL,
  `genero` enum('Masculino','Femenino') NOT NULL,
  `tipo_hospede` int(11) NOT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `bi` (`bi`),
  KEY `tipo_hospede` (`tipo_hospede`),
  CONSTRAINT `hospedes_ibfk_1` FOREIGN KEY (`tipo_hospede`) REFERENCES `tipos_hospedes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospedes`
--

LOCK TABLES `hospedes` WRITE;
/*!40000 ALTER TABLE `hospedes` DISABLE KEYS */;
INSERT INTO `hospedes` VALUES (4,'Remaa','987654321','calmdown','Masculino',2,'2022-05-13'),(5,'Adele','123123123','someonelikeyou','Femenino',3,'2022-05-13'),(6,'RMINDR','924439071','reminderslowdo','Masculino',3,'2022-05-14'),(7,'Juice WRLD','999','legendsneverdi','Masculino',1,'2022-05-14');
/*!40000 ALTER TABLE `hospedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reserva_id` int(11) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) DEFAULT 0.00,
  `montante` decimal(10,2) NOT NULL,
  `troco` decimal(10,2) DEFAULT (`montante` - (`valor` - `desconto`)),
  `atendente_id` int(11) DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `reserva_id` (`reserva_id`),
  KEY `atendente_id` (`atendente_id`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`),
  CONSTRAINT `pagamentos_ibfk_2` FOREIGN KEY (`atendente_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartos`
--

DROP TABLE IF EXISTS `quartos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `codigo` varchar(7) DEFAULT NULL,
  `ocupado` enum('Sim','Nao') DEFAULT 'Nao',
  `dimensao` varchar(50) DEFAULT NULL,
  `tipo_quarto` int(11) DEFAULT NULL,
  `descricao` tinytext DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `numero` (`numero`),
  KEY `tipo_quarto` (`tipo_quarto`),
  CONSTRAINT `quartos_ibfk_1` FOREIGN KEY (`tipo_quarto`) REFERENCES `tipos_quartos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartos`
--

LOCK TABLES `quartos` WRITE;
/*!40000 ALTER TABLE `quartos` DISABLE KEYS */;
INSERT INTO `quartos` VALUES (2,20,'REMA ├® ','Nao','4m x 6m',2,'Another Banger','2022-05-14'),(3,2,'Neymar ','Sim','20m x 10m',1,'Calm down follow down','2022-05-14');
/*!40000 ALTER TABLE `quartos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(7) DEFAULT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NOT NULL,
  `status` varchar(12) DEFAULT 'Activa',
  `quarto_id` int(11) DEFAULT NULL,
  `hospede_id` int(11) DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `quarto_id` (`quarto_id`),
  KEY `hospede_id` (`hospede_id`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`quarto_id`) REFERENCES `quartos` (`id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`hospede_id`) REFERENCES `hospedes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (2,'999','2022-05-18','2022-06-08','Activa',3,4,'2022-05-14'),(3,'123123','2022-05-19','2022-05-17','Cancelada',2,4,'2022-05-14');
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas_servicos`
--

DROP TABLE IF EXISTS `reservas_servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservas_servicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reserva_id` int(11) NOT NULL,
  `servico_id` int(11) NOT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `reserva_id` (`reserva_id`),
  KEY `servico_id` (`servico_id`),
  CONSTRAINT `reservas_servicos_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`),
  CONSTRAINT `reservas_servicos_ibfk_2` FOREIGN KEY (`servico_id`) REFERENCES `servicos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas_servicos`
--

LOCK TABLES `reservas_servicos` WRITE;
/*!40000 ALTER TABLE `reservas_servicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservas_servicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicos`
--

DROP TABLE IF EXISTS `servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descrisao` text DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `quantidade` int(4) DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) DEFAULT (`valor` * `quantidade`),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicos`
--

LOCK TABLES `servicos` WRITE;
/*!40000 ALTER TABLE `servicos` DISABLE KEYS */;
INSERT INTO `servicos` VALUES (2,'Wow','Hmm',150.00,1,'2022-05-14',150.00),(3,'Area','Muito Cuiuio',70.00,1,'2022-05-14',90.00);
/*!40000 ALTER TABLE `servicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_hospedes`
--

DROP TABLE IF EXISTS `tipos_hospedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_hospedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_hospedes`
--

LOCK TABLES `tipos_hospedes` WRITE;
/*!40000 ALTER TABLE `tipos_hospedes` DISABLE KEYS */;
INSERT INTO `tipos_hospedes` VALUES (1,'Normal','2022-05-13'),(2,'Frequente','2022-05-13'),(3,'VIP','2022-05-13');
/*!40000 ALTER TABLE `tipos_hospedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_quartos`
--

DROP TABLE IF EXISTS `tipos_quartos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_quartos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `valor_por_noite` decimal(10,2) DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_quartos`
--

LOCK TABLES `tipos_quartos` WRITE;
/*!40000 ALTER TABLE `tipos_quartos` DISABLE KEYS */;
INSERT INTO `tipos_quartos` VALUES (1,'Normal',2000.00,'2022-05-13'),(2,'Suite Executiva',20000.00,'2022-05-13'),(3,'Suite De Luxo',25000.00,'2022-05-13'),(4,'Suite De Lua De Mel',50000.00,'2022-05-13');
/*!40000 ALTER TABLE `tipos_quartos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_usuarios`
--

DROP TABLE IF EXISTS `tipos_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_usuarios`
--

LOCK TABLES `tipos_usuarios` WRITE;
/*!40000 ALTER TABLE `tipos_usuarios` DISABLE KEYS */;
INSERT INTO `tipos_usuarios` VALUES (1,'admin','2022-05-13'),(2,'normal','2022-05-13');
/*!40000 ALTER TABLE `tipos_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(225) NOT NULL,
  `funcionario_id` int(11) DEFAULT NULL,
  `tipo_usuario` int(11) DEFAULT NULL,
  `criado_em` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `funcionario_id` (`funcionario_id`),
  KEY `tipo_usuario` (`tipo_usuario`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id`),
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`tipo_usuario`) REFERENCES `tipos_usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'imtatic','imtatic',1,1,'2022-05-13'),(3,'rema','123',1,2,'2022-05-14');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-20  0:24:12
