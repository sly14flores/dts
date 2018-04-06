-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 06, 2018 at 02:49 PM
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
(24, 'OTHERS', 'OTH');

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
  `origin` int(11) DEFAULT NULL,
  `other_origin` varchar(500) DEFAULT NULL,
  `document_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `document_transaction_type` int(11) DEFAULT NULL,
  `doc_type` int(11) DEFAULT NULL,
  `communication` int(11) DEFAULT NULL,
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
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `group_name` varchar(50) DEFAULT NULL,
  `group_description` varchar(50) DEFAULT NULL,
  `privileges` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_name`, `group_description`, `privileges`) VALUES
(1, 'Admin', 'Administrator', '225B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2244617368626F6172645C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772044617368626F6172645C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C225265636569766520446F63756D656E745C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205265636569766520446F63756D656E745C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420446F63756D656E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22496E636F6D696E675C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205265636569766520446F63756D656E745C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420446F63756D656E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C22446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204D7920446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A352C5C226465736372697074696F6E5C223A5C224C697374206F6620446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204C697374206F6620446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A362C5C226465736372697074696F6E5C223A5C22547261636B735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720547261636B73206F6620446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A372C5C226465736372697074696F6E5C223A5C224163636F756E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772055736572204163636F756E74735C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164642055736572204163636F756E745C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22456469742055736572204163636F756E745C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C6574652055736572204163636F756E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A382C5C226465736372697074696F6E5C223A5C2247726F7570735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720557365722047726F7570735C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420557365722047726F7570735C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C224564697420557365722047726F7570735C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C65746520557365722047726F7570735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A392C5C226465736372697074696F6E5C223A5C224D61696E74656E616E63655C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204D61696E74656E616E63655C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164645C5C5C2F45646974204974656D5C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C2244656C657465204974656D5C222C5C2276616C75655C223A747275657D5D7D5D22'),
(2, 'PA', 'Provincial Administrator', '225B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2244617368626F6172645C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772044617368626F6172645C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C225265636569766520446F63756D656E745C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205265636569766520446F63756D656E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420446F63756D656E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22496E636F6D696E675C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720496E636F6D696E6720446F63756D656E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C22446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A352C5C226465736372697074696F6E5C223A5C224C697374206F6620446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204C697374206F6620446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A362C5C226465736372697074696F6E5C223A5C22547261636B735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720547261636B73206F6620446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A372C5C226465736372697074696F6E5C223A5C224163636F756E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772055736572204163636F756E74735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164642055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22456469742055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C6574652055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A382C5C226465736372697074696F6E5C223A5C2247726F7570735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C224564697420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C65746520557365722047726F7570735C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A392C5C226465736372697074696F6E5C223A5C224D61696E74656E616E63655C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204D61696E74656E616E63655C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164645C5C5C2F45646974204974656D5C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C2244656C657465204974656D5C222C5C2276616C75655C223A66616C73657D5D7D5D22'),
(3, 'PA Staffs', 'Provincial Administrator Staffs', '225B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2244617368626F6172645C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772044617368626F6172645C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C225265636569766520446F63756D656E745C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205265636569766520446F63756D656E745C222C5C2276616C75655C223A747275657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420446F63756D656E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22496E636F6D696E675C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720496E636F6D696E6720446F63756D656E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C22446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A352C5C226465736372697074696F6E5C223A5C224C697374206F6620446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204C697374206F6620446F63756D656E74735C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A362C5C226465736372697074696F6E5C223A5C22547261636B735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720547261636B735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A372C5C226465736372697074696F6E5C223A5C224163636F756E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772055736572204163636F756E74735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164642055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22456469742055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C6574652055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A382C5C226465736372697074696F6E5C223A5C2247726F7570735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C224564697420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C65746520557365722047726F7570735C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A392C5C226465736372697074696F6E5C223A5C224D61696E74656E616E63655C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204D61696E74656E616E63655C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164645C5C5C2F45646974204974656D5C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C2244656C657465204974656D5C222C5C2276616C75655C223A66616C73657D5D7D5D22'),
(4, 'Liason Officers', 'Receive Incoming Documents', '225B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2244617368626F6172645C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772044617368626F6172645C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C225265636569766520446F63756D656E745C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205265636569766520446F63756D656E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420446F63756D656E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22496E636F6D696E675C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720496E636F6D696E6720446F63756D656E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C22446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A352C5C226465736372697074696F6E5C223A5C224C697374206F6620446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204C697374206F6620446F63756D656E74735C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A362C5C226465736372697074696F6E5C223A5C22547261636B735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720547261636B73206F6620446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A372C5C226465736372697074696F6E5C223A5C224163636F756E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772055736572204163636F756E74735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164642055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22456469742055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C6574652055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A382C5C226465736372697074696F6E5C223A5C2247726F7570735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C224564697420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C65746520557365722047726F7570735C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A392C5C226465736372697074696F6E5C223A5C224D61696E74656E616E63655C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204D61696E74656E616E63655C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164645C5C5C2F45646974204974656D5C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C2244656C657465204974656D5C222C5C2276616C75655C223A66616C73657D5D7D5D22'),
(5, 'Governor', 'Provincial Governor', '225B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2244617368626F6172645C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772044617368626F6172645C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C225265636569766520446F63756D656E745C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205265636569766520446F63756D656E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420446F63756D656E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22496E636F6D696E675C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720496E636F6D696E6720446F63756D656E745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C225472616E736163745C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77205472616E736163745C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A352C5C226465736372697074696F6E5C223A5C224C697374206F6620446F63756D656E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204C697374206F6620446F63756D656E74735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A362C5C226465736372697074696F6E5C223A5C22547261636B735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720547261636B735C222C5C2276616C75655C223A747275657D5D7D2C7B5C2269645C223A372C5C226465736372697074696F6E5C223A5C224163636F756E74735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F772055736572204163636F756E74735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164642055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C22456469742055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C6574652055736572204163636F756E745C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A382C5C226465736372697074696F6E5C223A5C2247726F7570735C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F7720557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C2241646420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C224564697420557365722047726F7570735C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A342C5C226465736372697074696F6E5C223A5C2244656C65746520557365722047726F7570735C222C5C2276616C75655C223A66616C73657D5D7D2C7B5C2269645C223A392C5C226465736372697074696F6E5C223A5C224D61696E74656E616E63655C222C5C2270726976696C656765735C223A5B7B5C2269645C223A312C5C226465736372697074696F6E5C223A5C2253686F77204D61696E74656E616E63655C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A322C5C226465736372697074696F6E5C223A5C224164645C5C5C2F45646974204974656D5C222C5C2276616C75655C223A66616C73657D2C7B5C2269645C223A332C5C226465736372697074696F6E5C223A5C2244656C657465204974656D5C222C5C2276616C75655C223A66616C73657D5D7D5D22');

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `id` int(11) NOT NULL,
  `office` varchar(200) DEFAULT NULL,
  `shortname` varchar(50) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `is_initial_track` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`id`, `office`, `shortname`, `dept_id`, `is_initial_track`) VALUES
