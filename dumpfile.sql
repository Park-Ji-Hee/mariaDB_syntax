-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `addres` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `rolerole` varchar(255) DEFAULT NULL,
  `birth_day2` date DEFAULT NULL,
  `created_time2` datetime DEFAULT current_timestamp(),
  `post_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'abc','abc@test.com',NULL,NULL,12,NULL,NULL,NULL,NULL,NULL,NULL,2),
(2,'b','abc@naver.com',NULL,NULL,24,NULL,NULL,NULL,NULL,NULL,NULL,0),
(3,'a','',NULL,NULL,36,NULL,NULL,NULL,NULL,NULL,NULL,0),
(4,'a','',NULL,NULL,48,NULL,NULL,NULL,NULL,NULL,NULL,0),
(5,'a','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),
(7,'지구과학','aaa@naver.com',NULL,NULL,NULL,NULL,NULL,'1999-05-01 12:01:00',NULL,NULL,NULL,0),
(8,NULL,'aaa@naver.com',NULL,NULL,NULL,NULL,NULL,'1999-05-01 12:01:00',NULL,NULL,NULL,0),
(9,'jihee','',NULL,NULL,NULL,NULL,NULL,'2024-05-17 20:09:56',NULL,'1999-04-03',NULL,0),
(10,'jihee','',NULL,NULL,NULL,NULL,NULL,'2024-05-17 20:17:41',NULL,'1999-04-03',NULL,0),
(11,'jihee','',NULL,NULL,NULL,NULL,NULL,'2024-05-17 20:19:11',NULL,'1999-04-03',NULL,0),
(12,NULL,'aaa@naver.com',NULL,NULL,NULL,NULL,NULL,'2024-05-17 20:23:59',NULL,NULL,'1999-05-01 12:01:00',0),
(13,'jihee2','',NULL,NULL,NULL,NULL,NULL,'2024-05-17 20:33:03',NULL,NULL,NULL,0),
(14,NULL,'aaa@naver.com',NULL,NULL,NULL,NULL,NULL,'2024-05-17 12:36:59',NULL,NULL,NULL,0),
(15,NULL,'aoo@naver.com',NULL,NULL,NULL,NULL,NULL,'2024-05-17 20:37:48',NULL,NULL,'2024-05-17 20:37:48',0),
(16,NULL,'ed@naver.com',NULL,NULL,NULL,NULL,NULL,'2024-05-17 21:25:50','글자',NULL,'2024-05-17 21:25:50',0),
(17,NULL,'hello@naver.com',NULL,NULL,NULL,NULL,NULL,'2024-05-18 01:32:07',NULL,NULL,'2024-05-18 01:32:07',0),
(18,'kim','kil@naver.com',NULL,NULL,NULL,NULL,NULL,'2024-05-20 15:39:16',NULL,NULL,'2024-05-20 15:39:16',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_time2` datetime DEFAULT NULL,
  `contents` varchar(255) DEFAULT NULL,
  `use_id` char(36) DEFAULT uuid(),
  `new_author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello','hello world',NULL,1000.000,'2023-05-01 00:00:00',NULL,NULL,'0cf1eeec-146c-11ef-93ce-8cb0e9d85025',NULL),
(2,'hello','abc',1,2000.000,'2023-05-30 00:00:00',NULL,NULL,'0cf1f08b-146c-11ef-93ce-8cb0e9d85025',NULL),
(4,'g','ghi',3,5000.000,'2024-12-11 00:00:00',NULL,NULL,'0cf1f0fe-146c-11ef-93ce-8cb0e9d85025',NULL),
(5,'j','jkl',3,9000.000,'2022-09-05 00:00:00',NULL,NULL,'0cf1f15a-146c-11ef-93ce-8cb0e9d85025',NULL),
(6,'m','mno',5,10000.000,NULL,NULL,NULL,'0cf1f1d2-146c-11ef-93ce-8cb0e9d85025',NULL),
(7,'hello',NULL,NULL,12.123,NULL,NULL,NULL,'0cf1f240-146c-11ef-93ce-8cb0e9d85025',NULL),
(8,'mango',NULL,NULL,NULL,NULL,'1999-05-01 12:01:00',NULL,'0cf1f295-146c-11ef-93ce-8cb0e9d85025',NULL),
(13,'hello world java',NULL,5,NULL,NULL,NULL,NULL,'a8831598-166a-11ef-93ce-8cb0e9d85025',NULL),
(14,'hello world java',NULL,5,NULL,NULL,NULL,NULL,'c5c090d7-166a-11ef-93ce-8cb0e9d85025',NULL),
(15,'hello world java',NULL,5,NULL,NULL,NULL,NULL,'d93b2019-166a-11ef-93ce-8cb0e9d85025',NULL),
(16,'hello world java',NULL,5,NULL,NULL,NULL,NULL,'1db18cb4-166b-11ef-93ce-8cb0e9d85025',NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 17:29:52
