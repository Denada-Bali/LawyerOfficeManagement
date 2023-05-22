-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 20, 2023 at 09:43 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lawyerofficedb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCases` ()   BEGIN
    SELECT * FROM cases;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClients` ()   BEGIN
    SELECT * FROM client;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLawyers` ()   BEGIN
    SELECT * FROM lawyer;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `CaseId` int(11) NOT NULL,
  `lawyerId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `statusCase` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`CaseId`, `lawyerId`, `clientId`, `startDate`, `statusCase`) VALUES
(1, 2, 1, '2023-05-18', 'Pending '),
(2, 1, 3, '2023-05-18', 'Pending '),
(5, 7, 18, '2021-02-21', 'Close'),
(6, 4, 17, '2023-01-12', 'Pending '),
(7, 2, 8, '2020-12-28', 'Close'),
(8, 6, 9, '2023-04-06', 'Active '),
(14, 10, 21, '2023-04-18', 'Pending '),
(17, 1, 16, '2019-06-29', 'Close'),
(19, 1, 15, '2023-05-15', 'Pending '),
(21, 11, 26, '2023-05-20', 'Pending ');

--
-- Triggers `cases`
--
DELIMITER $$
CREATE TRIGGER `after_delete_backup_cases` AFTER DELETE ON `cases` FOR EACH ROW INSERT IGNORE INTO cases_backup (id, lawyerId, clientId, startDate, statusCase)
    VALUES (OLD.CaseId, OLD.lawyerId, OLD.clientId, OLD.startDate, OLD.statusCase)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_backup_cases` AFTER INSERT ON `cases` FOR EACH ROW INSERT INTO cases_backup (id, lawyerId, clientId, startDate, statusCase)
    VALUES (NEW.CaseId, NEW.lawyerId, NEW.clientId, NEW.startDate, NEW.statusCase)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_backup_cases` AFTER UPDATE ON `cases` FOR EACH ROW INSERT INTO cases_backup (id, lawyerId, clientId, startDate, statusCase)
    VALUES (NEW.CaseId, NEW.lawyerId, NEW.clientId, NEW.startDate, NEW.statusCase)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cases_backup`
--

CREATE TABLE `cases_backup` (
  `id` int(11) NOT NULL,
  `lawyerId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `statusCase` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cases_backup`
--

INSERT INTO `cases_backup` (`id`, `lawyerId`, `clientId`, `startDate`, `statusCase`) VALUES
(0, 0, 0, '2023-05-18', 'Pending '),
(0, 0, 0, '2023-04-18', 'Pending '),
(0, 0, 0, '2019-06-12', 'Close'),
(0, 0, 0, '2019-06-29', 'Close'),
(0, 0, 0, '2023-05-20', 'Active '),
(0, 0, 0, '2023-05-15', 'Pending '),
(20, 11, 26, '2023-05-20', 'Pending '),
(20, 11, 26, '2023-05-20', 'Active '),
(20, 11, 26, '2023-05-20', 'Active '),
(21, 11, 26, '2023-05-20', 'Pending ');

-- --------------------------------------------------------

--
-- Stand-in structure for view `caseview`
-- (See below for the actual view)
--
CREATE TABLE `caseview` (
`LawyerName` varchar(60)
,`ClientName` varchar(60)
);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `clientId` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phoneNumber` varchar(13) NOT NULL,
  `email` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`clientId`, `name`, `surname`, `address`, `phoneNumber`, `email`) VALUES
(1, 'Denalda', 'Bali', 'Elbasan', '111000222', 'denaldabali@gmail.com'),
(3, 'Dne', 'Bal', 'Tirane', '444000555', 'd@gmail.com'),
(8, 'Jane', 'Gray', 'New York', '1002000', 'Jane.gray@outlook.edu.al'),
(9, 'Brown', 'Carpet', 'Manhattan', '1200455', 'b.c@outlook.com'),
(15, 'Miley ', 'Cyrus', 'Los Angeles ', '99988333', 'mileycyrus@gmail.com'),
(16, 'Lana Del ', 'Rey', 'California', '10002228', 'lanadlrey@something.com'),
(17, 'Rahul', 'Gray', 'New York', '77788866', 'rahulg@outlook.com'),
(18, 'Nadia ', 'Gray', 'New York', '66888777', 'nadiag@outlook.com'),
(19, 'Elon', 'Musk', 'California', '665544', 'musk@something.com'),
(21, 'Tom', 'Cruise', 'Texas', '44433355', 'tom.cruise@gmail.com'),
(26, 'Tom', 'Smith', 'Alaska', '5554444666', 'tm@smith.com');

