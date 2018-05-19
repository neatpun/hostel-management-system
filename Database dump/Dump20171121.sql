CREATE DATABASE  IF NOT EXISTS `hms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hms`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: hms
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complaint` (
  `complaint_id` int(11) NOT NULL,
  `roll_no` int(11) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `registered_date` date NOT NULL,
  `resolved_date` date DEFAULT NULL,
  PRIMARY KEY (`complaint_id`,`roll_no`),
  KEY `fk_student_complaint` (`roll_no`),
  CONSTRAINT `fk_student_complaint` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
INSERT INTO `complaint` VALUES (1,5,'Housekeeping','2017-11-21',NULL);
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger complaint_in

before insert on complaint

for each row

begin

declare r int;
    declare i int;
    set new.registered_date=curdate();
	set r=new.roll_no;
    set i=(select complaint_id from complaint where roll_no=r order by complaint_id desc limit 1);
    if(isnull(i)) then set i=0;
    end if;
    set new.complaint_id=i+1;
	

     
     

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger chk_st_comp before insert on complaint 
      for each row 
       begin  
      if  (select year from student where roll_no=new.roll_no)='0' then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Ex students not allowed';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `courier`
--

DROP TABLE IF EXISTS `courier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courier` (
  `courier_id` int(11) NOT NULL,
  `roll_no` int(11) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `received_date` date NOT NULL,
  `collected_date` date DEFAULT NULL,
  PRIMARY KEY (`courier_id`,`roll_no`),
  KEY `fk_student_courier` (`roll_no`),
  CONSTRAINT `fk_student_courier` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier`
--

