CREATE TABLE `aircrafts` (
  `code` char(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` char(1) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airlines` (
  `code` char(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  `short_name` varchar(20) DEFAULT NULL,
  `country` char(2) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `name` (`name`),
  KEY `country` (`country`),
  CONSTRAINT `airlines_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airports` (
  `code` char(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(5) DEFAULT NULL,
  `country` char(2) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `utc_offset` float NOT NULL DEFAULT '0',
  `dst` char(1) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `name` (`name`),
  KEY `country` (`country`),
  KEY `airports_idx` (`city`,`country`),
  CONSTRAINT `airports_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `countries` (
  `code` char(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  `continent` varchar(30) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flights` (
  `departure` char(3) NOT NULL,
  `arrival` char(3) NOT NULL,
  `day_op` varchar(7) NOT NULL,
  `dep_time` char(5) NOT NULL,
  `carrier` char(2) NOT NULL,
  `airline` char(2) NOT NULL,
  `flightnum` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `aircraft` char(3) NOT NULL,
  PRIMARY KEY (`departure`,`airline`,`flightnum`,`day_op`),
  KEY `arrival` (`arrival`),
  KEY `carrier` (`carrier`),
  KEY `airline` (`airline`),
  KEY `aircraft` (`aircraft`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`departure`) REFERENCES `airports` (`code`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`arrival`) REFERENCES `airports` (`code`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`carrier`) REFERENCES `airlines` (`code`),
  CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`airline`) REFERENCES `airlines` (`code`),
  CONSTRAINT `flights_ibfk_5` FOREIGN KEY (`aircraft`) REFERENCES `aircrafts` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