--
-- Triggers `client`
--
DELIMITER $$
CREATE TRIGGER `after_delete_backup` BEFORE DELETE ON `client` FOR EACH ROW INSERT INTO client_backup (Id, name, surname, address, phoneNumber, email)
    VALUES (OLD.clientId, OLD.name, OLD.surname, OLD.address, OLD.phoneNumber, OLD.email)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_backup` BEFORE INSERT ON `client` FOR EACH ROW INSERT INTO client_backup (Id, name, surname, address, phoneNumber, email)
    VALUES (NEW.clientId, NEW.name, NEW.surname, NEW.address, NEW.phonenumber, NEW.email)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_backup` AFTER UPDATE ON `client` FOR EACH ROW INSERT INTO client_backup (Id, name, surname, address, phoneNumber, email)
    VALUES (NEW.clientId, NEW.name, NEW.surname, NEW.address, NEW.phonenumber, NEW.email)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `client_backup`
--

CREATE TABLE `client_backup` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phoneNumber` int(13) NOT NULL,
  `email` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client_backup`
--

INSERT INTO `client_backup` (`id`, `name`, `surname`, `address`, `phoneNumber`, `email`) VALUES
(0, 'Robert ', 'Downey', 'New York', 888844443, 'r.downey@something.com'),
(0, 'Elizabeth', 'Taylor', 'Texas', 776665554, 't@something.com'),
(0, 'Dne', 'Bal', 'Tirane', 444000555, 'd@gmail.com'),
(0, 'Lana Del ', 'Rey', 'California', 10002228, 'lanadlrey@something.com'),
(0, 'Elon', 'Musk', 'California', 665544, 'musk@something.com'),
(0, 'Robert ', 'Downey', 'New York', 888844443, 'r.downey@something.com'),
(0, 'Elizabeth', 'Taylor', 'Texas', 776665554, 't@something.com'),
(0, 'tom ', 'smith', 'Alaska', 55544466, 'tm@something'),
(25, 'Tom', 'Smith', 'Alaska', 55544466, 'tm@something'),
(25, 'Tom', 'Smith', 'Alaska', 55544466, 'tm@something'),
(0, 'Tom', 'Smith', 'Alaska', 2147483647, 'tm@smith.com');

-- --------------------------------------------------------

--
-- Table structure for table `lawyer`
--