LOCK TABLES `courier` WRITE;
/*!40000 ALTER TABLE `courier` DISABLE KEYS */;
INSERT INTO `courier` VALUES (1,3,'Amazon','2017-11-21',NULL);
/*!40000 ALTER TABLE `courier` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger courier_in

before insert on courier

for each row

begin

declare r int;
    declare i int;
    set new.received_date=curdate();
	set r=new.roll_no;
    set i=(select courier_id from courier where roll_no=r order by courier_id desc limit 1);
    if(isnull(i)) then set i=0;
    end if;
    set new.courier_id=i+1;
	

     
     

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger chk_st_cour before insert on courier 
      for each row 
       begin  
      if  (select year from student where roll_no=new.roll_no)='0' then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Ex students not allowed';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `current_students`
--

DROP TABLE IF EXISTS `current_students`;
/*!50001 DROP VIEW IF EXISTS `current_students`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `current_students` AS SELECT 
 1 AS `name`,
 1 AS `roll_no`,
 1 AS `dob`,
 1 AS `gender`,
 1 AS `address`,
 1 AS `contact_no`,
 1 AS `year`,
 1 AS `branch`,
 1 AS `hostel_id`,
 1 AS `flat`,
 1 AS `room`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `name` varchar(40) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('f','m') DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `contact_no` int(11) DEFAULT NULL,
  `date_of_joining` date NOT NULL,
  `termination_date` date DEFAULT NULL,
  `designation` enum('cleaning','warden','mess','office','other') DEFAULT NULL,
  `hostel_id` int(11) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_emp_hostel` (`hostel_id`),
  CONSTRAINT `fk_emp_hostel` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('lol',123,'1900-02-02','m','sdf',32,'2010-02-02',NULL,'warden',1,80000),('df',324,NULL,NULL,NULL,NULL,'2017-11-11',NULL,NULL,2,17000),('test2',12345,'1990-11-25','f','somewhere',2423423,'2017-11-18',NULL,'cleaning',1,20000),('23423',21321,'2017-11-10','f','xvxz',45654,'2017-11-11',NULL,'cleaning',1,20000);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger employeeSalary

before insert on employee

for each row

begin


    	if new.designation="Cleaning" then

		set new.salary=20000 ;

	elseif new.designation="Warden" then

		set new.salary=80000 ;

    	elseif new.designation="Mess" then

		set new.salary=15000 ;

	elseif new.designation="Office" then

		set new.salary=60000 ;

    	else

		set new.salary=17000 ;

	end if ;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger employee_in

before insert on employee

for each row

begin


    set new.date_of_joining=curdate();
	
	

     
     

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(400) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `expenditure` int(11) DEFAULT NULL,
  `hostel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `fk_hostel_event` (`hostel_id`),
  CONSTRAINT `fk_hostel_event` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'lol','2017-11-11 13:26:15',33,1),(2,'lol','2017-11-11 13:26:20',33,1),(4,'sdfsd','2017-11-27 14:22:00',34543,1),(5,'sdfsd','2017-11-27 14:22:00',34543,1),(6,'sdfsd','2017-11-27 14:22:00',34543,1),(7,'sdfsd','2017-11-27 02:22:00',34543,1),(8,'sdcds','2017-11-24 15:33:00',22222,1),(9,'sdfsdfsd','2017-11-18 15:33:00',3432,3),(10,'New year party at studio ','2017-12-31 12:00:00',10000,2);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger chk_date before insert on event 
      for each row 
       begin  
      if  new.start_time<now() then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Date time must be in future';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `failed_student`
--

DROP TABLE IF EXISTS `failed_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_student` (
  `name` varchar(40) NOT NULL,
  `roll_no` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('f','m') DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `contact_no` int(11) DEFAULT NULL,
  `year` enum('0','1','2','3','4') NOT NULL,
  `branch` enum('cse','me','ee','mems','ce') NOT NULL,
  `hostel_id` int(11) NOT NULL,
  `flat` int(11) NOT NULL,
  `room` enum('a','b','c','d','e') NOT NULL,
  PRIMARY KEY (`roll_no`),
  KEY `fk_hostel_failed_student` (`hostel_id`),
  CONSTRAINT `fk_hostel_failed_student` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_student`
--

LOCK TABLES `failed_student` WRITE;
/*!40000 ALTER TABLE `failed_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_record`
--

DROP TABLE IF EXISTS `gate_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gate_record` (
  `roll_no` int(11) NOT NULL,
  `purpose` varchar(400) DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `exit_time` datetime NOT NULL,
  PRIMARY KEY (`exit_time`,`roll_no`),
  KEY `fk_student_gate_record` (`roll_no`),
  CONSTRAINT `fk_student_gate_record` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_record`
--

LOCK TABLES `gate_record` WRITE;
/*!40000 ALTER TABLE `gate_record` DISABLE KEYS */;
INSERT INTO `gate_record` VALUES (2,'Fun',NULL,'2017-11-21 15:48:10');
/*!40000 ALTER TABLE `gate_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger gate_record_out

before insert on gate_record

for each row

begin
	

     set new.exit_time=now();
     

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger chk_st_gate before insert on gate_record
      for each row 
       begin  
      if  (select year from student where roll_no=new.roll_no)='0' then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Ex students not allowed';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hostel`
--

DROP TABLE IF EXISTS `hostel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostel` (
  `name` varchar(40) NOT NULL,
  `hostel_id` int(11) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `no_students` int(11) DEFAULT NULL,
  `no_rooms_available` int(11) DEFAULT NULL,
  PRIMARY KEY (`hostel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostel`
--

LOCK TABLES `hostel` WRITE;
/*!40000 ALTER TABLE `hostel` DISABLE KEYS */;
INSERT INTO `hostel` VALUES ('Hall of residences',1,450,5,445),('Studio apartments',2,900,10,890),('Silver Springs',3,450,5,445);
/*!40000 ALTER TABLE `hostel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `name` varchar(40) NOT NULL,
  `roll_no` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('f','m') DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `contact_no` int(11) DEFAULT NULL,
  `year` enum('1','2','3','4','0') NOT NULL,
  `branch` enum('cse','me','ee','mems','ce') NOT NULL,
  `hostel_id` int(11) NOT NULL,
  `flat` int(11) DEFAULT NULL,
  `room` enum('a','b','c','d','e') DEFAULT NULL,
  PRIMARY KEY (`roll_no`),
  KEY `fk_hostel_student` (`hostel_id`),
  CONSTRAINT `fk_hostel_student` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('a',1,'1990-01-01','f','a',1,'1','cse',1,101,'a'),('b',2,'1990-01-01','f','a',1,'1','cse',1,101,'b'),('c',3,'1990-01-01','f','a',1,'1','cse',1,101,'c'),('d',4,'1990-01-01','f','a',1,'1','cse',1,101,'d'),('e',5,'1990-01-01','f','a',1,'1','cse',1,101,'e'),('a',11,'1990-01-01','f','a',1,'2','cse',2,101,'a'),('b',12,'1990-01-01','f','a',1,'2','cse',2,101,'b'),('c',13,'1990-01-01','f','a',1,'2','cse',2,101,'c'),('d',14,'1990-01-01','f','a',1,'2','cse',2,101,'d'),('e',15,'1990-01-01','f','a',1,'2','cse',2,101,'e'),('a',21,'1990-01-01','f','a',1,'3','cse',2,102,'a'),('b',22,'1990-01-01','f','a',1,'3','cse',2,102,'b'),('c',23,'1990-01-01','f','a',1,'3','cse',2,102,'c'),('d',24,'1990-01-01','f','a',1,'3','cse',2,102,'d'),('e',25,'1990-01-01','f','a',1,'3','cse',2,102,'e'),('a',31,'1990-01-01','f','a',1,'4','cse',3,101,'a'),('b',32,'1990-01-01','f','a',1,'4','cse',3,101,'b'),('c',33,'1990-01-01','f','a',1,'4','cse',3,101,'c'),('d',34,'1990-01-01','f','a',1,'4','cse',3,101,'d'),('e',35,'1990-01-01','f','a',1,'4','cse',3,101,'e');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger roomAllotment

before insert on student

for each row

begin

	declare n int; /*Number of flats available*/

    	declare r int; /*flat number*/
        declare h int;

    	declare f varchar(1); /*room number*/
        set h=0;
        
        if new.year like '1' then set h=1 ;
        end if;
        if new.year like '2' then set h=2 ;
        end if;
        if new.year like '3' then set h=2;
        end if;
        if new.year like '4' then set h=3 ;
        end if;

	
		set new.hostel_id=h ;

        	set n=availableRooms(h);



        	if n>0 then

			set r=(select flat from student where hostel_id=h and year!='0' order by flat desc limit 1) ;

            		
            set f=(select room from student where flat=r and hostel_id=h and year!='0' order by room desc limit 1);


            		if isnull(r) then
            set r=100;set f='E';
            end if;
            if mod(r,100)=18 then

				if f='A' then

					set new.flat=r;

                    			set new.room='B';

				elseif f='B' then

					set new.flat=r;

                    			set new.room='C';

				elseif f='C' then

					set new.flat=r;

                    			set new.room='D';

				elseif f='D' then

					set new.flat=r;

                    			set new.room='E';

				else

					set new.flat=((r/100)+1)*100 + 1;

                    			set new.room='A';

				end if;

            		else

				if f='A' then

					set new.flat=r;

                    			set new.room='B';

				elseif f='B' then

					set new.flat=r;

                    			set new.room='C';

				elseif f='C' then

					set new.flat=r;

                    			set new.room='D';

				elseif f='D' then

					set new.flat=r;

                    			set new.room='E';

				else

					set new.flat=r + 1;

                    			set new.room='A';

				end if;

            		end if;

		else

			set new.flat=NULL;

            		set new.room=NULL;

        	end if;

	

	

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger chk_age_student before insert on student 
      for each row 
       begin  
      if  TIMESTAMPDIFF(YEAR, new.dob, curdate())<17  then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Student must be atleast 17 year old.';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger iupdateHostel

