-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2020 at 01:33 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `casetag`
--

-- --------------------------------------------------------

--
-- Table structure for table `dsa`
--

CREATE TABLE `dsa` (
  `dsa_id` int(100) NOT NULL,
  `dsa_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dsa`
--

INSERT INTO `dsa` (`dsa_id`, `dsa_value`) VALUES
(1, '9.0.0.883 (GM)'),
(2, '9.0.0.883'),
(3, '9.0.0.2404'),
(4, '9.0.0.3044'),
(5, '9.0.0.3500'),
(6, '9.0.0.5000'),
(7, '9.0.0.5001'),
(8, '9.0.0.5531'),
(9, '9.0.0.5625'),
(10, '9.5.2.2022'),
(11, '9.5.2.2023 (GM)'),
(12, '9.5.2.2023'),
(13, '9.5.2.2409'),
(14, '9.5.3.4017'),
(15, '9.5.3.4518'),
(16, '9.5.3.5500'),
(17, '9.5.3.7523'),
(18, '9.5.3.7568'),
(19, '9.5.3.7707'),
(20, '9.5.3.7747'),
(21, '9.5.3.7814'),
(22, '9.5.3.7845'),
(23, '9.6.1.3500 (GM)'),
(24, '9.6.1.3500'),
(25, '9.6.2.5029'),
(26, '9.6.2.5449'),
(27, '9.6.2.6400'),
(28, '9.6.2.7516'),
(29, '9.6.2.7050'),
(30, '9.6.2.7256'),
(31, '9.6.2.7516'),
(32, '9.6.2.7599'),
(33, '9.6.2.7690'),
(34, '9.6.2.7723'),
(35, '9.6.2.7888'),
(36, '9.6.2.7985'),
(37, '9.6.2.8065'),
(38, '9.6.2.8140'),
(39, '9.6.2.8198'),
(40, '9.6.2.8207'),
(41, '9.6.2.8248'),
(42, '9.6.2.8288'),
(43, '9.6.2.8352'),
(44, '9.6.2.8397'),
(45, '9.6.2.8436'),
(46, '9.6.2.8587'),
(47, '9.6.2.8648'),
(48, '9.6.2.8708'),
(49, '9.6.2.8797'),
(50, '9.6.2.8846'),
(51, '9.6.2.8904'),
(52, '10.0.0.2094 (GM)'),
(53, '10.0.0.2094'),
(54, '10.0.0.2240'),
(55, '10.0.0.2358'),
(56, '10.0.0.2413'),
(57, '10.0.0.2470'),
(58, '10.0.0.2548'),
(59, '10.0.0.2551'),
(60, '10.0.0.2613'),
(61, '10.0.0.2649'),
(62, '10.0.0.2687'),
(63, '10.0.0.2736'),
(64, '10.0.0.2775'),
(65, '10.0.0.2797'),
(66, '10.0.0.2856'),
(67, '10.0.0.2888'),
(68, '10.0.0.2981'),
(69, '10.0.0.3059'),
(70, '10.0.0.3107'),
(71, '10.0.0.3186'),
(72, '10.0.0.3309'),
(73, '10.0.0.3377'),
(74, '10.0.0.3437'),
(75, '11.0.0.223 (GM)'),
(76, '11.0.0.211'),
(77, '11.0.0.326'),
(78, '11.0.0.390'),
(79, '11.0.0.439'),
(80, '11.0.0.514'),
(81, '11.0.0.582'),
(82, '11.0.0.615'),
(83, '11.0.0.662'),
(84, '11.0.0.707'),
(85, '11.0.0.716'),
(86, '11.0.0.760'),
(87, '11.0.0.796'),
(88, '11.3.0.202 (GM)'),
(89, '11.3.0.202'),
(90, '11.3.0.235'),
(91, '11.3.0.292'),
(92, '11.3.0.376'),
(93, '12.0.0.296'),
(94, '12.0.0.364 (GM)'),
(95, '12.0.0.481'),
(96, '12.0.0.563'),
(97, '12.0.0.682'),
(98, '11.0.0.1023'),
(99, '12.0.0.725'),
(100, '12.0.0.767');

-- --------------------------------------------------------

--
-- Table structure for table `dsc`
--

CREATE TABLE `dsc` (
  `dsc_id` int(100) NOT NULL,
  `dsc_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dsc`
--

INSERT INTO `dsc` (`dsc_id`, `dsc_value`) VALUES
(1, 'DSM AWS AMI'),
(2, 'DSM Azure VMI'),
(3, 'DSR'),
(4, 'DSaaS DSR'),
(5, 'DSA'),
(6, 'DSaaS'),
(7, 'DSaaS DSA'),
(8, 'SmartCheck'),
(9, 'App Protect'),
(10, 'AWS WAF');

-- --------------------------------------------------------

--
-- Table structure for table `dsm`
--

CREATE TABLE `dsm` (
  `dsm_id` int(100) NOT NULL,
  `dsm_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dsm`
--

INSERT INTO `dsm` (`dsm_id`, `dsm_value`) VALUES
(1, '9.0.5500'),
(2, '9.0.6019'),
(3, '9.0.6601'),
(4, '9.0.6803'),
(5, '9.0.6818'),
(6, '9.5.2456 (GM)'),
(7, '9.5.2459'),
(8, '9.5.4112'),
(9, '9.5.5600'),
(10, '9.5.6008'),
(11, '9.5.6511'),
(12, '9.5.7008'),
(13, '9.5.7200'),
(14, '9.5.7222'),
(15, '9.5.7226'),
(16, '9.5.7228'),
(17, '9.5.7230'),
(18, '9.5.7232'),
(19, '9.5.7235'),
(20, '9.6.1589 (GM)'),
(21, '9.6.3177'),
(22, '9.6.3400'),
(23, '9.6.4000'),
(24, '9.6.4014'),
(25, '9.6.4064'),
(26, '9.6.4072'),
(27, '9.6.4085'),
(28, '9.6.4093'),
(29, '9.6.4111'),
(30, '9.6.4125'),
(31, '9.6.4133'),
(32, '9.6.4143'),
(33, '9.6.4145'),
(34, '9.6.4152'),
(35, '9.6.4159'),
(36, '9.6.4168'),
(37, '9.6.4174'),
(38, '9.6.4178'),
(39, '9.6.4179'),
(40, '9.6.4184'),
(41, '9.6.4191'),
(42, '9.6.4193'),
(43, '9.6.4199'),
(44, '9.6.4204'),
(45, '9.6.4208'),
(46, '10.0.3259 (GM)'),
(47, '10.0.3297'),
(48, '10.0.3305'),
(49, '10.0.3315'),
(50, '10.0.3325'),
(51, '10.0.3346'),
(52, '10.0.3359'),
(53, '10.0.3367'),
(54, '10.0.3370'),
(55, '10.0.3374'),
(56, '10.0.3376'),
(57, '10.0.3382'),
(58, '10.0.3392'),
(59, '10.0.3402'),
(60, '10.0.3410'),
(61, '10.0.3419'),
(62, '10.0.3428'),
(63, '10.0.3432'),
(64, '10.0.3437'),
(65, '10.0.3445'),
(66, '11.0.221 (GM)'),
(67, '11.0.240'),
(68, '11.0.249'),
(69, '11.0.270'),
(70, '11.0.292'),
(71, '11.0.298'),
(72, '11.0.308'),
(73, '11.0.319'),
(74, '11.0.328'),
(75, '11.0.336'),
(76, '11.0.340'),
(77, '11.0.346'),
(78, '11.0.349'),
(79, '11.1.227'),
(80, '12.0.296 (GM)'),
(81, '12.0.327'),
(82, '12.0.300'),
(83, '11.3.184'),
(84, '12.0.342'),
(85, '11.3.192'),
(86, '12.0.347'),
(87, '12.0.0.300 (GM)');

-- --------------------------------------------------------

--
-- Table structure for table `ic`
--

CREATE TABLE `ic` (
  `ic_id` int(100) NOT NULL,
  `ic_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ic`
--

INSERT INTO `ic` (`ic_id`, `ic_value`) VALUES
(1, 'Configuration'),
(2, 'OS_Crash'),
(3, 'Performance'),
(4, 'Operations'),
(5, 'Deployment'),
(6, 'Integration'),
(7, 'Inquiry'),
(8, 'Compatibility'),
(9, 'License'),
(10, 'Account Administration');

-- --------------------------------------------------------

--
-- Table structure for table `os`
--

CREATE TABLE `os` (
  `os_id` int(100) NOT NULL,
  `os_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `os`
--

INSERT INTO `os` (`os_id`, `os_value`) VALUES
(1, 'Windows Server 2019'),
(2, 'Windows Server 2016'),
(3, 'Windows'),
(4, 'Windows Server 2012'),
(5, 'Windows Server 2012 R2'),
(6, 'Windows Server 2008'),
(7, 'Windows Server 2008 R2'),
(8, 'Windows Server 2003'),
(9, 'Windows 10'),
(10, 'WIndows 8.1'),
(11, 'Windows 8'),
(12, 'Windows Vista'),
(13, 'Windows XP'),
(14, 'Red Hat Enterprise Linux'),
(15, 'Red Hat Enterprise Linux 5'),
(16, 'Red Hat Enterprise Linux 6'),
(17, 'Red Hat Enterprise Linux 7'),
(18, 'Red Hat Enterprise Linux 8'),
(19, 'CentOS'),
(20, 'CentOS 5'),
(21, 'CentOS 6'),
(22, 'CentOS 7'),
(23, 'Ubuntu'),
(24, 'Ubuntu 10.04'),
(25, 'Ubuntu 12.04'),
(26, 'Ubuntu 14.04'),
(27, 'Ubuntu 16'),
(28, 'Ubuntu 18'),
(29, 'Solaris'),
(30, 'Solaris 9'),
(31, 'Solaris 10_Update7'),
(32, 'Solaris 10_Update8'),
(33, 'Solaris 10_Update9'),
(34, 'Solaris 10_Update10'),
(35, 'Solaris 10_Update11'),
(36, 'Solaris 11_Update1'),
(37, 'Solaris 11_Update2'),
(38, 'AIX'),
(39, 'AIX 5.3'),
(40, 'AIX 6.1'),
(41, 'AIX 7.1'),
(42, 'SuSE'),
(43, 'SuSE 10'),
(44, 'SuSE 11'),
(45, 'SuSE 12'),
(46, 'Oracle Linux'),
(47, 'Oracle Linux5'),
(48, 'Oracle Linux6'),
(49, 'Oracle Linux7'),
(50, 'Amazon Linux'),
(51, 'Amazon Linux2'),
(52, 'Cloud Linux'),
(53, 'Cloud Linux 5'),
(54, 'Cloud Linux 6'),
(55, 'Cloud Linux 7'),
(56, 'Debian'),
(57, 'Debian 6'),
(58, 'Debian 7'),
(59, 'Debian 8'),
(60, 'Debian 9');

-- --------------------------------------------------------

--
-- Table structure for table `passwordct`
--

CREATE TABLE `passwordct` (
  `password_id` int(100) NOT NULL,
  `password` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `passwordct`
--

INSERT INTO `passwordct` (`password_id`, `password`) VALUES
(1, 'P@$$w0rd!');

-- --------------------------------------------------------

--
-- Table structure for table `prbm`
--

CREATE TABLE `prbm` (
  `prbm_id` int(100) NOT NULL,
  `prbm_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prbm`
--

INSERT INTO `prbm` (`prbm_id`, `prbm_value`) VALUES
(1, 'AMSP'),
(2, 'DS_AM'),
(3, 'FW'),
(4, 'IPS'),
(5, 'IM'),
(6, 'LI'),
(7, 'AC'),
(8, 'Network Engine'),
(9, 'SAP'),
(10, 'Agent Core'),
(11, 'Package'),
(12, 'DSM'),
(13, 'Database');

-- --------------------------------------------------------

--
-- Table structure for table `sc`
--

CREATE TABLE `sc` (
  `sc_id` int(100) NOT NULL,
  `sc_value` varchar(1000) NOT NULL,
  `sc_ic_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sc`
--

INSERT INTO `sc` (`sc_id`, `sc_value`, `sc_ic_value`) VALUES
(1, 'Anti-Malware', 'Configuration'),
(2, 'AMSP', 'OS_Crash'),
(3, 'Web Reputation', 'Configuration'),
(4, 'Firewall', 'Configuration'),
(5, 'Intrusion Prevention', 'Configuration'),
(6, 'Integrity Monitoring', 'Configuration'),
(7, 'Log Inspection', 'Configuration'),
(8, 'Application Control', 'Configuration'),
(9, 'Intrusion Prevention Rule', 'Configuration'),
(10, 'Integrity Monitoring Rule', 'Configuration'),
(11, 'Log Inspection Rule', 'Configuration'),
(12, 'User and Roles', 'Configuration'),
(13, 'Reports', 'Configuration'),
(18, 'TLS/SSL', 'Configuration'),
(20, 'Scan Exclusions', 'Configuration'),
(32, 'General Questions', 'Configuration'),
(33, 'DS_AM', 'OS_Crash'),
(34, 'Network Engine', 'OS_Crash'),
(35, 'AC', 'OS_Crash'),
(36, 'OS Patch', 'OS_Crash'),
(37, 'App Patch', 'OS_Crash'),
(38, 'AMSP', 'Performance'),
(39, 'DS_AM', 'Performance'),
(41, 'AC', 'Performance'),
(43, 'Network Engine', 'Performance'),
(44, 'FW&IPS Engine', 'Performance'),
(45, 'High CPU Usage', 'Performance'),
(46, 'High Memory Usage', 'Performance'),
(47, 'High Disk I/O', 'Performance'),
(48, 'High Network Usage', 'Performance'),
(59, 'Security Update Fail', 'Operations'),
(60, 'Software Update Fail', 'Operations'),
(61, 'Recommendation Scan Fail', 'Operations'),
(62, 'Activation Fail', 'Operations'),
(63, 'Alerts', 'Operations'),
(65, 'DSM Web Console', 'Operations'),
(67, 'DSaaS Relay (General)', 'Operations'),
(68, 'DSM AMI(General)', 'Operations'),
(69, 'DSM VMI(General)', 'Operations'),
(70, 'Anti-Malware', 'Operations'),
(71, 'Web Reputation', 'Operations'),
(72, 'Firewall', 'Operations'),
(73, 'Intrusion Prevention', 'Operations'),
(74, 'Integrity Monitoring', 'Operations'),
(75, 'Log Inspection', 'Operations'),
(76, 'Application Control', 'Operations'),
(78, 'Agent Offline', 'Operations'),
(81, 'Private Cloud/AirGap', 'Deployment'),
(82, 'DS AMI Deployment', 'Deployment'),
(83, 'DS VMI Deployment', 'Deployment'),
(84, 'DS AMI Upgrade', 'Deployment'),
(85, 'DS VMI Upgrade', 'Deployment'),
(89, 'DSA Installation', 'Deployment'),
(90, 'DSA Upgrade', 'Deployment'),
(94, 'Multi-Tenant', 'Deployment'),
(99, 'QuickStart - AWS', 'Deployment'),
(101, 'SAML', 'Integration'),
(102, 'Local SPS', 'Integration'),
(103, 'Load Balancer', 'Integration'),
(104, 'Proxy', 'Integration'),
(105, 'SIEM', 'Integration'),
(106, 'Splunk', 'Integration'),
(107, 'Rapid7/Qualys', 'Integration'),
(108, 'DDAN', 'Integration'),
(109, 'Control Manager/ApexCentral', 'Integration'),
(110, 'SMTP', 'Integration'),
(111, 'SAP', 'Integration'),
(112, 'Docker', 'Integration'),
(117, 'Kubernetes - OnPrem', 'Integration'),
(118, 'AKS/EKS', 'Integration'),
(119, 'Architecture and Sizing', 'Inquiry'),
(120, 'Functionality', 'Inquiry'),
(121, 'Trend Products', 'Compatibility'),
(122, 'Third Party Integration', 'Compatibility'),
(123, 'Standards / RFC Compatibility', 'Compatibility'),
(124, 'Online Activation Code Update', 'License'),
(125, 'Offline Activation Code Update', 'License'),
(129, 'Back-end Related DSaaS', 'Operations'),
(131, 'Billing', 'License'),
(133, 'Billing', 'Inquiry'),
(136, 'Best Practice', 'Inquiry'),
(139, 'Account Details Inquiry', 'Account Administration'),
(142, 'Change Information', 'Account Administration'),
(145, 'WAF Rules', 'Configuration'),
(152, 'DSA Activation', 'Deployment'),
(160, 'DSR Installation', 'Deployment'),
(162, 'Certificates', 'Deployment'),
(164, 'IM', 'Performance'),
(165, 'IPS', 'Performance'),
(166, 'LI', 'Performance'),
(167, 'Uninstallation', 'Deployment'),
(168, 'Migration', 'Deployment'),
(169, 'Active Directory', 'Integration'),
(172, 'Customer Licensing Portal', 'License'),
(173, 'Transfer', 'License'),
(174, 'Module Offline', 'Operations'),
(175, 'Network Communication', 'Operations'),
(176, 'DSM Job Failed', 'Operations'),
(177, 'DS User Account', 'Account Administration'),
(178, 'Kernel Support', 'Integration'),
(179, 'Cannot access console', 'Operations'),
(180, 'Email Confirmation Failed', 'Account Administration'),
(181, 'AWS Subscription', 'License'),
(182, 'Azure Subscription', 'License'),
(183, 'DS API', 'Integration'),
(184, 'DSSC API', 'Integration'),
(185, 'DSAP API', 'Integration'),
(186, 'AWS Cloud Connector', 'Integration'),
(187, 'Azure Cloud Connector', 'Integration'),
(188, 'GCP Cloud Connector', 'Integration'),
(189, 'DB - Postgre', 'Performance'),
(190, 'DB - Oracle', 'Performance'),
(191, 'DB - Microsoft SQL', 'Performance'),
(192, 'DB - RDS', 'Performance'),
(193, 'DB - Deadlock', 'Performance'),
(194, 'DB - Full', 'Performance'),
(195, 'Pending DSM Jobs', 'Performance');

-- --------------------------------------------------------

--
-- Table structure for table `seg`
--

CREATE TABLE `seg` (
  `seg_id` int(100) NOT NULL,
  `seg_value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `seg`
--

INSERT INTO `seg` (`seg_id`, `seg_value`) VALUES
(1, 'Sales'),
(2, 'Requested by SEG'),
(3, 'Product Bug'),
(4, 'Kernel Support Request');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dsa`
--
ALTER TABLE `dsa`
  ADD PRIMARY KEY (`dsa_id`);

--
-- Indexes for table `dsc`
--
ALTER TABLE `dsc`
  ADD PRIMARY KEY (`dsc_id`);

--
-- Indexes for table `dsm`
--
ALTER TABLE `dsm`
  ADD PRIMARY KEY (`dsm_id`);

--
-- Indexes for table `ic`
--
ALTER TABLE `ic`
  ADD PRIMARY KEY (`ic_id`);

--
-- Indexes for table `os`
--
ALTER TABLE `os`
  ADD PRIMARY KEY (`os_id`);

--
-- Indexes for table `passwordct`
--
ALTER TABLE `passwordct`
  ADD PRIMARY KEY (`password_id`);

--
-- Indexes for table `prbm`
--
ALTER TABLE `prbm`
  ADD PRIMARY KEY (`prbm_id`);

--
-- Indexes for table `sc`
--
ALTER TABLE `sc`
  ADD PRIMARY KEY (`sc_id`);

--
-- Indexes for table `seg`
--
ALTER TABLE `seg`
  ADD PRIMARY KEY (`seg_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dsa`
--
ALTER TABLE `dsa`
  MODIFY `dsa_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `dsc`
--
ALTER TABLE `dsc`
  MODIFY `dsc_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `dsm`
--
ALTER TABLE `dsm`
  MODIFY `dsm_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `ic`
--
ALTER TABLE `ic`
  MODIFY `ic_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `os`
--
ALTER TABLE `os`
  MODIFY `os_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `prbm`
--
ALTER TABLE `prbm`
  MODIFY `prbm_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `sc`
--
ALTER TABLE `sc`
  MODIFY `sc_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT for table `seg`
--
ALTER TABLE `seg`
  MODIFY `seg_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