(1, 'Others', 'OTH', 24, 0),
(2, 'PA', 'PA', 2, 1),
(3, 'Office of the Provincial Governor', 'OPG', 1, 0),
(4, 'ICTD', 'ICTD', 1, 0);

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
(14, 'PLEASE CONFIRM'),
(15, 'FORWARDED');

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `id` int(255) NOT NULL,
  `document_id` int(255) DEFAULT NULL,
  `document_status` varchar(100) DEFAULT NULL,
  `document_status_user` int(11) DEFAULT NULL,
  `document_tracks_status` varchar(100) DEFAULT NULL,
  `track_option` int(11) DEFAULT NULL,
  `track_office` int(11) DEFAULT NULL,
  `track_date` datetime DEFAULT NULL,
  `route_office` int(11) DEFAULT NULL,
  `route_user` int(11) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `system_log` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `phone_number` varchar(200) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `system_accountability` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `mname`, `lname`, `position`, `uname`, `pw`, `employee_id`, `div_id`, `email_address`, `phone_number`, `group_id`, `system_accountability`) VALUES
(1, 'Sylvester', 'Bulilan', 'Flores', 'Administrative Aide VI', 'sly', 'legend', '82156', 4, 'sly@christian.com.ph', '09179245040', 1, NULL),
(2, 'Karl Aaron', 'Masancay', 'Castaneda', 'OJT', 'aaron', '54321', '', 4, 'aaron.casty02@yahoo.com', '9298902184', 1, NULL),
(3, 'Renwil', 'Gatchallan', 'Flores', 'OJT', 'renn', 'renn', '', 4, '', '909090909', 1, NULL),
(4, 'Alain', 'M.', 'Dayao II', 'OJT', 'alain', '123456789', '', 4, '', '9123456789', 1, NULL),
(5, 'Mc Glenn', 'Gundran', 'Tangalin', 'OJT', 'glenn', 'glenn', '', 4, 'mcglenn.tangalin@lorma.edu', '09301598842', 1, NULL),
(6, 'Jennifer Joan', NULL, 'Ortega-Manguiat', 'Provincial Administrator', 'pa', '123456', NULL, 2, NULL, NULL, 2, 1),
(7, 'Mary Ann', 'Yan', 'Orofino', 'Administrative Aide IV', 'ann', '123456', '81018', 2, NULL, NULL, 3, NULL),
(8, 'Ghenny Rose', NULL, 'Estipular', 'Administrative Aide VI', 'ghenny', '123456', '80005', 2, NULL, NULL, 3, NULL),
(9, 'Remeleth', NULL, 'Dumaguin', 'Administrative Officer', 'melette', '123456', NULL, 4, NULL, NULL, 4, NULL),
(10, 'Francisco Emmanuel', 'Ramos', 'Ortega', 'Provincial Governor', 'pacoy', '123456', NULL, 3, NULL, NULL, 5, NULL),
(11, 'Sharmeen', 'Natarte', 'Guray', 'ADMINISTRATIVE AIDE IV', 'sharmeen', '123456', NULL, 3, NULL, NULL, 4, NULL);

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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `communication` (`communication`),
  ADD KEY `doc_type` (`doc_type`),
  ADD KEY `origin` (`origin`);

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
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `destination` (`track_office`),
  ADD KEY `route_office` (`route_office`),
  ADD KEY `track_option` (`track_option`),
  ADD KEY `route_user` (`route_user`),
  ADD KEY `document_status_user` (`document_status_user`);

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
  ADD KEY `div_id` (`div_id`),
  ADD KEY `group_id` (`group_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `divisions`
--
ALTER TABLE `divisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
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

--
-- Constraints for table `offices`
--
ALTER TABLE `offices`
  ADD CONSTRAINT `offices_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `tracks`
--
ALTER TABLE `tracks`
  ADD CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