after insert on student

for each row

begin

     update hostel
     set no_rooms_available=availableRooms(hostel_id);
     update hostel
     set no_students=capacity-no_rooms_available;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger uroomAllotment

before update on student

for each row

this:begin

	declare n int; /*Number of flats available*/

    	declare r int; /*flat number*/
        declare h int;

    	declare f varchar(1); /*room number*/
        set h=0;
        
        if new.year like '0' then leave this;
        end if;
        
        if new.year like old.year then leave this;
        end if;
        
        
        
        if new.year like '1' then set h=1 ;
        end if;
        if new.year like '2' then set h=2 ;
        end if;
        if new.year like '3' then set h=2;
        end if;
        if new.year like '4' then set h=3 ;
        end if;

	
		set new.hostel_id=h ;

        	set n=availableRooms(h);



        	if n>0 then

			set r=(select flat from student where hostel_id=h and year!='0'  order by flat desc limit 1) ;

            		
            set f=(select room from student where flat=r and hostel_id=h and year!='0' order by room desc limit 1);


            		if isnull(r) then
            set r=100;set f='E';
            end if;
            if mod(r,100)=18 then

				if f='A' then

					set new.flat=r;

                    			set new.room='B';

				elseif f='B' then

					set new.flat=r;

                    			set new.room='C';

				elseif f='C' then

					set new.flat=r;

                    			set new.room='D';

				elseif f='D' then

					set new.flat=r;

                    			set new.room='E';

				else

					set new.flat=((r/100)+1)*100 + 1;

                    			set new.room='A';

				end if;

            		else

				if f='A' then

					set new.flat=r;

                    			set new.room='B';

				elseif f='B' then

					set new.flat=r;

                    			set new.room='C';

				elseif f='C' then

					set new.flat=r;

                    			set new.room='D';

				elseif f='D' then

					set new.flat=r;

                    			set new.room='E';

				else

					set new.flat=r + 1;

                    			set new.room='A';

				end if;

            		end if;

		else

			set new.flat=NULL;

            		set new.room=NULL;

        	end if;

	

	

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger uupdateHostel

