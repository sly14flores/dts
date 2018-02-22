-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 21, 2018 at 08:46 AM
-- Server version: 5.7.11
-- PHP Version: 7.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dts`
--

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `file_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `communications`
--

CREATE TABLE `communications` (
  `id` int(11) NOT NULL,
  `communication` varchar(400) DEFAULT NULL,
  `shortname` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `communications`
--

INSERT INTO `communications` (`id`, `communication`, `shortname`) VALUES
(1, 'To Internal', 'INT'),
(2, 'To External', 'EXT');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `dept` varchar(200) DEFAULT NULL,
  `shortname` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `dept`, `shortname`) VALUES
(1, 'OFFICE OF THE PROVINCIAL GOVERNOR', 'OPG'),
(2, 'OFFICE OF THE PROVINCIAL ADMINISTRATOR', 'ADM'),
(3, 'OFFICE OF THE PROVINCIAL VICE-GOVERNOR', 'VG'),
(4, 'OFFICE OF THE SANGGUNIANG PANLALAWIGAN', 'SP'),
(5, 'OFFICE OF THE PROVINCIAL TREASURER', 'PTO'),
(6, 'OFFICE OF THE PROVINCIAL ASSESSOR', 'ASS'),
(7, 'OFFICE OF THE PROVINCIAL BUDGET OFFICER', 'PBO'),
(8, 'OFFICE OF THE PROVINCIAL ACCOUNTANT', 'ACC'),
(9, 'OFFICE OF THE PROVINCIAL POPULATION OFFICER', 'PPO'),
(10, 'OFFICE OF THE PROVINCIAL ENGINEER', 'PEO'),
(11, 'OFFICE OF THE PROVINCIAL INFORMATION & TOURISM OFFICER', 'PITO'),
(12, 'OFFICE OF THE PROVINCIAL SOCIAL WELFARE & DEVELOPMENT OFFICER', 'PSWDO'),
(13, 'OFFICE OF THE PROVINCIAL PLANNING & DEVELOPMENT COORDINATOR', 'PPDC'),
(14, 'OFFICE OF THE PROVINCIAL GENERAL SERVICES OFFICER', 'PGSO'),
(15, 'OFFICE OF THE PROVINCIAL VETERINARIAN', 'VET'),
(16, 'OFFICE OF THE PROVINCIAL AGRICULTURIST', 'OPAG'),
(17, 'OFFICE OF THE PROVINCIAL LEGAL OFFICER', 'PLO'),
(18, 'Office of the Provincial Health Officer', 'PHO'),
(19, 'BACNOTAN DISTRICT HOSPITAL', 'BAC. DH'),
(20, 'BALAOAN DISTRICT HOSPITAL', 'BAL. DH'),
(21, 'CABA DISTRICT HOSPITAL', 'CDH'),
(22, 'NAGUILIAN DISTRICT HOSPITAL', 'NDH'),
(23, 'ROSARIO DISTRICT HOSPITAL', 'RDH'),
(24, 'RANDOM', 'RND');

-- --------------------------------------------------------

--
-- Table structure for table `divisions`
--