CREATE TABLE `lawyer` (
  `lawyerId` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lawyer`
--

INSERT INTO `lawyer` (`lawyerId`, `name`, `surname`, `specialization`, `salary`) VALUES
(1, 'Mickey', 'Cat', 'Criminal Law', 2000),
(2, 'Capo', 'Cat', 'Health Care Law', 2000),
(4, 'Jane', 'Doe', 'Environmental Law', 2100),
(6, 'John', 'Doe', 'First Amendment Law', 3100),
(7, 'Mary Jane', 'Watson', 'Constitutional Law', 3200),
(10, 'Emma', 'Watson', 'Environmental Law', 4300),
(11, 'Meghan', 'Markle', 'First Amendment Law', 3500);

--
-- Triggers `lawyer`
--
DELIMITER $$
CREATE TRIGGER `after_delete_backup_lawyer` AFTER DELETE ON `lawyer` FOR EACH ROW INSERT IGNORE INTO lawyer_backup (id, name, surname, specialization, salary)
    VALUES (OLD.lawyerId, OLD.name, OLD.surname, OLD.specialization, OLD.salary)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_backup_lawyer` AFTER INSERT ON `lawyer` FOR EACH ROW INSERT INTO lawyer_backup (id, name, surname, specialization, salary)
    VALUES (NEW.lawyerId, NEW.name, NEW.surname, NEW.specialization, NEW.salary)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_backup_lawyer` AFTER UPDATE ON `lawyer` FOR EACH ROW INSERT INTO lawyer_backup (id, name, surname, specialization, salary)
    VALUES (NEW.lawyerId, NEW.name, NEW.surname, NEW.specialization, NEW.salary)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `lawyerclientcaseview`
-- (See below for the actual view)
--
CREATE TABLE `lawyerclientcaseview` (
`ClientFullName` varchar(121)
,`LawyerFullName` varchar(121)
,`specialization` varchar(100)
,`startDate` date
,`statusCase` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lawyerclientview`
-- (See below for the actual view)
--
CREATE TABLE `lawyerclientview` (
`ClientFullName` varchar(121)
,`LawyerFullName` varchar(121)
,`specialization` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `lawyer_backup`
--

CREATE TABLE `lawyer_backup` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lawyer_backup`
--

INSERT INTO `lawyer_backup` (`id`, `name`, `surname`, `specialization`, `salary`) VALUES
(0, 'Mickey', 'Cat', 'Criminal Law', 2000),
(0, 'Greta', 'Garbo', 'Constitutional Law', 3400),
(0, 'Emma', 'Watson', 'Environmental Law', 4300),
(11, 'Meghan', 'Markle', 'First Amendment Law', 4000),
(11, 'Meghan', 'Markle', 'First Amendment Law', 3500),
(12, 'test', 'test', 'test', 9000),
(12, 'test', 'test', 'test', 9000);

-- --------------------------------------------------------

--
-- Structure for view `caseview`
--
DROP TABLE IF EXISTS `caseview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `caseview`  AS SELECT `lawyer`.`name` AS `LawyerName`, `client`.`name` AS `ClientName` FROM ((`cases` join `lawyer` on(`cases`.`lawyerId` = `lawyer`.`lawyerId`)) join `client` on(`cases`.`clientId` = `client`.`clientId`))  ;

-- --------------------------------------------------------

--
-- Structure for view `lawyerclientcaseview`
--
DROP TABLE IF EXISTS `lawyerclientcaseview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lawyerclientcaseview`  AS SELECT concat(`client`.`name`,' ',`client`.`surname`) AS `ClientFullName`, concat(`lawyer`.`name`,' ',`lawyer`.`surname`) AS `LawyerFullName`, `lawyer`.`specialization` AS `specialization`, `cases`.`startDate` AS `startDate`, `cases`.`statusCase` AS `statusCase` FROM ((`cases` join `lawyer` on(`cases`.`lawyerId` = `lawyer`.`lawyerId`)) join `client` on(`cases`.`clientId` = `client`.`clientId`))  ;

-- --------------------------------------------------------

--
-- Structure for view `lawyerclientview`
--
DROP TABLE IF EXISTS `lawyerclientview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lawyerclientview`  AS SELECT concat(`client`.`name`,' ',`client`.`surname`) AS `ClientFullName`, concat(`lawyer`.`name`,' ',`lawyer`.`surname`) AS `LawyerFullName`, `lawyer`.`specialization` AS `specialization` FROM ((`cases` join `lawyer` on(`cases`.`lawyerId` = `lawyer`.`lawyerId`)) join `client` on(`cases`.`clientId` = `client`.`clientId`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`CaseId`),
  ADD KEY `clientFK` (`clientId`),
  ADD KEY `lawyerFK` (`lawyerId`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`clientId`);

--
-- Indexes for table `lawyer`
--
ALTER TABLE `lawyer`
  ADD PRIMARY KEY (`lawyerId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cases`
--
ALTER TABLE `cases`
  MODIFY `CaseId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `clientId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `lawyer`
--
ALTER TABLE `lawyer`
  MODIFY `lawyerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cases`
--
ALTER TABLE `cases`
  ADD CONSTRAINT `clientFK` FOREIGN KEY (`clientId`) REFERENCES `client` (`clientId`),
  ADD CONSTRAINT `lawyerFK` FOREIGN KEY (`lawyerId`) REFERENCES `lawyer` (`lawyerId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