after update on student

for each row

begin

     update hostel
     set no_rooms_available=availableRooms(hostel_id);
     update hostel
     set no_students=capacity-no_rooms_available;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitor` (
  `name` varchar(40) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `contact_no` int(11) DEFAULT NULL,
  `roll_no` int(11) NOT NULL,
  `purpose` varchar(400) DEFAULT NULL,
  `entry_time` datetime NOT NULL,
  `exit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`visitor_id`,`roll_no`),
  KEY `fk_student_visitor` (`roll_no`),
  CONSTRAINT `fk_student_visitor` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES ('A',1,1234,1,'Meeting','2017-11-21 15:47:32',NULL);
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger visitor_id_set

before insert on visitor

for each row

begin
	declare r int;
    declare i int;
    set new.entry_time=now();
	set r=new.roll_no;
    set i=(select visitor_id from visitor where roll_no=r order by visitor_id desc limit 1);
    if(isnull(i)) then set i=0;
    end if;
    set new.visitor_id=i+1;
    
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger chk_st_visit before insert on visitor
      for each row 
       begin  
      if  (select year from student where roll_no=new.roll_no)='0' then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Ex students not allowed';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'hms'
--

--
-- Dumping routines for database 'hms'
--
/*!50003 DROP FUNCTION IF EXISTS `availableRooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `availableRooms`(h_id int) RETURNS int(11)
begin

	declare no_of_available_rooms int ;

    	set no_of_available_rooms=(select (select capacity from hostel where hostel_id=h_id) - count(roll_no)

				   from student

                                   where hostel_id=h_id and year!=0 );

	return no_of_available_rooms ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `complaint_res` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `complaint_res`(roll_no1 int,complaint_id1 int,add_des varchar(191))
begin
	update complaint
     set resolved_date=curdate()
     , description=concat(description,"  RESOLVED REMARK:" ,add_des)
     where roll_no=roll_no1 and isnull(resolved_date) and complaint_id=complaint_id1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `courier_col` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `courier_col`(roll_no1 int,courier_id1 int)
begin
	update courier
     set collected_date=curdate()
     
     where roll_no=roll_no1 and isnull(collected_date) and courier_id=courier_id1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fail`(in roll_no1 int)
begin

DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
  ROLLBACK;
END;

DECLARE exit handler for sqlwarning
 BEGIN
    -- WARNING
 ROLLBACK;
END;

START TRANSACTION;
insert into failed_student select * from student where roll_no=roll_no1;
delete from student where roll_no=roll_no1;
COMMIT;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forward` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forward`()
begin
DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
  ROLLBACK;
END;

DECLARE exit handler for sqlwarning
 BEGIN
    -- WARNING
 ROLLBACK;
END;

START TRANSACTION;

update student
set flat=NULL,room=NULL
where year!='0' and year!='4';

update student 
set year='0'
where year='4';

update student 
set year='4'
where year='3';

update student 
set year='3'
where year='2';

update student 
set year='2'
where year='1';

insert into student
select * from failed_student;

delete from failed_student;


COMMIT;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gate_record_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `gate_record_in`(roll_no1 int)
begin
	update gate_record
     set entry_time=now()
     where roll_no=roll_no1 and isnull(entry_time);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visitor_out` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visitor_out`(roll_no1 int,visitor_id1 int)
begin
	update visitor
     set exit_time=now()
     where roll_no=roll_no1 and isnull(exit_time) and visitor_id=visitor_id1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `current_students`
--

/*!50001 DROP VIEW IF EXISTS `current_students`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_students` AS select `student`.`name` AS `name`,`student`.`roll_no` AS `roll_no`,`student`.`dob` AS `dob`,`student`.`gender` AS `gender`,`student`.`address` AS `address`,`student`.`contact_no` AS `contact_no`,`student`.`year` AS `year`,`student`.`branch` AS `branch`,`student`.`hostel_id` AS `hostel_id`,`student`.`flat` AS `flat`,`student`.`room` AS `room` from `student` where (`student`.`year` <> '0') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-21 16:09:16
