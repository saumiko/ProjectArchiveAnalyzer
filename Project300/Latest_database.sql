-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: localhost    Database: sust_archive
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_code` varchar(30) NOT NULL,
  `course_title` varchar(30) NOT NULL,
  `credit` double NOT NULL,
  `semester` int(11) NOT NULL,
  `session` int(11) NOT NULL,
  `offering_dept` varchar(30) NOT NULL,
  `accepting_dept` varchar(30) NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_unique` (`course_code`,`offering_dept`,`accepting_dept`,`session`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'CSE 300','Project 300',2,6,2011,'1','1'),(2,'CSE 361','Networking',3,6,2011,'1','1'),(3,'CSE 331','Software Engineering',3,6,2011,'1','1'),(4,'CSE 300','Project 300',2,6,2012,'1','1');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_registration`
--

DROP TABLE IF EXISTS `course_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_registration` (
  `course_reg_id` bigint(20) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `marks` double NOT NULL,
  `GPA` double DEFAULT NULL,
  PRIMARY KEY (`course_reg_id`),
  UNIQUE KEY `course_reg_unique` (`student_id`,`course_id`),
  KEY `course_course_reg_fk` (`course_id`),
  CONSTRAINT `course_course_reg_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `student_course_reg_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_registration`
--

LOCK TABLES `course_registration` WRITE;
/*!40000 ALTER TABLE `course_registration` DISABLE KEYS */;
INSERT INTO `course_registration` VALUES (1,1,1,1,0,0),(2,2,1,1,0,0),(3,3,1,1,0,0),(4,4,1,1,0,0),(5,5,1,1,0,0),(6,6,1,1,0,0),(7,7,1,1,0,0),(8,8,1,1,0,0),(9,9,1,1,0,0),(10,10,1,1,0,0),(11,11,1,1,0,0),(12,12,1,1,0,0),(13,13,1,1,0,0),(14,14,1,1,0,0),(15,15,1,1,0,0),(16,1,2,1,0,0),(17,2,2,1,0,0),(18,3,2,1,0,0),(19,4,2,1,0,0),(20,5,2,1,0,0),(21,6,2,1,0,0),(22,7,2,1,0,0),(23,8,2,1,0,0),(24,9,2,1,0,0),(25,10,2,1,0,0),(26,11,2,1,0,0),(27,12,2,1,0,0),(28,13,2,1,0,0),(29,14,2,1,0,0),(30,15,2,1,0,0);
/*!40000 ALTER TABLE `course_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_task`
--

DROP TABLE IF EXISTS `course_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_task` (
  `course_task_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `exam_committee_id` int(11) NOT NULL,
  PRIMARY KEY (`course_task_id`),
  KEY `exam_committee_course_task_fk` (`exam_committee_id`),
  KEY `task_course_task_fk` (`task_id`),
  KEY `course_course_task_fk` (`course_id`),
  CONSTRAINT `course_course_task_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `exam_committee_course_task_fk` FOREIGN KEY (`exam_committee_id`) REFERENCES `exam_committee` (`exam_committee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `task_course_task_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_task`
--

LOCK TABLES `course_task` WRITE;
/*!40000 ALTER TABLE `course_task` DISABLE KEYS */;
INSERT INTO `course_task` VALUES (1,1,1,1),(2,2,2,1),(3,3,3,1),(4,1,4,1),(6,4,6,2);
/*!40000 ALTER TABLE `course_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(60) NOT NULL,
  `dept_code` varchar(30) NOT NULL,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `department_unique` (`dept_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Science and Engineering','CSE'),(2,'Electrical & Electronic Engineering','EEE'),(3,'Industrial Production and Engineering','IPE'),(4,'Physics','PHY'),(5,'Genetic Engineering and Biotechnology','GEB');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designation`
--

DROP TABLE IF EXISTS `designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designation` (
  `desig_id` int(11) NOT NULL AUTO_INCREMENT,
  `desig_name` varchar(50) NOT NULL,
  `desig_desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`desig_id`),
  UNIQUE KEY `designation_unique` (`desig_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designation`
--

LOCK TABLES `designation` WRITE;
/*!40000 ALTER TABLE `designation` DISABLE KEYS */;
INSERT INTO `designation` VALUES (1,'Professor','No description available'),(2,'Assistant Professor','No description available'),(3,'Lecturer','No description available');
/*!40000 ALTER TABLE `designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam` (
  `exam_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usn_no` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `exam_start` varchar(30) NOT NULL,
  `exam_end` varchar(30) NOT NULL,
  `reg_start` varchar(30) NOT NULL,
  `reg_end` varchar(30) NOT NULL,
  PRIMARY KEY (`exam_id`),
  UNIQUE KEY `exam_unique` (`usn_no`,`dept_id`),
  KEY `department_exam_fk` (`dept_id`),
  CONSTRAINT `department_exam_fk` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` VALUES (1,1,1,'2014-12-01','2014-12-15','2014-11-01','2014-11-25');
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_committee`
--

DROP TABLE IF EXISTS `exam_committee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_committee` (
  `exam_committee_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` bigint(20) NOT NULL,
  `session` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `chairman_id` int(11) NOT NULL,
  `start_Date` varchar(30) NOT NULL,
  `end_date` varchar(30) NOT NULL,
  PRIMARY KEY (`exam_committee_id`),
  UNIQUE KEY `exam_committee_unique` (`exam_id`,`session`),
  CONSTRAINT `exam_exam_committee_fk` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_committee`
--

LOCK TABLES `exam_committee` WRITE;
/*!40000 ALTER TABLE `exam_committee` DISABLE KEYS */;
INSERT INTO `exam_committee` VALUES (1,1,2011,6,1,'2014-07-01','2014-12-31'),(2,1,2012,6,1,'2014-06-01','2014-7-24');
/*!40000 ALTER TABLE `exam_committee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(30) NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_unique` (`group_name`,`task_id`),
  KEY `task_group_fk` (`task_id`),
  CONSTRAINT `task_group_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (16,'bQLAEOJ',1),(26,'ciX`BNG',2),(29,'f\\VgjbB',1),(21,'Hr`irEi',4),(22,'JKetQws',4),(20,'KAqFfjy',4),(11,'kCwLfGC',1),(23,'LQQbjab',4),(27,'NnyRcmD',2),(14,'qyQAvOW',2),(24,'uEW`U^w',6),(1,'Unnamed01',1),(3,'Unnamed03',1),(4,'Unnamed04',1),(5,'Unnamed05',1),(6,'Unnamed06',2),(7,'Unnamed07',2),(8,'Unnamed08',2),(9,'X`DiVNW',2),(25,'[XhYDhs',2),(28,'_\\mDjjb',2);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_title` varchar(60) NOT NULL,
  `project_desc` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'Bangla speech to text converter','No description available'),(2,'SUST Archives','No description available'),(3,'SUST Navigator 2.0','No description available'),(4,'Exam automation','No description available'),(5,'Multi chat messenger','No description available'),(6,'Restaurant point of sales','No description available'),(11,'Game Using Unity',''),(12,'Project_archive',''),(13,'Sust_aes','');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_group`
--

DROP TABLE IF EXISTS `project_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_group` (
  `project_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`project_group_id`),
  KEY `project_project_group_fk` (`project_id`),
  KEY `groups_project_group_fk` (`group_id`),
  CONSTRAINT `groups_project_group_fk` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `project_project_group_fk` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_group`
--

LOCK TABLES `project_group` WRITE;
/*!40000 ALTER TABLE `project_group` DISABLE KEYS */;
INSERT INTO `project_group` VALUES (1,1,1),(3,2,3),(4,3,4),(5,4,5),(6,5,6),(7,6,7),(8,6,8),(9,5,9),(11,1,11),(14,5,14),(16,1,16),(17,2,29);
/*!40000 ALTER TABLE `project_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_group_submit`
--

DROP TABLE IF EXISTS `project_group_submit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_group_submit` (
  `project_group_submit_id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_id` int(11) NOT NULL,
  `project_group_id` int(11) NOT NULL,
  PRIMARY KEY (`project_group_submit_id`),
  KEY `submission_project_group_submit_fk` (`submission_id`),
  KEY `project_group_project_group_submit_fk` (`project_group_id`),
  CONSTRAINT `project_group_project_group_submit_fk` FOREIGN KEY (`project_group_id`) REFERENCES `project_group` (`project_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `submission_project_group_submit_fk` FOREIGN KEY (`submission_id`) REFERENCES `submission` (`submission_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_group_submit`
--

LOCK TABLES `project_group_submit` WRITE;
/*!40000 ALTER TABLE `project_group_submit` DISABLE KEYS */;
INSERT INTO `project_group_submit` VALUES (3,3,3),(4,4,4),(5,5,3),(7,7,6),(8,8,7),(9,9,9),(10,10,9),(11,11,7),(12,12,7),(13,14,8),(14,15,8),(15,16,3),(16,17,3),(17,18,3);
/*!40000 ALTER TABLE `project_group_submit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tag`
--

DROP TABLE IF EXISTS `project_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_tag` (
  `project_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`project_tag_id`),
  KEY `tag_project_tag_fk` (`tag_id`),
  KEY `project_project_tag_fk` (`project_id`),
  CONSTRAINT `project_project_tag_fk` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tag_project_tag_fk` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tag`
--

LOCK TABLES `project_tag` WRITE;
/*!40000 ALTER TABLE `project_tag` DISABLE KEYS */;
INSERT INTO `project_tag` VALUES (1,3,1),(2,4,1),(3,5,1),(5,2,3),(6,2,6);
/*!40000 ALTER TABLE `project_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `registration_no` int(11) NOT NULL,
  `email_no` varchar(50) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `contact_no` varchar(30) NOT NULL,
  `Address` varchar(90) DEFAULT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `marital_status` varchar(30) DEFAULT NULL,
  `blood_group` varchar(30) DEFAULT NULL,
  `religion` varchar(30) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(30) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_idx_unique` (`registration_no`),
  KEY `department_student_fk` (`dept_id`),
  KEY `user_student_fk` (`user_id`),
  CONSTRAINT `department_student_fk` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_student_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,2011331001,'shafin.mahmud@student.sust.edu',1,'+8809999999999','Unknown','Sheikh Shafin','Mahmud','single','AB+','Islam','1990-01-01','male',5),(2,2011331002,'pranon@student.sust.edu',1,'+8809999999999','Unknown','Pranon','Rahman Khan','single','AB+','Islam','1990-01-01','male',6),(3,2011331003,'ahsankabir@student.sust.edu',1,'+8809999999999','Unknown','Ahsan','Kabir','married','AB+','Islam','1990-01-01','male',7),(4,2011331004,'saimon@student.sust.edu',1,'+8809999999999','Unknown','Sakhawat Hossain','Saimon','single','AB+','Islam','1990-01-01','male',8),(5,2011331005,'shuvanon_razik@student.sust.edu',1,'+8809999999999','Unknown','Shuvanon','Razik','single','AB+','Islam','1990-01-01','male',9),(6,2011331006,'fahim06@student.sust.edu',1,'+8809999999999','Unknown','Fahim','Rahman','single','AB+','Islam','1990-01-01','male',10),(7,2011331007,'niloy@student.sust.edu',1,'+8809999999999','Unknown','Assaduzzaman','Niloy','single','AB+','Islam','1990-01-01','male',11),(8,2011331008,'ibtida.phoenix@student.sust.edu',1,'+8809999999999','Unknown','Hasin Ibtida','Alam','single','AB+','Islam','1990-01-01','male',12),(9,2011331009,'biswajit@student.sust.edu',1,'+8809999999999','Unknown','Biswajit','Debnath','single','AB+','Hindu','1990-01-01','male',13),(10,2011331012,'shibbir@student.sust.edu',1,'+8809999999999','Unknown','Shibbir Ahmed','Osmani','married','AB+','Islam','1990-01-01','male',14),(11,2011331013,'tariqhasananjan@student.sust.edu',1,'+8809999999999','Unknown','Md.','Tariq Hasan','single','AB+','Islam','1990-01-01','male',15),(12,2011331015,'tanzira_najnin@student.sust.edu',1,'+8809999999999','Unknown','Tanzira','Najnin','single','AB+','Islam','1990-01-01','female',16),(13,2011331017,'sakibulmowla@student.sust.edu',1,'+8809999999999','Unknown','Sakibul','Mowla','single','AB+','Islam','1990-01-01','male',17),(14,2011331018,'ayon18@student.sust.edu',1,'+8809999999999','Unknown','Mohammad Ashfaq','Ur Rahman','single','AB+','Islam','1990-01-01','male',18),(15,2011331019,'sumaiyafahmida@student.sust.edu',1,'+8809999999999','Unknown','Sumaiya Fahmida','Chowdhury','single','AB+','Islam','1990-01-01','female',19);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_group`
--

DROP TABLE IF EXISTS `student_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_group` (
  `stud_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`stud_group_id`),
  KEY `groups_student_group_fk` (`group_id`),
  KEY `student_student_group_fk` (`student_id`),
  CONSTRAINT `groups_student_group_fk` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `student_student_group_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_group`
--

LOCK TABLES `student_group` WRITE;
/*!40000 ALTER TABLE `student_group` DISABLE KEYS */;
INSERT INTO `student_group` VALUES (11,1,6),(12,4,6),(13,7,7),(14,12,7),(15,14,8),(16,15,8),(22,8,4),(23,6,14),(24,5,14),(31,1,1),(32,2,1),(33,3,1),(34,4,1),(40,10,11),(41,5,11),(42,15,16),(53,1,9),(54,15,9),(55,6,3),(56,7,3),(59,12,5),(60,9,29);
/*!40000 ALTER TABLE `student_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission`
--

DROP TABLE IF EXISTS `submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission` (
  `submission_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_student` varchar(90) DEFAULT NULL,
  `submission_ver` int(11) DEFAULT NULL,
  `comment_teacher` varchar(80) DEFAULT NULL,
  `submission_time` varchar(40) NOT NULL,
  `submission_url` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`submission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission`
--

LOCK TABLES `submission` WRITE;
/*!40000 ALTER TABLE `submission` DISABLE KEYS */;
INSERT INTO `submission` VALUES (1,'No comments',1,'No comments','2015-03-17 15-25-00','dummy url 1'),(2,'No comments',1,'No comments','2015-03-18 12-00-00','dummy url 2'),(3,'No comments',1,'No comments','2015-03-18 12-00-00','dummy url 3'),(4,'No comments',1,'No comments','2015-04-10 19-20-00','dummy url 4'),(5,'No comments',1,'No comments','2015-04-10 19-25-00','dummy url 5'),(6,'No comments',1,'No comments','2015-04-10 19-27-00','dummy url 6'),(7,'No comments',1,'No comments','2015-05-05 11-50-00','dummy url 7'),(8,'No comments',1,'No comments','2015-05-08 20-15-00','dummy url 8'),(9,NULL,NULL,'ima','06/01/2015 12:00:00',NULL),(10,NULL,NULL,'dada','06/01/2015 12:00:00',NULL),(11,NULL,NULL,'','06/01/2015 12:00:00',NULL),(12,NULL,NULL,'','06/01/2015 12:00:00',NULL),(13,NULL,NULL,'','06/01/2015 12:00:00','vgcfPsJ060120151200002'),(14,NULL,NULL,'the two','06/01/2015 12:00:00','OhyGTdb060120151200008'),(15,NULL,NULL,'the three','06/01/2015 12:00:00','gJIHOlO060120151200008'),(16,NULL,NULL,'the third','08/06/2016 9:46','XVSqHb_080620169463'),(17,NULL,NULL,'The fourth','8.6.2016 4:37 pm','PtDbYDZ8620164373'),(18,NULL,NULL,'The fifth','06/01/2015 12:00:00','ajxeWkI060120151200003'),(19,NULL,NULL,'The first','06/01/2015 12:00:00','FsJxHzj0601201512000012'),(20,NULL,NULL,'','20/6/16',NULL),(21,NULL,NULL,'','20/6/16',NULL),(22,NULL,NULL,'','20/6/16',NULL);
/*!40000 ALTER TABLE `submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(40) NOT NULL,
  `tag_desc` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `tag_name` (`tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'admission test','No description'),(2,'android','Mobile development'),(3,'bangla computational linguistics','No description'),(4,'machine learning','No description'),(5,'pipilika','Bangla search engine'),(6,'ocr','Optical Character Recognition');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_title` varchar(50) NOT NULL,
  `task_desc` varchar(200) DEFAULT NULL,
  `task_deadline` datetime NOT NULL,
  `task_type_id` int(11) NOT NULL,
  `task_total_group_no` int(11) NOT NULL,
  `task_total_submisson_no` int(11) NOT NULL,
  `is_open` tinyint(1) NOT NULL,
  PRIMARY KEY (`task_id`),
  KEY `task_type_task_fk` (`task_type_id`),
  CONSTRAINT `task_type_task_fk` FOREIGN KEY (`task_type_id`) REFERENCES `task_type` (`task_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Project 400','Build a web application with Spring framework','2016-05-19 07:39:59',2,0,9,1),(2,'Build application using Socket programming','Desktop/Mobile','2015-07-01 12:00:00',2,0,0,1),(3,'Submit a Use Case document','Students can choose their project to write use case for','2015-07-01 12:00:00',1,0,0,1),(4,'Project 300','','2016-05-19 07:40:09',2,1,10,1),(6,'Project','','2016-06-13 09:53:03',2,2,10,1);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_project`
--

DROP TABLE IF EXISTS `task_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_project` (
  `task_project_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`task_project_id`),
  UNIQUE KEY `task_project_unique` (`task_id`,`project_id`),
  KEY `project_task_project_fk` (`project_id`),
  CONSTRAINT `project_task_project_fk` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `task_task_project_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_project`
--

LOCK TABLES `task_project` WRITE;
/*!40000 ALTER TABLE `task_project` DISABLE KEYS */;
INSERT INTO `task_project` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,5),(6,2,6),(11,4,11),(12,6,12),(13,6,13);
/*!40000 ALTER TABLE `task_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_type`
--

DROP TABLE IF EXISTS `task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_type` (
  `task_type_id` int(11) NOT NULL,
  `task_type_name` varchar(30) NOT NULL,
  PRIMARY KEY (`task_type_id`),
  UNIQUE KEY `task_type_idx` (`task_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type`
--

LOCK TABLES `task_type` WRITE;
/*!40000 ALTER TABLE `task_type` DISABLE KEYS */;
INSERT INTO `task_type` VALUES (1,'Assignment'),(2,'Project'),(3,'Thesis');
/*!40000 ALTER TABLE `task_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `instructor_id` bigint(20) NOT NULL,
  `employee_code` varchar(30) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `desig_id` int(11) NOT NULL,
  `is_permanent` tinyint(1) NOT NULL,
  `email` varchar(30) NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`instructor_id`),
  UNIQUE KEY `teacher_unique` (`employee_code`,`dept_id`),
  KEY `department_teacher_fk` (`dept_id`),
  KEY `designation_teacher_fk` (`desig_id`),
  KEY `user_teacher_fk` (`user_id`),
  CONSTRAINT `department_teacher_fk` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `designation_teacher_fk` FOREIGN KEY (`desig_id`) REFERENCES `designation` (`desig_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_teacher_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'SKN',1,3,1,'sknabil@sustarchive.com',1,2),(2,'MSI',1,3,1,'sabir_ismail@sustarchive.com',1,3),(3,'ERM',1,3,1,'eamin_rahman@sustarchive.com',1,4);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaches` (
  `teaches_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `instructor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`teaches_id`),
  UNIQUE KEY `teaches_unique` (`course_id`,`instructor_id`),
  KEY `teacher_teaches_fk` (`instructor_id`),
  CONSTRAINT `course_teaches_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `teacher_teaches_fk` FOREIGN KEY (`instructor_id`) REFERENCES `teacher` (`instructor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaches`
--

LOCK TABLES `teaches` WRITE;
/*!40000 ALTER TABLE `teaches` DISABLE KEYS */;
INSERT INTO `teaches` VALUES (1,1,1),(2,2,1),(3,3,2),(4,4,1);
/*!40000 ALTER TABLE `teaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_unique` (`user_name`),
  UNIQUE KEY `user_idx1` (`user_name`),
  KEY `user_type_user_fk` (`user_type_id`),
  CONSTRAINT `user_type_user_fk` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`user_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','1234',1,'admin@sustarchive.com'),(2,'sknabil','1234',2,'sknabil@sustarchive.com'),(3,'sabir_ismail','1234',2,'sabir_ismail@sustarchive.com'),(4,'eamin_rahman','1234',2,'eamin_rahman@sustarchive.com'),(5,'shafin_mahmud','1234',3,'shafin.mahmud@student.sust.edu'),(6,'pranon_rahman','1234',3,'pranon@student.sust.edu'),(7,'ahsankabir','1234',3,'ahsankabir@student.sust.edu'),(8,'saimon','1234',3,'saimon@student.sust.edu'),(9,'shuvanon_razik','1234',3,'shuvanon_razik@student.sust.edu'),(10,'fahim06','1234',3,'fahim06@student.sust.edu'),(11,'niloy','1234',3,'niloy@student.sust.edu'),(12,'ibtida.phoenix','1234',3,'ibtida.phoenix@student.sust.edu'),(13,'biswajit','1234',3,'biswajit@student.sust.edu'),(14,'shibbir','1234',3,'shibbir@student.sust.edu'),(15,'tariqhasananjan','1234',3,'tariqhasananjan@student.sust.edu'),(16,'tanzira_najnin','1234',3,'tanzira_najnin@student.sust.edu'),(17,'sakibulmowla','1234',3,'sakibulmowla@student.sust.edu'),(18,'ayon18','1234',3,'ayon18@student.sust.edu'),(19,'sumaiyafahmida','1234',3,'sumaiyafahmida@student.sust.edu');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(30) NOT NULL,
  `user_desc` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`),
  UNIQUE KEY `user_type_unique` (`user_type_name`),
  KEY `user_type_idx` (`user_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'Administrator','Primary level authority.'),(2,'Teacher','Secondary level authority'),(3,'Student','Tertiary level authority');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-24 23:20:36
