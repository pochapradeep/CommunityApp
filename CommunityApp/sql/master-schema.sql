-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.46 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table smart_nehiborhood.address_template
CREATE TABLE IF NOT EXISTS `address_template` (
  `ADDRESS_TEMPLATE_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`ADDRESS_TEMPLATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `address_template` (`ADDRESS_TEMPLATE_ID`, `ADDRESS_TEMPLATE_NAME`) VALUES
	(1, 'APARTMENT-BLOCK');


-- Dumping structure for table smart_nehiborhood.address_template_group
CREATE TABLE IF NOT EXISTS `address_template_group` (
  `ADDRESS_TEMPLATE_GROUP_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_ID` int(10) NOT NULL,
  `ADDRESS_TEMPLATE_ORDER` int(3) NOT NULL,
  `ADDRESS_TEMPLATE_TYPE_ID` int(3) NOT NULL,
  `ADDRESS_TYPE_NAME` varchar(50) NOT NULL,
  `ADDRESS_TEMPLATE_PARENT_TYPE_ID` int(3) NOT NULL,
  `COMMON_ADDRESS_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `POSTAL_ADDRESS_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ADDRESS_TEMPLATE_GROUP_ID`),
  KEY `fk_ADDRESS_TEMPLATE_ID` (`ADDRESS_TEMPLATE_ID`),
  CONSTRAINT `fk_ADDRESS_TEMPLATE_ADDRESS_TEMPLATE1` FOREIGN KEY (`ADDRESS_TEMPLATE_ID`) REFERENCES `address_template` (`ADDRESS_TEMPLATE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `address_template_group` (`ADDRESS_TEMPLATE_GROUP_ID`, `ADDRESS_TEMPLATE_ID`, `ADDRESS_TEMPLATE_ORDER`, `ADDRESS_TEMPLATE_TYPE_ID`, `ADDRESS_TYPE_NAME`, `ADDRESS_TEMPLATE_PARENT_TYPE_ID`, `COMMON_ADDRESS_FLAG`, `POSTAL_ADDRESS_FLAG`) VALUES
	(1, 1, 1, 1, 'BLOCK', 0, 0, 1),
	(2, 1, 2, 2, 'FLOOR', 1, 0, 0),
	(3, 1, 3, 3, 'FLAT NO', 2, 0, 1),
	(4, 1, 1, 4, 'ADDRESS1', 0, 1, 1),
	(5, 1, 2, 5, 'CITY', 0, 1, 1),
	(6, 1, 3, 6, 'STATE', 0, 1, 1),
	(7, 1, 4, 7, 'COUNTRY', 0, 1, 1),
	(8, 1, 5, 8, 'ZIPCODE', 0, 1, 0);


-- Dumping structure for table smart_nehiborhood.community_admin_group
CREATE TABLE IF NOT EXISTS `community_admin_group` (
  `COMMUNITY_ID` int(10) NOT NULL,
  `ADMIN_PRIORITY_ORDER` int(2) NOT NULL,
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  PRIMARY KEY (`COMMUNITY_ID`),
  KEY `fk_COMMUNITY_ADMIN_GROUP_RESIDENT_MASTER1` (`RESIDENT_MASTER_ID`),
  CONSTRAINT `fk_COMMUNITY_ADMIN_GROUP_RESIDENT_MASTER1` FOREIGN KEY (`RESIDENT_MASTER_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMUNITY_ADMIN_GROUP_COMMUNITY1` FOREIGN KEY (`COMMUNITY_ID`) REFERENCES `community_master` (`COMMUNITY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.community_license_type
CREATE TABLE IF NOT EXISTS `community_license_type` (
  `COMMUNITY_LICENSE_TYPE_ID` int(10) NOT NULL,
  `COMMUNITY_LICENSE_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`COMMUNITY_LICENSE_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `community_license_type` (`COMMUNITY_LICENSE_TYPE_ID`, `COMMUNITY_LICENSE_TYPE_NAME`) VALUES
	(1, 'PAID'),
	(2, 'TRAIL'),
	(3, 'DEMO');


-- Dumping structure for table smart_nehiborhood.community_master
CREATE TABLE IF NOT EXISTS `community_master` (
  `COMMUNITY_ID` int(10) NOT NULL,
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


-- Dumping structure for table smart_nehiborhood.community_status
CREATE TABLE IF NOT EXISTS `community_status` (
  `COMMUNITY_STATUS_ID` int(10) NOT NULL,
  `COMMUNITY_STATUS_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`COMMUNITY_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `community_status` (`COMMUNITY_STATUS_ID`, `COMMUNITY_STATUS_NAME`) VALUES
	(1, 'ACTIVE'),
	(2, 'INACTIVE'),
	(3, 'ONHOLD');

-- Dumping structure for table smart_nehiborhood.community_type
CREATE TABLE IF NOT EXISTS `community_type` (
  `COMMUNITY_TYPE_ID` int(10) NOT NULL,
  `COMMUNITY_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`COMMUNITY_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `community_type` (`COMMUNITY_TYPE_ID`, `COMMUNITY_TYPE_NAME`) VALUES
	(1, 'APARTMENT'),
	(2, 'VILLA'),
	(3, 'LAYOUT');


-- Dumping structure for table smart_nehiborhood.community_vendor_details
CREATE TABLE IF NOT EXISTS `community_vendor_details` (
  `COMMUNITY_VENDOR_DETAILS_ID` int(10) NOT NULL,
  `COMMUNITY_VENDOR_TYPE_ID` int(10) NOT NULL,
  `VENDOR_NAME` varchar(50) NOT NULL,
  `VENDOR_COMPANY` varchar(50) DEFAULT NULL,
  `VENDOR_ADDRESS` varchar(255) DEFAULT NULL,
  `VENDOR_CONTACT_NO` varchar(20) DEFAULT NULL,
  `VENDOR_EMAIL` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`COMMUNITY_VENDOR_DETAILS_ID`),
  KEY `fk_COMMUNITY_VENDOR_DETAILS_COMMUNITY_VENDOR_TYPE1` (`COMMUNITY_VENDOR_TYPE_ID`),
  CONSTRAINT `fk_COMMUNITY_VENDOR_DETAILS_COMMUNITY_VENDOR_TYPE1` FOREIGN KEY (`COMMUNITY_VENDOR_TYPE_ID`) REFERENCES `community_vendor_type` (`COMMUNITY_VENDOR_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.community_vendor_mapping
CREATE TABLE IF NOT EXISTS `community_vendor_mapping` (
  `COMMUNITY_ID` int(10) NOT NULL,
  `VENDOR_TYPE_ID` int(10) NOT NULL,
  PRIMARY KEY (`COMMUNITY_ID`,`VENDOR_TYPE_ID`),
  KEY `fk_COMMUNITY_VENDOR_MAPPING_VENDOR_TYPE1` (`VENDOR_TYPE_ID`),
  CONSTRAINT `fk_COMMUNITY_VENDOR_MAPPING_RESIDENT_MASTER1` FOREIGN KEY (`COMMUNITY_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMUNITY_VENDOR_MAPPING_VENDOR_TYPE1` FOREIGN KEY (`VENDOR_TYPE_ID`) REFERENCES `vendor_type` (`VENDOR_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dumping structure for table smart_nehiborhood.contact_query
CREATE TABLE IF NOT EXISTS `contact_query` (
  `CONTACT_QUERY_ID` int(10) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `PHONE_NO` varchar(20) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `QUERY_STATUS_ID` int(3) NOT NULL,
  PRIMARY KEY (`CONTACT_QUERY_ID`),
  KEY `fk_CONTACT_QUERY_QUERY_STATUS1` (`QUERY_STATUS_ID`),
  CONSTRAINT `fk_CONTACT_QUERY_QUERY_STATUS1` FOREIGN KEY (`QUERY_STATUS_ID`) REFERENCES `query_status` (`QUERY_STATUS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.personal_information
CREATE TABLE IF NOT EXISTS `personal_information` (
  `PERSONAL_INFORMATION_ID` int(10) NOT NULL,
  `FIRST_NAME` varchar(50) NOT NULL,
  `LAST_NAME` varchar(50) NOT NULL,
  `DOB` timestamp NULL DEFAULT NULL,
  `GENDER` tinyint(4) DEFAULT NULL,
  `PHONE_NO` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `BLOOD_GROUP` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`PERSONAL_INFORMATION_ID`),
  KEY `fk_FIRST_NAME` (`FIRST_NAME`),
  KEY `fk_PHONE_NO` (`PHONE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping structure for table smart_nehiborhood.query_status
CREATE TABLE IF NOT EXISTS `query_status` (
  `QUERY_STATUS_ID` int(3) NOT NULL,
  `QUERY_STATUS_NAME` varchar(20) NOT NULL,
  PRIMARY KEY (`QUERY_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `recurring_trip_type` (
  `RECURRING_TRIP_TYPE_ID` int(3) NOT NULL,
  `RECURRING_TRIP_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`RECURRING_TRIP_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `recurring_trip_type` (`RECURRING_TRIP_TYPE_ID`, `RECURRING_TRIP_TYPE_NAME`) VALUES
	(1, 'WEEKDAY'),
	(2, 'DAILY');
-- Dumping structure for table smart_nehiborhood.relationship_type
CREATE TABLE IF NOT EXISTS `relationship_type` (
  `RELATIONSHIP_TYPE_ID` int(3) NOT NULL,
  `RELATIONSHIP_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`RELATIONSHIP_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `relationship_type` (`RELATIONSHIP_TYPE_ID`, `RELATIONSHIP_TYPE_NAME`) VALUES
	(1, 'FATHER'),
	(2, 'MOTHER'),
	(3, 'SPOUCE'),
	(4, 'CHILD'),
	(5, 'FRIEND'),
	(6, 'OTHERS');


-- Dumping structure for table smart_nehiborhood.residence_unit
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


-- Dumping structure for table smart_nehiborhood.resident_custom_field
CREATE TABLE IF NOT EXISTS `resident_custom_field` (
  `RESIDENT_CUSTOM_FIELD_ID` int(10) NOT NULL,
  `COMMUNITY_ID` int(10) NOT NULL,
  `RESIDENT_CUSTOM_FIELD_NAME` varchar(50) NOT NULL,
  `MANDATORY_INDICATOR` tinyint(1) NOT NULL DEFAULT '0',
  `POSTAL_ADDRESS_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`RESIDENT_CUSTOM_FIELD_ID`),
  KEY `fk_RESIDENT_CUSTOM_FIELD_COMMUNITY1` (`COMMUNITY_ID`),
  CONSTRAINT `fk_RESIDENT_CUSTOM_FIELD_COMMUNITY1` FOREIGN KEY (`COMMUNITY_ID`) REFERENCES `community_master` (`COMMUNITY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.resident_custom_field_values
CREATE TABLE IF NOT EXISTS `resident_custom_field_values` (
  `RESIDENT_CUSTOM_FIELD_VALUES_ID` int(10) NOT NULL,
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  `RESIDENT_CUSTOM_FIELD_ID` int(10) NOT NULL,
  `RESIDENT_CUSTOM_FIELD_VALUE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`RESIDENT_CUSTOM_FIELD_VALUES_ID`),
  KEY `fk_RESIDENT_CUSTOM_FIELD_VALUES_RESIDENT_CUSTOM_FIELD1` (`RESIDENT_CUSTOM_FIELD_ID`),
  KEY `fk_RESIDENT_CUSTOM_FIELD_VALUES_RESIDENT_MASTER1` (`RESIDENT_MASTER_ID`),
  CONSTRAINT `fk_RESIDENT_CUSTOM_FIELD_VALUES_RESIDENT_CUSTOM_FIELD1` FOREIGN KEY (`RESIDENT_CUSTOM_FIELD_ID`) REFERENCES `resident_custom_field` (`RESIDENT_CUSTOM_FIELD_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESIDENT_CUSTOM_FIELD_VALUES_RESIDENT_MASTER1` FOREIGN KEY (`RESIDENT_MASTER_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.resident_location
CREATE TABLE IF NOT EXISTS `resident_location` (
  `LOCATION_ID` int(10) NOT NULL,
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  `LOCATION_NICK_NAME` varchar(50) NOT NULL,
  `LOCATION_NAME` varchar(50) NOT NULL,
  `LOCATION_LATITUDE` varchar(20) DEFAULT NULL,
  `LOCATION_LAONGITUDE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `fk_RESIDENT_LOCATION_RESIDENT_MASTER1` (`RESIDENT_MASTER_ID`),
  CONSTRAINT `fk_RESIDENT_LOCATION_RESIDENT_MASTER1` FOREIGN KEY (`RESIDENT_MASTER_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.resident_master
CREATE TABLE IF NOT EXISTS `resident_master` (
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  `COMMUNITY_ID` int(10) NOT NULL,
  `RESIDENCE_UNIT_ID` int(10) NOT NULL,
  `PERSONAL_INFORMATION_ID` int(10) NOT NULL,
  `RESIDENT_OWNER_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `RESIDENT_STATUS_ID` int(3) NOT NULL,
  `PRIMARY_USER_FLAG` tinyint(1) NOT NULL DEFAULT '0',
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


-- Dumping structure for table smart_nehiborhood.resident_relation_mapping
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


-- Dumping structure for table smart_nehiborhood.resident_status
CREATE TABLE IF NOT EXISTS `resident_status` (
  `RESIDENT_STATUS_ID` int(3) NOT NULL,
  `RESIDENT_STATUS_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`RESIDENT_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `resident_status` (`RESIDENT_STATUS_ID`, `RESIDENT_STATUS_NAME`) VALUES
	(1, 'ACTIVE'),
	(2, 'ACTIVATION_PENDING'),
	(3, 'INACTIVE'),
	(4, 'DEACTIVATED');
-- Dumping structure for table smart_nehiborhood.super_admin_group_users
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


-- Dumping structure for table smart_nehiborhood.trip_registry
CREATE TABLE IF NOT EXISTS `trip_registry` (
  `TRIP_REGISTRY_ID` int(10) NOT NULL,
  `TRIP_SCHEDULE_ID` int(10) NOT NULL,
  `REGISTERED_RESIDENT_ID` int(10) NOT NULL,
  `ADDITIONAL_PASSENGER_COUNT` int(2) NOT NULL,
  `SOURCE_LOCATION_ID` int(10) NOT NULL,
  `DESTINATION_LOCATION_ID` int(10) NOT NULL,
  `TRIP_SCHEDULE_DATE` datetime DEFAULT NULL,
  `RECURRING_TRIP_TYPE_ID` int(3) DEFAULT NULL,
  PRIMARY KEY (`TRIP_REGISTRY_ID`),
  KEY `fk_TRIP_REGISTRY_TRIP_SCHEDULE1` (`TRIP_SCHEDULE_ID`),
  KEY `fk_TRIP_REGISTRY_RESIDENT_MASTER_ID1` (`REGISTERED_RESIDENT_ID`),
  KEY `fk_TRIP_REGISTRY_RESIDENT_LOCATION1` (`SOURCE_LOCATION_ID`),
  KEY `fk_TRIP_REGISTRY_RESIDENT_LOCATION2` (`DESTINATION_LOCATION_ID`),
  KEY `fk_TRIP_REGISTRY_TRIP_RECURRINT_TYPE1` (`RECURRING_TRIP_TYPE_ID`),
  CONSTRAINT `fk_TRIP_REGISTRY_TRIP_RECURRING_TYPE1` FOREIGN KEY (`RECURRING_TRIP_TYPE_ID`) REFERENCES `recurring_trip_type` (`RECURRING_TRIP_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	
  CONSTRAINT `fk_TRIP_REGISTRY_TRIP_SCHEDULE1` FOREIGN KEY (`TRIP_SCHEDULE_ID`) REFERENCES `trip_schedule` (`TRIP_SCHEDULE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_REGISTRY_RESIDENT_MASTER_ID1` FOREIGN KEY (`REGISTERED_RESIDENT_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_REGISTRY_RESIDENT_LOCATION1` FOREIGN KEY (`SOURCE_LOCATION_ID`) REFERENCES `resident_location` (`LOCATION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_REGISTRY_RESIDENT_LOCATION2` FOREIGN KEY (`DESTINATION_LOCATION_ID`) REFERENCES `resident_location` (`LOCATION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.trip_schedule
CREATE TABLE IF NOT EXISTS `trip_schedule` (
  `TRIP_SCHEDULE_ID` int(10) NOT NULL,
  `COMMUNITY_ID` int(10) NOT NULL,
  `RESIDENT_MASTER_ID` int(10) NOT NULL,
  `VEHICLE_DETAILS_ID` int(10) NOT NULL,
  `SOURCE_LOCATION_ID` int(10) NOT NULL,
  `DESTINATION_LOCATION_ID` int(10) NOT NULL,
  `TRIP_DATE_TIME` timestamp NULL DEFAULT NULL,
  `EMPTY_SEAT_COUNT` int(2) NOT NULL,
  `RECURRING_TRIP_TYPE_ID` int(3) DEFAULT NULL,
  PRIMARY KEY (`TRIP_SCHEDULE_ID`),
  KEY `fk_TRIP_SCHEDULE_RESIDENT_MASTER_ID1` (`RESIDENT_MASTER_ID`),
  KEY `fk_TRIP_SCHEDULE_VEHICLE_DETAILS1` (`VEHICLE_DETAILS_ID`),
  KEY `fk_TRIP_SCHEDULE_RESIDENT_LOCATION1` (`SOURCE_LOCATION_ID`),
  KEY `fk_TRIP_SCHEDULE_RESIDENT_LOCATION2` (`DESTINATION_LOCATION_ID`),
  KEY `fk_TRIP_SCHEDULE_RECURRING_TRIP_TYPE1` (`RECURRING_TRIP_TYPE_ID`),
  CONSTRAINT `fk_TRIP_SCHEDULE_RECURRING_TRIP_TYPE1` FOREIGN KEY (`RECURRING_TRIP_TYPE_ID`) REFERENCES `recurring_trip_type` (`RECURRING_TRIP_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_SCHEDULE_RESIDENT_MASTER_ID1` FOREIGN KEY (`RESIDENT_MASTER_ID`) REFERENCES `resident_master` (`RESIDENT_MASTER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_SCHEDULE_VEHICLE_DETAILS1` FOREIGN KEY (`VEHICLE_DETAILS_ID`) REFERENCES `vehicle_details` (`VEHICLE_DETAILS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_SCHEDULE_RESIDENT_LOCATION1` FOREIGN KEY (`SOURCE_LOCATION_ID`) REFERENCES `resident_location` (`LOCATION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRIP_SCHEDULE_RESIDENT_LOCATION2` FOREIGN KEY (`DESTINATION_LOCATION_ID`) REFERENCES `resident_location` (`LOCATION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Dumping structure for table smart_nehiborhood.users
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


-- Dumping structure for table smart_nehiborhood.users_status
CREATE TABLE IF NOT EXISTS `users_status` (
  `USERS_STATUS_ID` int(3) NOT NULL,
  `USERS_STATUS_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`USERS_STATUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users_status` (`USERS_STATUS_ID`, `USERS_STATUS_NAME`) VALUES
	(1, 'ACTIVE'),
	(2, 'INACTIVE');

-- Dumping structure for table smart_nehiborhood.user_resident_mapping
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


-- Dumping structure for table smart_nehiborhood.vehicle_details
CREATE TABLE IF NOT EXISTS `vehicle_details` (
  `VEHICLE_DETAILS_ID` int(10) NOT NULL,
  `VEHICLE_TYPE_ID` int(10) NOT NULL,
  `VEHICLE_REGISTRATION_NO` varchar(20) NOT NULL,
  `MAX_OCCUPANCY` int(3) NOT NULL,
  `VEHICLE_NICK_NAME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`VEHICLE_DETAILS_ID`),
  KEY `fk_VEHICLE_DETAILS_ID_VEHICLE_TYPE1` (`VEHICLE_TYPE_ID`),
  CONSTRAINT `fk_VEHICLE_DETAILS_ID_VEHICLE_TYPE1` FOREIGN KEY (`VEHICLE_TYPE_ID`) REFERENCES `vehicle_type` (`VEHICLE_TYPE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping structure for table smart_nehiborhood.vehicle_type
CREATE TABLE IF NOT EXISTS `vehicle_type` (
  `VEHICLE_TYPE_ID` int(10) NOT NULL,
  `VEHICLE_TYPE_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`VEHICLE_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vendor_type` (
  `VENDOR_TYPE_ID` int(10) NOT NULL,
  `VENDOR_TYPE_NAME` varchar(50) NOT NULL,
  `DEFAULT_TYPE` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`VENDOR_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

