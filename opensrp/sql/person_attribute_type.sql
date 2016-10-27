-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: openmrs_v2
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

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
-- Table structure for table `person_attribute_type`
--

TRUNCATE TABLE `person_attribute_type`;

--
-- Dumping data for table `person_attribute_type`
--

LOCK TABLES `person_attribute_type` WRITE;
/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
INSERT INTO `person_attribute_type` VALUES (1,'Race','Group of persons related by common descent or heredity','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,6,'8d871386-c2cc-11de-8d13-0010c6dffd0f'),(2,'Birthplace','Location of persons birth','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,0,'8d8718c2-c2cc-11de-8d13-0010c6dffd0f'),(3,'Citizenship','Country of which this person is a member','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,1,'8d871afc-c2cc-11de-8d13-0010c6dffd0f'),(4,'Mother\'s Name','First or last name of this person\'s mother','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,5,'8d871d18-c2cc-11de-8d13-0010c6dffd0f'),(5,'Civil Status','Marriage status of this person','org.openmrs.Concept',1054,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,2,'8d871f2a-c2cc-11de-8d13-0010c6dffd0f'),(6,'Health District','District/region in which this patient\' home health center resides','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,4,'8d872150-c2cc-11de-8d13-0010c6dffd0f'),(7,'Health Center','Specific Location of this person\'s home health center.','org.openmrs.Location',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'8d87236c-c2cc-11de-8d13-0010c6dffd0f'),(8,'Location','User Location','java.lang.String',NULL,0,1,'2015-03-21 13:14:43',NULL,NULL,0,NULL,NULL,NULL,'Add Users',7,'231e27fc-aed8-4fc8-af91-9bedc9ead6e3'),(9,'Household ID','Household the person is associated with','java.lang.String',NULL,1,1,'2015-03-23 03:33:31',1,'2015-07-22 10:06:37',1,1,'2015-07-22 10:06:37','Was used for testing only.','Add Patients',8,'710ddf17-cd25-4c2c-845c-b216439e7ef5'),(10,'TestAttribute','Test','org.openmrs.Location',NULL,1,1,'2015-04-02 05:25:06',NULL,NULL,0,NULL,NULL,NULL,NULL,9,'fa48d109-fc76-43dd-b87c-0beb3da9c9ac'),(11,'GoB_HHID','Government of Bangladesh Household ID Number - The black-painted Government Household ID (HHID) number as displayed on the door/wall of the household.','java.lang.String',NULL,1,1,'2015-07-20 12:52:52',1,'2015-07-22 10:12:29',0,NULL,NULL,NULL,NULL,10,'95cc3d87-addc-4d3a-8ac6-cd7c6dcfcc3d'),(12,'JiVitA_HHID','JiVitA Household ID Number - The red-painted JiVitA Study Household ID (HHID) number as displayed on the door/wall of the household.','java.lang.String',NULL,1,1,'2015-07-20 12:54:10',1,'2015-07-22 10:12:36',0,NULL,NULL,NULL,NULL,11,'421fb9ee-1963-4d04-b9b0-1f9496ef05ab'),(13,'Patient Image','Stores the filename for the patient image','java.lang.String',NULL,0,1,'2015-08-07 01:06:37',NULL,NULL,0,NULL,NULL,NULL,NULL,12,'0bb66419-040f-4544-94b1-b4863c4faae5'),(14,'EPI Card Number','EPI Card Number assigned by Vaccinators and persist in their paper registers','java.lang.String',NULL,0,1,'2015-09-18 04:03:43',NULL,NULL,0,NULL,NULL,NULL,NULL,13,'b92a98b4-4bb0-48a2-b0ec-55b8a1195ba5'),(15,'dp','Stores the filename for the patient image','java.lang.String',NULL,0,1,'2015-10-07 02:32:19',NULL,NULL,0,NULL,NULL,NULL,NULL,14,'019c69ae-8440-4cdf-85cf-fc591a0311c3'),(16,'media','Stores the filename for the patient image','java.lang.String',NULL,0,1,'2015-10-08 00:29:55',NULL,NULL,0,NULL,NULL,NULL,NULL,15,'06c4a1d0-e3e1-4dbf-bf85-af83490728ee'),(17,'profile','Stores the filename for the patient image','java.lang.String',NULL,0,39,'2015-10-15 04:05:08',NULL,NULL,0,NULL,NULL,NULL,NULL,16,'7f9deae5-ac59-4c70-a2ca-94536e71d023'),(18,'nidImage','Stores the filename for the patient image','java.lang.String',NULL,0,1,'2015-11-05 04:10:32',NULL,NULL,0,NULL,NULL,NULL,NULL,17,'bf769ddf-0583-4bce-9f5a-d68ac21dbee1'),(19,'profileimage','Stores the filename for the patient image','java.lang.String',NULL,0,1,'2015-11-05 04:57:00',NULL,NULL,0,NULL,NULL,NULL,NULL,18,'c194c472-8a2f-47e8-9f24-208acd91b310');
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-21  4:16:33
