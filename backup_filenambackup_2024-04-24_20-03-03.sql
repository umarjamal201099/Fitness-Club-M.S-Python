-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: umar
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer_workout_plans`
--

DROP TABLE IF EXISTS `customer_workout_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_workout_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `workout_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_workout_plans`
--

LOCK TABLES `customer_workout_plans` WRITE;
/*!40000 ALTER TABLE `customer_workout_plans` DISABLE KEYS */;
INSERT INTO `customer_workout_plans` VALUES (7,10,'2024-04-17 12:27:54',4),(8,8,'2024-04-17 12:28:07',4),(9,10,'2024-04-17 12:39:18',4),(10,10,'2024-04-17 12:57:39',4),(11,8,'2024-04-17 13:01:17',3),(12,8,'2024-04-17 13:05:53',3),(13,8,'2024-04-17 13:28:40',3),(14,8,'2024-04-17 13:32:14',3),(15,8,'2024-04-17 13:34:22',3),(16,8,'2024-04-17 13:37:21',3),(17,8,'2024-04-17 13:37:45',3),(18,8,'2024-04-17 13:38:20',3),(19,8,'2024-04-17 13:46:29',3),(20,8,'2024-04-17 13:48:44',3),(21,8,'2024-04-17 13:53:49',3),(22,8,'2024-04-17 13:57:32',3),(23,8,'2024-04-17 13:59:21',3),(24,8,'2024-04-17 13:59:40',3),(25,8,'2024-04-17 14:01:05',3),(26,8,'2024-04-17 14:09:48',3),(27,8,'2024-04-17 14:10:03',3),(28,8,'2024-04-17 14:11:08',3),(29,8,'2024-04-17 14:11:27',3),(30,8,'2024-04-17 14:12:35',3),(31,8,'2024-04-17 14:12:49',3),(32,8,'2024-04-17 14:12:55',3),(33,8,'2024-04-17 14:16:07',3),(34,8,'2024-04-17 14:16:26',3),(35,8,'2024-04-17 14:17:40',3),(36,8,'2024-04-18 05:20:59',3),(38,8,'2024-04-19 15:39:03',31),(39,10,'2024-04-19 15:39:14',31),(40,8,'2024-04-19 15:39:55',3),(41,10,'2024-04-19 15:53:39',29),(42,8,'2024-04-19 15:56:51',3);
/*!40000 ALTER TABLE `customer_workout_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `waist` float DEFAULT NULL,
  `workout` varchar(45) DEFAULT NULL,
  `goal` varchar(100) DEFAULT NULL,
  `registration_date` time DEFAULT NULL,
  `workout_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `fk_workout_id` (`workout_id`),
  CONSTRAINT `fk_workout_id` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`workout_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (8,'Muhammad ali','ali@gmail.com','03007927170',5,55,32,'leg','runner',NULL,21),(10,'Umar Jamal Rasheed','umarjamal201099@gmail.com','03006917248',5,77,55,'3','racce',NULL,NULL),(12,'Muhammad Ashraf','abid70213@gmail.com','03007927134',22,60,33,'29','fit',NULL,NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duefees`
--

DROP TABLE IF EXISTS `duefees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `duefees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `duefees_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duefees`
--

LOCK TABLES `duefees` WRITE;
/*!40000 ALTER TABLE `duefees` DISABLE KEYS */;
INSERT INTO `duefees` VALUES (1,10,1000.00,'2024-04-19');
/*!40000 ALTER TABLE `duefees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'dumble',50.00);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses` (
  `expense_id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `instructor_id` int DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  PRIMARY KEY (`expense_id`),
  KEY `customer_id` (`customer_id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `equipment_id` (`equipment_id`),
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`),
  CONSTRAINT `expenses_ibfk_3` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructors` (
  `instructor_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `qualification` varchar(100) NOT NULL,
  `timings` varchar(100) NOT NULL,
  KEY `manager_id_idx` (`instructor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT INTO `instructors` VALUES (3,'Umar Jamal Rasheed','umarjamal201099@gmail.com','03006917250','bscs','30min'),(5,'Muhammad Ashraf','abid70213@gmail.com','03007927134','fa','40min'),(8,'Umar Jamal Rasheed','umarjamal201099@gmail.com','03006917248','cs','10'),(9,'Umar Jamal Rasheed','umarjamal201099@gmail.com','03006917248','cd','44');
/*!40000 ALTER TABLE `instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,8,1000.00,'2024-04-19'),(2,8,1000.00,'2024-04-18');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) DEFAULT NULL,
  `rental_date` date DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `fk_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (2,10000.00,'2024-04-19',1);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `report_type` varchar(255) DEFAULT NULL,
  `data` text,
  `report_date` date DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,'Weight','Muhammad ali: 55.0','2024-04-22'),(2,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(3,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(4,'Weight','Muhammad ali: 55.0','2024-04-22'),(5,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(6,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(7,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(8,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(9,'Due Fees','Customer ID: 10, Amount: 1000.00','2024-04-22'),(10,'Salary','Instructor ID: 3, Amount: 5000.00','2024-04-22'),(11,'Weight','Muhammad ali: 55.0','2024-04-22'),(12,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(13,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(14,'Weight','Muhammad ali: 55.0','2024-04-22'),(15,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(16,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(17,'Weight','Muhammad ali: 55.0','2024-04-22'),(18,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(19,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(20,'Weight','Muhammad ali: 55.0','2024-04-22'),(21,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(22,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(23,'Weight','Muhammad ali: 55.0','2024-04-22'),(24,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(25,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(26,'Weight','Muhammad ali: 55.0','2024-04-22'),(27,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(28,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(29,'Weight','Muhammad ali: 55.0','2024-04-22'),(30,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(31,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(32,'Weight','Muhammad ali: 55.0','2024-04-22'),(33,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(34,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(35,'Weight','Muhammad ali: 55.0','2024-04-22'),(36,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(37,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(38,'Weight','Muhammad ali: 55.0','2024-04-22'),(39,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(40,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(41,'Weight','Muhammad ali: 55.0','2024-04-22'),(42,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(43,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(44,'Weight','Muhammad ali: 55.0','2024-04-22'),(45,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(46,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(47,'Weight','Muhammad ali: 55.0','2024-04-22'),(48,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(49,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(50,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(51,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(52,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(53,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(54,'Weight','Muhammad ali: 55.0','2024-04-22'),(55,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(56,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(57,'Weight','Muhammad ali: 55.0','2024-04-22'),(58,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(59,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(60,'Weight','Muhammad ali: 55.0','2024-04-22'),(61,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(62,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(63,'Weight','Muhammad ali: 55.0','2024-04-22'),(64,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(65,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(66,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(67,'Fee','Customer ID: 8, Amount: 1000.00','2024-04-22'),(68,'Weight','Muhammad ali: 55.0','2024-04-22'),(69,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(70,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(71,'Weight','Muhammad ali: 55.0','2024-04-22'),(72,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(73,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(74,'Weight','Muhammad ali: 55.0','2024-04-22'),(75,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(76,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(77,'Weight','Muhammad ali: 55.0','2024-04-22'),(78,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(79,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(80,'Weight','Muhammad ali: 55.0','2024-04-22'),(81,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(82,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(83,'Weight','Muhammad ali: 55.0','2024-04-22'),(84,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(85,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(86,'Weight','Muhammad ali: 55.0','2024-04-22'),(87,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(88,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(89,'Weight','Muhammad ali: 55.0','2024-04-22'),(90,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(91,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(92,'Weight','Muhammad ali: 55.0','2024-04-22'),(93,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(94,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(95,'Weight','Muhammad ali: 55.0','2024-04-22'),(96,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(97,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(98,'Weight','Muhammad ali: 55.0','2024-04-22'),(99,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(100,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(101,'Weight','Muhammad ali: 55.0','2024-04-22'),(102,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(103,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(104,'Weight','Muhammad ali: 55.0','2024-04-22'),(105,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(106,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(107,'Weight','Muhammad ali: 55.0','2024-04-22'),(108,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(109,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(110,'Weight','Muhammad ali: 55.0','2024-04-22'),(111,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(112,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(113,'Weight','Muhammad ali: 55.0','2024-04-22'),(114,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(115,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(116,'Weight','Muhammad ali: 55.0','2024-04-22'),(117,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(118,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(119,'Weight','Muhammad ali: 55.0','2024-04-22'),(120,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(121,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(122,'Weight','Muhammad ali: 55.0','2024-04-22'),(123,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(124,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(125,'Weight','Muhammad ali: 55.0','2024-04-22'),(126,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(127,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(128,'Weight','Muhammad ali: 55.0','2024-04-22'),(129,'Weight','Umar Jamal Rasheed: 77.0','2024-04-22'),(130,'Weight','Muhammad Ashraf: 60.0','2024-04-22'),(131,'Weight','Muhammad ali: 55.0','2024-04-23'),(132,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(133,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(134,'Weight','Muhammad ali: 55.0','2024-04-23'),(135,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(136,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(137,'Weight','Muhammad ali: 55.0','2024-04-23'),(138,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(139,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(140,'Weight','Muhammad ali: 55.0','2024-04-23'),(141,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(142,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(143,'Weight','Muhammad ali: 55.0','2024-04-23'),(144,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(145,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(146,'Weight','Muhammad ali: 55.0','2024-04-23'),(147,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(148,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(149,'Weight','Muhammad ali: 55.0','2024-04-23'),(150,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(151,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(152,'Weight','Muhammad ali: 55.0','2024-04-23'),(153,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(154,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(155,'Weight','Muhammad ali: 55.0','2024-04-23'),(156,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(157,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(158,'Weight','Muhammad ali: 55.0','2024-04-23'),(159,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(160,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(161,'Weight','Muhammad ali: 55.0','2024-04-23'),(162,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(163,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(164,'Weight','Muhammad ali: 55.0','2024-04-23'),(165,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(166,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(167,'Weight','Muhammad ali: 55.0','2024-04-23'),(168,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(169,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(170,'Weight','Muhammad ali: 55.0','2024-04-23'),(171,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(172,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(173,'Weight','Muhammad ali: 55.0','2024-04-23'),(174,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(175,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(176,'Weight','Muhammad ali: 55.0','2024-04-23'),(177,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(178,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(179,'Due Fees','Customer ID: 10, Amount: 1000.00','2024-04-23'),(180,'Weight','Muhammad ali: 55.0','2024-04-23'),(181,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(182,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(183,'Weight','Muhammad ali: 55.0','2024-04-23'),(184,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(185,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(186,'Profit','Profit: 2000.00','2024-04-23'),(187,'Profit','Profit: 2000.00','2024-04-23'),(188,'Weight','Muhammad ali: 55.0','2024-04-23'),(189,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(190,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(191,'Weight','Muhammad ali: 55.0','2024-04-23'),(192,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(193,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(194,'Weight','Muhammad ali: 55.0','2024-04-23'),(195,'Weight','Umar Jamal Rasheed: 77.0','2024-04-23'),(196,'Weight','Muhammad Ashraf: 60.0','2024-04-23'),(197,'Weight','Muhammad ali: 55.0','2024-04-24'),(198,'Weight','Umar Jamal Rasheed: 77.0','2024-04-24'),(199,'Weight','Muhammad Ashraf: 60.0','2024-04-24');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries`
--

DROP TABLE IF EXISTS `salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salaries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instructor_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `salary_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_id` (`instructor_id`),
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (1,3,5000.00,'2024-04-19');
/*!40000 ALTER TABLE `salaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'manager','manager');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_categories`
--

DROP TABLE IF EXISTS `workout_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_categories`
--

LOCK TABLES `workout_categories` WRITE;
/*!40000 ALTER TABLE `workout_categories` DISABLE KEYS */;
INSERT INTO `workout_categories` VALUES (1,'Cardio'),(2,'Strength Training'),(3,'Yoga'),(4,'HIIT (High-Intensity Interval Training)'),(5,'Flexibility');
/*!40000 ALTER TABLE `workout_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workouts`
--

DROP TABLE IF EXISTS `workouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workouts` (
  `workout_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `instructor_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`workout_id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `workout_categories` (`category_id`),
  CONSTRAINT `workouts_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workouts`
--

LOCK TABLES `workouts` WRITE;
/*!40000 ALTER TABLE `workouts` DISABLE KEYS */;
INSERT INTO `workouts` VALUES (3,'workout3',NULL,NULL),(4,'workout4',NULL,NULL),(9,'workout1',NULL,NULL),(21,'Circuit Training',NULL,2),(22,'Vinyasa Flow',NULL,3),(23,'Tabata Workout',NULL,4),(24,'Stretching Routine',NULL,5),(26,'Weightlifting Session',NULL,2),(28,'Bodyweight HIIT',NULL,4),(29,'Pilates',NULL,5),(30,'Workout6',NULL,NULL);
/*!40000 ALTER TABLE `workouts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-24 20:04:54