CREATE TABLE `divisions` (
  `id` int(11) NOT NULL,
  `division` varchar(200) DEFAULT NULL,
  `shortname` varchar(50) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `divisions`
--

INSERT INTO `divisions` (`id`, `division`, `shortname`, `dept_id`) VALUES
(1, 'Provincial Disaster Risk Reduction Management Council', 'PDRRMC', 1),
(2, 'Office of the Provincial Strategist', 'OPS', 1),
(3, 'Human Resource Management Division', 'HRMD', 1),
(4, 'Personal Staff', 'PS', 1),
(5, 'Information and Communication Technology Division', 'ICTD', 1),
(6, 'Security Services Division', 'SSD', 1),
(7, 'La Union Provincial Jail', 'LUPJ', 1),
(8, 'Administrative Division', 'AD', 6),
(9, 'Assessment Standards and Examination Division', 'ASED', 6),
(10, 'Property Valuation and Examination Division', 'PVAED', 6),
(11, 'Tax Mapping Division', 'TMD', 6),
(12, 'Assessment Records Management Division', 'ARMD', 6),
(13, 'Administrative Division', 'AD', 5),
(14, 'Local Treasury Operations Review Division', 'LTORD', 5),
(15, 'Revenue Operations Division', 'ROD', 5),
(16, 'Cash Receipts Division', 'CRD', 5),
(17, 'Field Supervision Division', 'FSD', 5),
(18, 'Cash Disbursement Division', 'CDD', 5),
(19, 'APT', 'APT', 5),
(20, 'Administrative Division', 'AD', 14),
(21, 'Building, Grounds and Parks Maintenance Division', 'BGAPMD', 14),
(22, 'Supply and Property Division', 'SAPD', 14),
(23, 'Administrative Division', 'AD', 8),
(24, 'Accountability Division', 'ACCD', 8),
(25, 'Internal Control Division', 'ICD', 8),
(26, 'Special Accounts Division', 'SAD', 8),
(27, 'Administrative Division', 'AD', 10),
(28, 'Planning and Programming Division', 'PAPD', 10),
(29, 'Construction Division', 'CD', 10),
(30, 'Maintenance Division', 'MD', 10),
(31, 'Quality Control Division', 'QCD', 10),
(32, 'Motorpool Division', 'MD', 10),
(33, 'Administrative Division', 'AD', 11),
(34, 'Library Division', 'LD', 11),
(35, 'Public Information Division', 'PID', 11),
(36, 'Radio and Communication Operations Division', 'RACOD', 11),
(37, 'Tourism Operations Division', 'TOD', 11),
(38, 'Administrative Division', 'AD', 7),
(39, 'Municipal Budget Division', 'MBD', 7),
(40, 'Provincial Division', 'PD', 7),
(41, 'PUBLIC EMPLOYMENT & SERVICE OFFICE', 'PESO', 12),
(42, 'CHILD DEVELOPMENT WORKERS', 'CDW', 12),
(43, 'CONTRACT OF SERVICE', 'COS', 1),
(44, 'BID AND AWARDS COMMITTEE', 'BAC', 1),
(45, 'ENVIRONMENT AND NATURAL RESOURCES OFFICE', 'ENRO', 1),
(46, '911', 'OPG-911 EMERGENCY HOTLINE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(50) NOT NULL,
  `user_id` int(50) DEFAULT NULL,
  `doc_name` varchar(350) DEFAULT NULL,
  `barcode` varchar(500) DEFAULT NULL,
  `origin` varchar(500) DEFAULT NULL,
  `other_origin` varchar(500) DEFAULT NULL,
  `date_enrolled` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `transaction` varchar(500) DEFAULT NULL,
  `doc_type` varchar(500) DEFAULT NULL,
  `communication` varchar(150) NOT NULL,
  `remarks` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `document_types`
--

CREATE TABLE `document_types` (
  `id` int(11) NOT NULL,
  `document_type` varchar(500) DEFAULT NULL,
  `shortname` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `document_types`
--

INSERT INTO `document_types` (`id`, `document_type`, `shortname`) VALUES
(1, 'RESOLUTIONS', 'RES'),
(2, 'ORDERS', 'OR'),
(3, 'LETTERS', 'LET'),
(4, 'TRAVELS', 'TR'),
(5, 'CONTRACTS', 'CON'),
(6, 'COMMUNICATIONS', 'COM'),
(7, 'MEMORANDUMS', 'MEM'),
(8, 'APPOINMENTS', 'APM'),
(9, 'CERTIFICATES', 'CER'),
(10, 'MESSAGES', 'MES'),
(11, 'DAILY TIME RECORD', 'DTR'),
(12, 'CLEARANCE ', 'CL'),
(13, 'APPLICATIONS', 'APP'),
(14, 'PROPOSALS', 'PRO'),
(15, 'LEAVE', 'LV'),
(16, 'PLANTILLA', 'PL'),
(17, 'COMPENSATORY TIME OFF', 'CTO');

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `document_id` int(11) DEFAULT NULL,
  `file_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `id` int(11) NOT NULL,
  `office` varchar(200) DEFAULT NULL,
  `shortname` varchar(50) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`id`, `office`, `shortname`, `dept_id`) VALUES
(2, 'Office of the Provincial Strategist', 'OPS', 19),
(3, 'Human Resource Management Division', 'HRMD', 1),
(4, 'Personal Staff', 'PS', 1),
(5, 'Information and Communication Technology Division', 'ICTD', 1),
(6, 'Security Services Division', 'SSD', 1),
(7, 'La Union Provincial Jail', 'LUPJ', 1),
(8, 'Administrative Division', 'ADA', 6),
(9, 'Assessment Standards and Examination Division', 'ASED', 6),
(10, 'Property Valuation and Examination Division', 'PVAED', 6),
(11, 'Tax Mapping Division', 'TMD', 6),
(12, 'Assessment Records Management Division', 'ARMD', 6),
(13, 'Administrative Division', 'ADT', 5),
(14, 'Local Treasury Operations Review Division', 'LTORD', 5),
(15, 'Revenue Operations Division', 'ROD', 5),
(16, 'Cash Receipts Division', 'CRD', 5),
(17, 'Field Supervision Division', 'FSD', 5),
(18, 'Cash Disbursement Division', 'CDD', 5),
(19, 'APT', 'APT', 5),
(20, 'Administrative Division', 'ADS', 14),
(21, 'Building, Grounds and Parks Maintenance Division', 'BGAPMD', 14),
(22, 'Supply and Property Division', 'SAPD', 14),
(23, 'Administrative Division', 'AD', 8),
(24, 'Accountability Division', 'ACCD', 8),
(25, 'Internal Control Division', 'ICD', 8),
(26, 'Special Accounts Division', 'SAD', 8),
(27, 'Administrative Division', 'AD', 10),
(28, 'Planning and Programming Division', 'PAPD', 10),
(29, 'Construction Division', 'CD', 10),
(30, 'Maintenance Division', 'MD', 10),
(31, 'Quality Control Division', 'QCD', 10),
(32, 'Motorpool Division', 'MD', 10),
(33, 'Administrative Division', 'AD', 11),
(34, 'Library Division', 'LD', 11),
(35, 'Public Information Division', 'PID', 11),
(36, 'Radio and Communication Operations Division', 'RACOD', 11),
(37, 'Tourism Operations Division', 'TOD', 11),
(38, 'Administrative Division', 'AD', 7),
(39, 'Municipal Budget Division', 'MBD', 7),
(40, 'Provincial Division', 'PD', 7),
(41, 'PUBLIC EMPLOYMENT & SERVICE OFFICE', 'PESO', 12),
(42, 'CHILD DEVELOPMENT WORKERS', 'CDW', 12),
(43, 'CONTRACT OF SERVICE', 'COS', 1),
(44, 'BID AND AWARDS COMMITTEE', 'BAC', 1),
(45, 'ENVIRONMENT AND NATURAL RESOURCES OFFICE', 'ENRO', 1),
(47, 'Others', 'OTH', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(11) NOT NULL,
  `choice` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `choice`) VALUES
(1, 'FOR COMMENT/RECOMMENDATION'),
(2, 'FOR DISSEMINATION'),
(3, 'RETURN DOCUMENTS TO ME'),
(4, 'APPROVED'),
(5, 'PLEASE HANDLE'),
(6, 'PLEASE PREPARE REPLY LETTER'),
(7, 'FOR FILE'),
(8, 'FOR INFORMATION/REFERENCE'),
(9, 'LET US DISCUSS/SEE ME'),
(10, 'FOR REVIEW/EVALUATION'),
(11, 'PLEASE ATTEND'),
(12, 'FOR APPROPRIATE ACTION'),
(13, 'PLEASE PREPARE SPEECH/MESSAGE'),
(14, 'PLEASE CONFIRM');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `transaction` varchar(400) DEFAULT NULL,
  `days` int(50) DEFAULT NULL,
  `shortname` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction`, `days`, `shortname`) VALUES
(1, 'Simple', 5, 'SIM'),
(2, 'Complex', 10, 'COM');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `uname` varchar(50) DEFAULT NULL,
  `pw` varchar(50) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL,
  `div_id` int(11) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `phone_number` bigint(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `mname`, `lname`, `position`, `uname`, `pw`, `employee_id`, `div_id`, `email_address`, `phone_number`) VALUES
(1, 'Sylvester', 'B', 'Flores', 'Sly', 'sly', 'legend', '003', 5, 'sly@christian.com.ph', 9198745632),
(8, 'Karl Aaron', 'Masancay', 'Castaneda', 'OJT', 'aaron', '54321', '21331', 5, 'aaron.casty02@yahoo.com', 9298902184),
(11, 'Mc Glenn', 'Gundran', 'Tangalin', 'Junior Software Developer', 'admin', 'admin', '1002413', 5, 'mcglenn.tangalin@lorma.edu', 9301598842),
(13, 'Renwil', 'Gatchallan', 'Flores', 'OJT', 'renn', 'renn', '201231', 5, 'ren@wil.com', 909090909),
(14, 'Alain', 'M.', 'Dayao II', 'OJT', 'alain', '123456789', '21322', 5, 'al@al.com', 9123456789);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`);

--
-- Indexes for table `communications`
--
ALTER TABLE `communications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `divisions`
--
ALTER TABLE `divisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `div_id` (`div_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `divisions`
--
ALTER TABLE `divisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `divisions`
--
ALTER TABLE `divisions`
  ADD CONSTRAINT `divisions_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
