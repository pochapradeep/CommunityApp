-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.1.45-community - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2015-10-21 18:11:28
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table community_app_db.address_template
CREATE TABLE IF NOT EXISTS `address_template` (
  `ADDRESS_TEMPLATE_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`ADDRESS_TEMPLATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.address_template: ~1 rows (approximately)
/*!40000 ALTER TABLE `address_template` DISABLE KEYS */;
INSERT INTO `address_template` (`ADDRESS_TEMPLATE_ID`, `ADDRESS_TEMPLATE_NAME`) VALUES
	(1, 'APARTMENT-BLOCK');
/*!40000 ALTER TABLE `address_template` ENABLE KEYS */;


-- Dumping structure for table community_app_db.address_template_group
CREATE TABLE IF NOT EXISTS `address_template_group` (
  `ADDRESS_TEMPLATE_GROUP_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_TYPE_ID` int(3) NOT NULL,
  `ADDRESS_TYPE_NAME` varchar(50) NOT NULL,
  `ADDRESS_TEMPLATE_PARENT_TYPE_ID` int(3) NOT NULL,
  `COMMON_ADDRESS_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `POSTAL_ADDRESS_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ADDRESS_TEMPLATE_GROUP_ID`),
  KEY `fk_ADDRESS_TEMPLATE_ID` (`ADDRESS_TEMPLATE_ID`),
  CONSTRAINT `fk_ADDRESS_TEMPLATE_ADDRESS_TEMPLATE1` FOREIGN KEY (`ADDRESS_TEMPLATE_ID`) REFERENCES `address_template` (`ADDRESS_TEMPLATE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.address_template_group: ~7 rows (approximately)
/*!40000 ALTER TABLE `address_template_group` DISABLE KEYS */;
INSERT INTO `address_template_group` (`ADDRESS_TEMPLATE_GROUP_ID`, `ADDRESS_TEMPLATE_ID`, `ADDRESS_TEMPLATE_TYPE_ID`, `ADDRESS_TYPE_NAME`, `ADDRESS_TEMPLATE_PARENT_TYPE_ID`, `COMMON_ADDRESS_FLAG`, `POSTAL_ADDRESS_FLAG`) VALUES
	(1, 1, 1, 'BLOCK', 0, 0, 1),
	(2, 1, 2, 'FLOOR', 1, 0, 0),
	(3, 1, 3, 'FLAT NO', 2, 0, 1),
	(4, 1, 4, 'ADDRESS1', 0, 1, 1),
	(5, 1, 5, 'CITY', 0, 1, 1),
	(6, 1, 6, 'STATE', 0, 1, 1),
	(7, 1, 7, 'COUNTRY', 0, 1, 1);
/*!40000 ALTER TABLE `address_template_group` ENABLE KEYS */;


-- Dumping structure for table community_app_db.community_admin_group
CREATE TABLE IF NOT EXISTS `community_admin_group` (
  `COMMUNITY_ID` int(10) NOT NULL,
  `ADMIN_PRIORITY_ORDER` int(2) NOT NULL,
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  PRIMARY KEY (`COMMUNITY_ID`),
  KEY `fk_COMMUNITY_ADMIN_GROUP_RESIDENT_MASTER1` (`RESIDENT_MASTER_ID`),
  CONSTRAINT `fk_COMMUNITY_ADMIN_GROUP_RESIDENT_MASTER1` FOREIGN KEY (`RESIDENT_MASTER_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMUNITY_ADMIN_GROUP_COMMUNITY1` FOREIGN KEY (`COMMUNITY_ID`) REFERENCES `community_master` (`COMMUNITY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.community_admin_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `community_admin_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `community_admin_group` ENABLE KEYS */;


-- Dumping structure for table community_app_db.community_license_type
CREATE TABLE IF NOT EXISTS `community_license_type` (
  `COMMUNITY_LICENSE_TYPE_ID` int(10) NOT NULL,
  `COMMUNITY_LICENSE_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`COMMUNITY_LICENSE_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.community_license_type: ~3 rows (approximately)
/*!40000 ALTER TABLE `community_license_type` DISABLE KEYS */;
INSERT INTO `community_license_type` (`COMMUNITY_LICENSE_TYPE_ID`, `COMMUNITY_LICENSE_TYPE_NAME`) VALUES
	(1, 'PAID'),
	(2, 'TRAIL'),
	(3, 'DEMO');
/*!40000 ALTER TABLE `community_license_type` ENABLE KEYS */;


-- Dumping structure for table community_app_db.community_master
CREATE TABLE IF NOT EXISTS `community_master` (
  `COMMUNITY_ID` int(10) NOT NULL,
  `COMMUNITY_ADDRES_MAIN` varchar(255) DEFAULT NULL,
  `COMMUNITY_ZIP_CODE` varchar(10) DEFAULT NULL,
  `COMMUNITY_CITY` varchar(50) NOT NULL,
  `COMMUNITY_STATE` varchar(50) NOT NULL,
  `COMMUNITY_COUNTRY` varchar(50) NOT NULL,
  `COMMUNITY_NAME` varchar(50) NOT NULL,
  `COMMUNITY_NICK_NAME` varchar(50) NOT NULL,
  `COMMUNITY_URL` varchar(255) DEFAULT NULL,
  `COMMUNITY_IMAGE_FILE_NAME` varchar(255) DEFAULT NULL,
  `COMMUNITY_TYPE_ID` int(10) NOT NULL,
  `COMMUNITY_STATUS_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_ID` int(10) NOT NULL,
  `COMMUNITY_LICENSE_TYPE_ID` int(10) NOT NULL,
  PRIMARY KEY (`COMMUNITY_ID`),
  KEY `fk_COMMUNITY_NAME` (`COMMUNITY_NAME`),
  KEY `fk_COMMUNITY_NICK_NAME` (`COMMUNITY_NICK_NAME`),
  KEY `fk_COMMUNITY_MASTER_COMMUNITY_STATUS1` (`COMMUNITY_STATUS_ID`),
  KEY `fk_COMMUNITY_MASTER_COMMUNITY_TYPE1` (`COMMUNITY_TYPE_ID`),
  KEY `fk_COMMUNITY_MASTER_ADDRESS_TEMPLATE1` (`ADDRESS_TEMPLATE_ID`),
  KEY `fk_COMMUNITY_MASTER_COMMUNITY_LICENSE_TYPE1` (`COMMUNITY_LICENSE_TYPE_ID`),
  CONSTRAINT `fk_COMMUNITY_MASTER_ADDRESS_TEMPLATE1` FOREIGN KEY (`ADDRESS_TEMPLATE_ID`) REFERENCES `address_template` (`ADDRESS_TEMPLATE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMUNITY_MASTER_COMMUNITY_LICENSE_TYPE1` FOREIGN KEY (`COMMUNITY_LICENSE_TYPE_ID`) REFERENCES `community_license_type` (`COMMUNITY_LICENSE_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMUNITY_MASTER_COMMUNITY_STATUS1` FOREIGN KEY (`COMMUNITY_STATUS_ID`) REFERENCES `community_status` (`COMMUNITY_STATUS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMUNITY_MASTER_COMMUNITY_TYPE1` FOREIGN KEY (`COMMUNITY_TYPE_ID`) REFERENCES `community_type` (`COMMUNITY_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.community_master: ~0 rows (approximately)
/*!40000 ALTER TABLE `community_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `community_master` ENABLE KEYS */;


-- Dumping structure for table community_app_db.community_status
CREATE TABLE IF NOT EXISTS `community_status` (
  `COMMUNITY_STATUS_ID` int(10) NOT NULL,
  `COMMUNITY_STATUS_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`COMMUNITY_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.community_status: ~3 rows (approximately)
/*!40000 ALTER TABLE `community_status` DISABLE KEYS */;
INSERT INTO `community_status` (`COMMUNITY_STATUS_ID`, `COMMUNITY_STATUS_NAME`) VALUES
	(1, 'ACTIVE'),
	(2, 'INACTIVE'),
	(3, 'ONHOLD');
/*!40000 ALTER TABLE `community_status` ENABLE KEYS */;


-- Dumping structure for table community_app_db.community_type
CREATE TABLE IF NOT EXISTS `community_type` (
  `COMMUNITY_TYPE_ID` int(10) NOT NULL,
  `COMMUNITY_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`COMMUNITY_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.community_type: ~3 rows (approximately)
/*!40000 ALTER TABLE `community_type` DISABLE KEYS */;
INSERT INTO `community_type` (`COMMUNITY_TYPE_ID`, `COMMUNITY_TYPE_NAME`) VALUES
	(1, 'APARTMENT'),
	(2, 'VILLA'),
	(3, 'LAYOUT');
/*!40000 ALTER TABLE `community_type` ENABLE KEYS */;


-- Dumping structure for table community_app_db.personal_information
CREATE TABLE IF NOT EXISTS `personal_information` (
  `PERSONAL_INFORMATION_ID` int(10) NOT NULL,
  `FIRST_NAME` varchar(50) NOT NULL,
  `LAST_NAME` varchar(50) NOT NULL,
  `DOB` timestamp NULL DEFAULT NULL,
  `GENDER` tinyint(4) DEFAULT NULL,
  `PHONE_NO` varchar(20) DEFAULT NULL,
  `ALTERNATE_PHONE_NO` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `ALTERNATE_EMAIL_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PERSONAL_INFORMATION_ID`),
  KEY `fk_FIRST_NAME` (`FIRST_NAME`),
  KEY `fk_PHONE_NO` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.personal_information: ~0 rows (approximately)
/*!40000 ALTER TABLE `personal_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_information` ENABLE KEYS */;


-- Dumping structure for table community_app_db.relationship_type
CREATE TABLE IF NOT EXISTS `relationship_type` (
  `RELATIONSHIP_TYPE_ID` int(3) NOT NULL,
  `RELATIONSHIP_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`RELATIONSHIP_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.relationship_type: ~6 rows (approximately)
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` (`RELATIONSHIP_TYPE_ID`, `RELATIONSHIP_TYPE_NAME`) VALUES
	(1, 'FATHER'),
	(2, 'MOTHER'),
	(3, 'SPOUCE'),
	(4, 'CHILD'),
	(5, 'FRIEND'),
	(6, 'OTHERS');
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;


-- Dumping structure for table community_app_db.residence_unit
CREATE TABLE IF NOT EXISTS `residence_unit` (
  `RESIDENCE_UNIT_ID` int(10) NOT NULL,
  `COMMUNITY_ID` int(10) NOT NULL,
  `RESIDENCE_UNIT_NAME` varchar(50) NOT NULL,
  `ADDRESS_TEMPLATE_GROUP_ID` int(10) NOT NULL,
  PRIMARY KEY (`RESIDENCE_UNIT_ID`),
  KEY `fk_COMMUNITY_ID` (`COMMUNITY_ID`),
  KEY `fk_RESIDENCE_UNIT_NAME` (`RESIDENCE_UNIT_NAME`),
  KEY `fk_ADDRESS_TEMPLATE_GROUP_ID` (`ADDRESS_TEMPLATE_GROUP_ID`),
  CONSTRAINT `fk_RESIDENCE_UNIT_ADDRESS_TEMPLATE_GROUP` FOREIGN KEY (`ADDRESS_TEMPLATE_GROUP_ID`) REFERENCES `address_template_group` (`ADDRESS_TEMPLATE_GROUP_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENCE_UNIT_COMMUNITY_MASTER1` FOREIGN KEY (`COMMUNITY_ID`) REFERENCES `community_master` (`COMMUNITY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.residence_unit: ~0 rows (approximately)
/*!40000 ALTER TABLE `residence_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `residence_unit` ENABLE KEYS */;


-- Dumping structure for table community_app_db.resident_master
CREATE TABLE IF NOT EXISTS `resident_master` (
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  `COMMUNITY_ID` int(10) NOT NULL,
  `RESIDENT_OWNER_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `RESIDENT_STATUS_ID` int(3) NOT NULL,
  `RESIDENCE_UNIT_ID` int(10) NOT NULL,
  `PRIMARY_USER_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `PERSONAL_INFORMATION_ID` int(10) NOT NULL,
  `DISPLAY_PERSONAL_INFO_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`RESIDENT_MASTER_ID`),
  KEY `fk_RESIDENT_OWNDER_FLAG` (`RESIDENT_OWNER_FLAG`),
  KEY `fk_RESIDENT_MASTER_RESIDENT_STATUS1` (`RESIDENT_STATUS_ID`),
  KEY `fk_RESIDENT_MASTER_RESIDENCE_UNIT1` (`RESIDENCE_UNIT_ID`),
  KEY `fk_RESIDENT_MASTER_PERSONAL_INFORMATION1` (`PERSONAL_INFORMATION_ID`),
  KEY `fk_RESIDENT_MASTER_COMMUNITY1` (`COMMUNITY_ID`),
  CONSTRAINT `fk_RESIDENT_MASTER_COMMUNITY1` FOREIGN KEY (`COMMUNITY_ID`) REFERENCES `community_master` (`COMMUNITY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENT_MASTER_PERSONAL_INFORMATION1` FOREIGN KEY (`PERSONAL_INFORMATION_ID`) REFERENCES `personal_information` (`PERSONAL_INFORMATION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENT_MASTER_RESIDENCE_UNIT1` FOREIGN KEY (`RESIDENCE_UNIT_ID`) REFERENCES `residence_unit` (`RESIDENCE_UNIT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENT_MASTER_RESIDENT_STATUS1` FOREIGN KEY (`RESIDENT_STATUS_ID`) REFERENCES `resident_status` (`RESIDENT_STATUS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.resident_master: ~0 rows (approximately)
/*!40000 ALTER TABLE `resident_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `resident_master` ENABLE KEYS */;


-- Dumping structure for table community_app_db.resident_relation_mapping
CREATE TABLE IF NOT EXISTS `resident_relation_mapping` (
  `PRIMARY_RESIDENT_ID` int(10) NOT NULL,
  `SECONDARY_RESIDENT_ID` int(10) NOT NULL,
  `RELATIONSHIP_TYPE_ID` int(3) NOT NULL,
  PRIMARY KEY (`PRIMARY_RESIDENT_ID`,`SECONDARY_RESIDENT_ID`),
  KEY `fk_RESIDENT_RELATION_MAPPING_RESIDENT_MASTER2` (`SECONDARY_RESIDENT_ID`),
  KEY `fk_RESIDENT_RELATION_MAPPING_RELATIONSHIP_TYPE1` (`RELATIONSHIP_TYPE_ID`),
  CONSTRAINT `fk_RESIDENT_RELATION_MAPPING_RESIDENT_MASTER1` FOREIGN KEY (`PRIMARY_RESIDENT_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENT_RELATION_MAPPING_RESIDENT_MASTER2` FOREIGN KEY (`SECONDARY_RESIDENT_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENT_RELATION_MAPPING_RELATIONSHIP_TYPE1` FOREIGN KEY (`RELATIONSHIP_TYPE_ID`) REFERENCES `relationship_type` (`RELATIONSHIP_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.resident_relation_mapping: ~0 rows (approximately)
/*!40000 ALTER TABLE `resident_relation_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `resident_relation_mapping` ENABLE KEYS */;


-- Dumping structure for table community_app_db.resident_status
CREATE TABLE IF NOT EXISTS `resident_status` (
  `RESIDENT_STATUS_ID` int(3) NOT NULL,
  `RESIDENT_STATUS_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`RESIDENT_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.resident_status: ~4 rows (approximately)
/*!40000 ALTER TABLE `resident_status` DISABLE KEYS */;
INSERT INTO `resident_status` (`RESIDENT_STATUS_ID`, `RESIDENT_STATUS_NAME`) VALUES
	(1, 'ACTIVE'),
	(2, 'ACTIVATION_PENDING'),
	(3, 'INACTIVE'),
	(4, 'DEACTIVATED');
/*!40000 ALTER TABLE `resident_status` ENABLE KEYS */;


-- Dumping structure for table community_app_db.super_admin_group_users
CREATE TABLE IF NOT EXISTS `super_admin_group_users` (
  `SUPER_ADMIN_GROUP_USERS_ID` int(10) NOT NULL,
  `USERS_ID` int(10) NOT NULL,
  `SUPER_ADMIN_GROUP_USERS_FIRST_NAME` varchar(50) NOT NULL,
  `SUPER_ADMIN_GROUP_USERS_LAST_NAME` varchar(50) NOT NULL,
  `SUPER_ADMIN_GROUP_USERS_PHONE_NO` varchar(20) NOT NULL,
  `SUPER_ADMIN_GROUP_USERS_EMAIL` varchar(50) NOT NULL,
  PRIMARY KEY (`SUPER_ADMIN_GROUP_USERS_ID`),
  KEY `fk_SUPER_ADMIN_GROUP_USERS_USERS1` (`USERS_ID`),
  CONSTRAINT `fk_SUPER_ADMIN_GROUP_USERS_USERS1` FOREIGN KEY (`USERS_ID`) REFERENCES `users` (`USERS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.super_admin_group_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `super_admin_group_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `super_admin_group_users` ENABLE KEYS */;


-- Dumping structure for table community_app_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `USERS_ID` int(10) NOT NULL,
  `USER_LOGIN_ID` varchar(50) NOT NULL,
  `USERS_STATUS_ID` int(3) NOT NULL,
  `SUPER_ADMIN_FLAG` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`USERS_ID`),
  KEY `fk_USER_LOGIN_ID` (`USER_LOGIN_ID`),
  KEY `fk_USERS_STATUS_ID` (`USERS_STATUS_ID`),
  CONSTRAINT `fk_USERS_USERS_STATUS_ID1` FOREIGN KEY (`USERS_STATUS_ID`) REFERENCES `users_status` (`USERS_STATUS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


-- Dumping structure for table community_app_db.users_status
CREATE TABLE IF NOT EXISTS `users_status` (
  `USERS_STATUS_ID` int(3) NOT NULL,
  `USERS_STATUS_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`USERS_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.users_status: ~2 rows (approximately)
/*!40000 ALTER TABLE `users_status` DISABLE KEYS */;
INSERT INTO `users_status` (`USERS_STATUS_ID`, `USERS_STATUS_NAME`) VALUES
	(1, 'ACTIVE'),
	(2, 'INACTIVE');
/*!40000 ALTER TABLE `users_status` ENABLE KEYS */;


-- Dumping structure for table community_app_db.user_resident_mapping
CREATE TABLE IF NOT EXISTS `user_resident_mapping` (
  `USERS_ID` int(10) NOT NULL,
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  `RESIDENT_STATUS_ID` int(3) NOT NULL,
  PRIMARY KEY (`USERS_ID`,`RESIDENT_MASTER_ID`),
  KEY `fk_USER_RESIDENT_MAPPING_RESIDENT_MASTER1` (`RESIDENT_MASTER_ID`),
  KEY `fk_USER_RESIDENT_MAPPING_RESIDENT_STATUS1` (`RESIDENT_STATUS_ID`),
  CONSTRAINT `fk_USER_RESIDENT_MAPPING_RESIDENT_STATUS1` FOREIGN KEY (`RESIDENT_STATUS_ID`) REFERENCES `resident_status` (`RESIDENT_STATUS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_RESIDENT_MAPPING_RESIDENT_MASTER1` FOREIGN KEY (`RESIDENT_MASTER_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_RESIDENT_MAPPING_USERS2` FOREIGN KEY (`USERS_ID`) REFERENCES `users` (`USERS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table community_app_db.user_resident_mapping: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_resident_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_resident_mapping` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
