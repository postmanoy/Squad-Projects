-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2020 at 05:21 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quizdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `user_ID` int(100) NOT NULL,
  `username` varchar(1000) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`user_ID`, `username`, `password`) VALUES
(1, 'DSadmin', 'P@$$w0rd!');

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `a_id` int(100) NOT NULL,
  `ans` varchar(10000) NOT NULL,
  `ans_id` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`a_id`, `ans`, `ans_id`) VALUES
(1, 'ping 192.168.1.1', 1),
(2, 'ping -t 192.168.1.1', 1),
(3, 'ping -l 192.168.1.1', 1),
(4, 'ping -loop 192.168.1.1', 1),
(5, 'ARP', 2),
(6, 'IGMP', 2),
(7, 'TCP', 2),
(8, 'UDP', 2),
(9, 'telnet', 3),
(10, 'finger', 3),
(11, 'dnslookup', 3),
(12, 'nslookup', 3),
(13, 'The client will not be able to browse', 4),
(14, 'The client would send the webpage request to the router and it would use the router as a proxy', 4),
(15, 'It would have been possible for the client to browse if the routers IP address was provided in proxy configuration in the browser.', 4),
(16, 'The client ignores the DNS IP address setting on the TCP/IP adapter configuration as it accepts its IP address from the DHCP server and would be able to browse irrespective of the incorrect configuration.', 4),
(17, 'ARP', 5),
(18, 'IGMP', 5),
(19, 'TCP', 5),
(20, 'UDP', 5),
(21, 'aging', 6),
(22, 'TCP', 6),
(23, 'APIPA', 6),
(24, 'broadcast', 6),
(25, 'Local DNS Cache', 7),
(26, 'Local DNS Server', 7),
(27, 'Primary Name Server', 7),
(28, 'Hosts file', 7),
(29, 'HTTP, HTTPS, TCP', 8),
(30, 'HTTP, HTTPS, ARP', 8),
(31, 'HTTP, HTTPS, SOCKS', 8),
(32, 'None in the choices', 8),
(33, '32', 9),
(34, '30', 9),
(35, '64', 9),
(36, '14', 9),
(37, '10.0.0.0/8', 10),
(38, '172.16.0.0/16', 10),
(39, '192.168.1.0/24', 10),
(40, 'All of the choices', 10),
(41, 'cipher texts', 11),
(42, 'cipher suite', 11),
(43, 'cipher group', 11),
(44, 'cipher list', 11),
(45, 'tracert www.inquirer.net', 12),
(46, 'ping www.inquirer.net', 12),
(47, 'telnet www.inquirer.net', 12),
(48, 'nslookup www.inquirer.net', 12),
(49, 'DNS servers have not been assigned.', 13),
(50, 'WINS servers have not been assigned.', 13),
(51, 'Duplicate gateways have not been assigned.', 13),
(52, 'Duplicate IP addresses have been assigned.', 13),
(53, 'A DHCP client uses a ping to detect address conflicts.', 14),
(54, 'If an address conflict is detected, the address is removed from the pool and an administrator must resolve the conflict.', 14),
(55, 'If an address conflict is detected, the address is removed from the pool for an amount of time configurable by the administrator', 14),
(56, 'If an address conflict is detected, the address is removed from the pool and will not be reused until the server is rebooted', 14),
(57, 'debug!', 15),
(58, '!analyze -v', 15),
(59, 'Trace -v', 15),
(60, '!stack', 15),
(61, 'A', 16),
(62, 'CNAME', 16),
(63, 'MX', 16),
(64, 'PTR', 16),
(65, 'Secondary', 17),
(66, 'Active Directory Integrated', 17),
(67, 'Primary', 17),
(68, 'Any server', 17),
(69, 'DHCP', 18),
(70, 'Static IP Address', 18),
(71, 'Active Directory', 18),
(72, 'Windows  clients', 18),
(73, 'root directory', 19),
(74, 'current directory', 19),
(75, 'parent directory', 19),
(76, 'child directory', 19),
(77, '-a', 20),
(78, '-f', 20),
(79, '-s', 20),
(80, '-r', 20),
(81, 'chattr +i /etc/passwd', 21),
(82, 'chattr -i /etc/passwd', 21),
(83, 'chown root /etc/passwd', 21),
(84, 'chmod +w /etc/passwd', 21),
(85, 'ls -a', 22),
(86, 'ls -la', 22),
(87, 'ls -t', 22),
(88, 'ls -x', 22),
(89, 'free', 23),
(90, 'df', 23),
(91, 'du', 23),
(92, 'fdisk', 23),
(93, 'chmod o+x /usr/local/bin/myapp', 24),
(94, 'chgrp bin /usr/local/bin/myapp', 24),
(95, 'umask 0022 /usr/local/bin/myapp', 24),
(96, 'chown 755 /usr/local/bin/myapp', 24),
(97, '/etc/hosts', 25),
(98, '/etc/exports', 25),
(99, '/etc/resolv.conf', 25),
(100, '/etc/dns.conf', 25),
(101, 'it will create a symbolic link from mark to glen', 26),
(102, 'it will create a copy of the file glen in mark', 26),
(103, 'it will create a hard link from mark to glen', 26),
(104, 'it will create a symbolic link from glen to mark', 26),
(105, 'shutdown â€“r 6', 27),
(106, 'init 6', 27),
(107, 'reboot', 27),
(108, 'telinit 0', 27),
(109, 'Tracert', 28),
(110, 'Ping', 28),
(111, 'Traceroute', 28),
(112, 'Ifconfig', 28),
(113, 'Recode an unencrypted tunneling program to support SSH encryption', 29),
(114, 'Set up a tunnel using PPTP', 29),
(115, 'Set up a tunnel using L2TP/Ipsec', 29),
(116, 'Piggyback an existing tunnel program onto SSH', 29),
(117, 'Changes are automatically applied after a short period', 30),
(118, 'Changes will be effective after 5 minutes', 30),
(119, 'Changes will be effective after rebooting the instances in that security group ', 30),
(120, 'Security group rules cannot be changed. You have to create a new security group and assign it to instances', 30),
(121, 'Instance should have either public IP or elastic IP', 31),
(122, 'NACL should be configured for outbound rule allowing for any protocol and ports', 31),
(123, 'A new security group should be created and allow outbound for any. Then instance should be attached to this security group', 31),
(124, 'Instance should be terminated and relaunched again', 31),
(125, 'TCP', 32),
(126, 'HTTP', 32),
(127, 'SSH', 32),
(128, 'HTTPS', 32),
(129, 'Lambda', 33),
(130, 'Cloud Formation', 33),
(131, 'Simple Storage Service', 33),
(132, 'Amazon Redshift', 33),
(133, 'Enable CloudWatch on the ELB', 34),
(134, 'Enable Cloud Trail on the ELB', 34),
(135, 'Enable Detailed Monitoring on the ELB when first creating the instance', 34),
(136, 'Enable Cloud Audit on the ELB when first creating the instance', 34),
(137, 'An EC2 with a secondary EBS volume provisioned', 35),
(138, 'S3', 35),
(139, 'Glacier', 35),
(140, 'Route53', 35),
(141, 'Using a private VPC', 36),
(142, 'By creating a cluster placement group', 36),
(143, 'By deploying in a multiple availability zones', 36),
(144, 'By using CloudFront to cache static assets so as to increase performance', 36),
(145, 'You are able to attach multiple EBS volumes to an EC2 Instance', 37),
(146, 'You are able to attach mutiple EC2 instance to an EBS volume', 37),
(147, 'It is possible to configure an Autoscaling Group to repair degraded EBS volumes, without the need to terminate the EC2 Instances', 37),
(148, 'It is possible to use Autoscaling with EBS, rather than EC2', 37),
(149, 'Create a number of read replicas and update the connection string on your EC2 instances so that traffic is evenly shared amongst these new RDS instances.', 38),
(150, 'Create a secondary Multi-AZ database and run the queries off the secondary Multi-AZ database', 38),
(151, 'Export the database to DynamoDB which has push button scaleability', 38),
(152, 'You have reached the limits of public cloud. You should get a dedicated database server and host this locally within your datacenter', 38),
(153, 'A /28 private subnet', 39),
(154, 'A /28 public subnet', 39),
(155, 'A /16 private subnet', 39),
(156, 'A /16/ public subnet', 39),
(157, 'The data from both snapshots 3 and 4 necessary for continuance are transferred to snapshot 5', 40),
(158, 'It is no longer useable and cannot be restored', 40),
(159, 'All later snapshots, including 5 are automatically deleted as well', 40),
(160, 'The data from snapshot 4 necessary for continuance was transferred to snapshot 5  , however snapshot 3\'s contents were transferred to snapshot 2.', 40),
(161, 'Work with your ISP to diagnose the problem', 41),
(162, 'Open a support ticket to ask for network capture and flow data to diagnose the probm, then roll back your application', 41),
(163, 'Rollback to an earlier known good release initially, then use Stackdriver Trace and logging to diagnose the problem in a staging environment', 41),
(164, 'Rollback to an earlier known good release, then push the release again at a quieter period to investigate. Then use Stackdriver Trace and logging to diagnose the problem', 41),
(165, 'root, administrator', 42),
(166, 'root, vpxuser', 42),
(167, 'root, vpxa', 42),
(168, 'root, hostd', 42),
(169, 'Service Designer', 43),
(170, 'VCNS', 43),
(171, 'Service Composer', 43),
(172, 'DLR', 43),
(173, 'No - the changes will not impact the ESXI host service', 44),
(174, 'Yes - to uninstall the VIBS', 44),
(175, 'It does not matter', 44),
(176, 'You cannot remove the installed VIBs', 44),
(177, 'vmksummary.log', 45),
(178, 'hostd.log', 45),
(179, 'vmkernel.log', 45),
(180, 'vmkwarning.log', 45),
(181, 'Tap Mode', 46),
(182, 'Promiscuous Mode', 46),
(183, 'Forged Transmits', 46),
(184, 'Traffic Shaping', 46),
(185, 'Thick', 47),
(186, 'Thin', 47),
(187, 'Full', 47),
(188, 'Partial', 47),
(189, 'Use \"gcloud container clusters resize\" with the desired number of nodes', 48),
(190, 'Use \"kubectl container clusters resize\" with the desired number of nodes', 48),
(191, 'Edit the managed instance group of the cluster and increase the number of VMs by one.', 48),
(192, 'Edit the managed instance group of the cluster and enable autoscaling', 48),
(193, 'OutOfDisk', 49),
(194, 'DiskPressure', 49),
(195, 'MemoryPressure', 49),
(196, 'All of the Choices', 49),
(197, 'ReplicationController', 50),
(198, 'ReplicaSet', 50),
(199, 'DaemonSet', 50),
(200, 'Jobs', 50),
(201, 'ReplicationController', 51),
(202, 'ReplicaSet', 51),
(203, 'Deployment', 51),
(204, 'Jobs', 51),
(205, 'ReplicationController', 52),
(206, 'ReplicaSet', 52),
(207, 'Deployment', 52),
(208, 'Jobs', 52),
(209, 'Kubelet', 53),
(210, 'Kubectl', 53),
(211, 'Kube-Proxy', 53),
(212, 'All of the Choices', 53),
(213, 'Activates default VM machine', 54),
(214, 'Accesses a running container', 54),
(215, 'Builds an image', 54),
(216, 'Commits changes done in a Docker Image', 54),
(217, 'Activates default VM machine', 55),
(218, 'Accesses a running container', 55),
(219, 'Builds an image', 55),
(220, 'Commits changes done in a Docker Image', 55),
(221, 'Activates default VM machine', 56),
(222, 'Accesses a running container', 56),
(223, 'Builds an image', 56),
(224, 'Commits changes done in a Docker Image', 56),
(225, 'GET', 57),
(226, 'UPDATE', 57),
(227, 'SELECT', 57),
(228, 'PULL', 57),
(229, 'DDoS', 58),
(230, 'M-I-T-M', 58),
(231, 'Smurf', 58),
(232, 'FTP Bounce', 58),
(233, 'M-I-T-M', 59),
(234, 'Honey pot', 59),
(235, 'Smurf', 59),
(236, 'Zombie', 59),
(237, 'Protocol analyzers can show the contents of packets and frames', 60),
(238, 'Protocol analyzers can capture packets', 60),
(239, 'Protocol analyzers can generate packets and frames', 60),
(240, 'Protocol analyzers can filter packets and frames', 60),
(241, 'Event logs', 61),
(242, 'Baselines', 61),
(243, 'Syslog', 61),
(244, 'Change Management', 61),
(245, 'HSRP', 62),
(246, 'DNS Server', 62),
(247, 'Server Side Load Balancer', 62),
(248, 'Round Robin Server', 62),
(249, 'Define Trust Relationship in which it allows access between different domains or forest ', 63),
(250, 'Define Trust relationship and domains.', 63),
(251, 'Define Trust Relationship, Domains, and site example how it breaks', 63),
(252, 'Define trust relationship, domains, site example how it breaks and provide solution a solution - re-join to the domain', 63),
(253, 'traditional way: backup the database(ntds.dit) / snapshot vm', 64),
(254, 'backup using tools,   like veenam', 64),
(255, 'backup strategy + considerations like pros and cons of how to go about it. ', 64),
(256, 'Add a domain controller in an existing domain, restoring a dc backup in a multi-DC environment is potentially disastrous, pros and cons', 64),
(257, '1 state', 65),
(258, '2 state', 65),
(259, '\"all states â€¢ Running â€¢ Paused â€¢ Restarting â€¢ Exited or difference of image and container\"', 65),
(260, '\"Docker container is the the runtime instance of docker images. + states Docker images does not change its state as it is just a set of files.\"', 65),
(261, 'use ping and telnet, only one possible cause. ', 66),
(262, 'provide why they need to do testing.', 66),
(263, 'sound troubleshooting and isolation', 66),
(264, 'possible solution: DHCP conflict due to the introduction of new router', 66),
(265, 'Define each switch', 67),
(266, 'None', 67),
(267, 'None', 67),
(268, '\"site examples  basic license Small shops with a single port group they make a lot of sense.  If you need to host 10 virtual machine on the same subnet then standard switches will work fine. standard vswitch are easy to deploy\"', 67),
(269, '--isolation', 68),
(270, '--expose', 68),
(271, '--runtime', 68),
(272, '--privileged', 68),
(273, 'netcfg.exe', 69),
(274, 'netsh.exe', 69),
(275, 'msconfig.exe', 69),
(276, 'ipconfig.exe', 69),
(277, 'Authorization Manager', 70),
(278, 'Local Security Policy', 70),
(279, 'Certificate Templates', 70),
(280, 'Computer Management', 70),
(281, 'None, they are the same.', 71),
(282, 'TRUNCATE deletes all rows in a table while DELETE deletes specific rows in a table.', 71),
(283, 'DELETE deletes all rows in a table while TRUNCATE deletes specific rows in a table.', 71),
(284, 'TRUNCATE allows you to rollback the operation while DELETE does not.', 71),
(285, 'Recursive', 72),
(286, 'Iterative', 72),
(287, 'Substitution', 72),
(288, 'Referral', 72),
(289, 'Set-ExecutionPolicy Unrestricted', 73),
(290, 'Set-ExecutionPolicy Authorized', 73),
(291, 'Set-AllowPolicy -t', 73),
(292, 'Set-AllowPolicy -y', 73),
(293, 'Device Manager', 74),
(294, 'Group Policy', 74),
(295, 'Third Party Application', 74),
(296, 'Computer Management', 74),
(297, 'db_securityadmin', 75),
(298, 'db_owner', 75),
(299, 'db_accessadmin', 75),
(300, 'db_auditor', 75),
(301, 'Have a full backup then do Incremental backups', 76),
(302, 'Have a full backup then do Differential backups', 76),
(303, 'Have a full backup', 76),
(304, 'Create snapshots of database every 12 hours', 76),
(305, 'Store it on a Syslog server', 77),
(306, 'Integrate a SAP service on the Database', 77),
(307, 'Use Full Recovery Model for the Database', 77),
(308, 'Create a table for transaction logs on the Database', 77);

-- --------------------------------------------------------

--
-- Table structure for table `passwordtest`
--

CREATE TABLE `passwordtest` (
  `p_id` int(100) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `q_id` int(100) NOT NULL,
  `question` varchar(10000) NOT NULL,
  `ans` int(100) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `fin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`q_id`, `question`, `ans`, `cat_id`, `fin`) VALUES
(1, 'Which command would you use to ping a system in a loop from a Windows PC?', 2, 1, 0),
(2, 'Member of the IP protocol suite packets that are just sent to the recipient. The sender does not wait to make sure the recipient received the packetâ€”it just continues sending the next packets. \r\n', 8, 1, 0),
(3, 'Which command line tool would you use to query DNS?', 12, 1, 0),
(4, 'A network administrator incorrectly configures manually the DNS server IP address on the clients TCP/IP adapter setting. The default gateway of the network which is the internet router has the correct DNS entry in its configuration. The clients IP address, subnet mask and the default gateway information is provided by the DHCP server on the router. Would the client be able to browse?', 13, 1, 0),
(5, 'Member of the IP protocol suite that has to establish the connection on both ends before any data begins to flow. ', 19, 1, 0),
(6, 'Which IP address range is 169.254.0.1/16 to 169.254.255.254/16?\r\n', 23, 1, 0),
(7, 'What is the first item to be queried on name resolution?\r\n', 28, 1, 0),
(8, 'What are the commonly used proxy protocols?\r\n', 31, 1, 0),
(9, 'How many hosts can a /27 subnet accommodate?\r\n', 34, 1, 0),
(10, 'Which of the following network is/are reserved for private networks?\r\n', 40, 1, 0),
(11, 'A set of algorithms that help secure a network connection that uses Transport Layer Security (TLS) or its now-deprecated predecessor Secure Socket Layer (SSL).\r\n', 42, 1, 0),
(12, 'Every day, you check the news at www.inquirer.net. Today, it takes 3 minutes longer than usual to view the page. What is one thing you can do to see where the bottleneck is?\r\n', 45, 1, 0),
(13, 'You have introduced a fully configured workstation into your network. Your network is IP based and uses static IP addressing. Everytime the new workstation connects to the network, another existing computer generates an error message and stops connecting. What could the problem be?\r\n', 52, 1, 0),
(14, 'Which statement is correct regarding the operation of DHCP?\r\n', 54, 2, 0),
(15, 'What Command is used to show the faulty module or the crash root cause and show detailed information?\r\n', 58, 2, 0),
(16, 'Which of the following DC resource record types would you look for if trying to troubleshoot workstations not being able to log on to a domain?\r\n', 61, 2, 0),
(17, 'In a standard primary zone, what name server(s) can an administrator update the zone database on? Choose the best answer.\r\n', 67, 2, 0),
(18, 'Which of the following elements is required to successfully install and configure DNS? Choose the best answer.\r\n', 71, 2, 0),
(19, 'What does \" ./ \" mean in a Linux environment? \r\n', 74, 3, 0),
(20, 'Which option of rm command is used to remove a directory including all its subdirectories? \r\n', 80, 3, 0),
(21, 'The previous Linux Administrator implemented hardening measures on the server to ensure the configuration files will not be modified. As the new admin, you are then tasked to update the password for user \"user01\" so you login as root and key in the command \"passwd user01\", but it returns with \"passwd: Authentication token manipulation error\". What command below would be applicable to resolve your issue:  \r\n', 82, 3, 0),
(22, 'Which linux ls command will list files and sort them by date?\r\n', 87, 3, 0),
(23, 'Which Linux command can be used to determine the available space on local hard-disk partitions?\r\n', 90, 3, 0),
(24, 'Suppose you have created a new application \'myapp\', and copied it to the directory \'/usr/local/bin\'. You would like all the users of the system to be able to run your application. Which of the following command lines would allow the appropriate access?<br />\r\n', 93, 3, 0),
(25, 'Suppose that you have configured one Linux system on an internal LAN to run a DNS server. Which of the following files need to be updated on each DNS client on the LAN to get them to utilize the DNS service?<br />\r\n', 99, 3, 0),
(26, 'What does the command â€œIn glen markâ€ typically do?<br />\r\n', 103, 3, 0),
(27, 'Which of the following commands does not reboot the system?<br />\r\n', 108, 3, 0),
(28, 'What utility would you use on a UNIX system to help determine where an internet connection is being slowed down?<br />\r\n', 111, 3, 0),
(29, 'Which would be the best solution to make an encrypted tunnel using SSH?<br />\r\n', 116, 3, 0),
(30, 'If any change is made to an AWS security group rule, when are these changes effective?<br />\r\n', 117, 4, 0),
(31, 'A new EC2 instance is launched in public VPC subnet. There is an internet gateway and a route entry as 0.0.0.0/0 but the instance cannot reach internet. Other instances in this subnet have no issue. How can this problem be solved?<br />\r\n', 121, 4, 0),
(32, 'Which of the following protocols is not supported with an Elastic Load Balancer<br />\r\n', 127, 4, 0),
(33, 'Your Manager is looking for an AWS service where you can launch an entire datacenter from a piece of code. Which AWS service will you tell your manager to look into?<br />\r\n', 130, 4, 0),
(34, 'You work in the security industry for a large consultancy. A new customer of yours runs a production environment in AWS and they require a log of all API calls made to their Elastic Load Balancer. How can you achieve this?<br />\r\n', 134, 4, 0),
(35, 'You work for a large insurance company that has issued 10,000 insurance policies. These policies are stored as PDFs. You need these policies to be highly available and company policy says that the data must be able to survive the simultaneous loss of two facilities. What storage solution should you use?<br />\r\n', 138, 4, 0),
(36, 'An extremely high performance compute application that requires low-latency network performance and a minimum speed of 10 Gbps is to be deployed in AWS? How should you deploy these instances? <br />\r\n', 142, 4, 0),
(37, 'Which of the following statements is TRUE.<br />\r\n', 145, 4, 0),
(38, 'You have a very heavily-trafficked Wordpress blog that has approximately 95% read traffic and 5% write traffic. You notice that the blog is getting slower and slower. You discover that the bottleneck is in your RDS instance. Which of the following answers can improve your Wordpress blog\'s performance?<br />\r\n', 149, 4, 0),
(39, 'You need to configure a new subnet in your VPC for a database cluster you are building. The subnet will never need more than six IP addresses. Which of the following is the best choice for this subnet?<br />\r\n', 153, 4, 0),
(40, 'Over time, you\'ve created 5 snapshots of a single instance in GCP. To save space, you delete snapshots number 3 and 4. What has happened to the fifth snapshot? <br />\r\n', 157, 4, 0),
(41, 'Your customer is receiving reports that their recently updated Google App Engine application is taking approximately 30 seconds to load for some of their users. This behavior was not reported before the update. What strategy should you take? <br />\r\n', 163, 4, 0),
(42, 'Which two users are assigned the Administrator role at the ESX Server level by default?<br />\r\n', 166, 5, 0),
(43, 'In NSX, which of the following functions allow third-party extensibility?<br />\r\n', 171, 5, 0),
(44, '\"You are working with a NSX enabled domain of ESXi hosts in a single cluster. <br />\r\nYou have been asked to remove the installed VIBs and reconfigure the platform. <br />\r\nWill each ESXi host require a reboot?\"<br />\r\n', 174, 5, 0),
(45, 'Which of the following are ESXi Host management logs?<br />\r\n', 178, 5, 0),
(46, 'It is a security setting for policy exceptions when set to â€œAccept â€œ, will allow all the communications to all virtual machines. <br />\r\n', 182, 5, 0),
(47, 'What kind of provisioning pre-allocates based on the complete amount of virtual disk storage capacity?<br />\r\n', 185, 5, 0),
(48, 'You have a Kubernetes cluster in your google cloud with 1 node-pool. The cluster receives a lot of traffic and needs to grow. You decide to add a node. What should you do? <br />\r\n', 189, 6, 0),
(49, 'Which of the following can be one of the status of a running Kubernetes node?<br />\r\n', 196, 6, 0),
(50, 'Which of the following controller can be used to create/manage Pods which need to run one per machine<br />\r\n', 199, 6, 0),
(51, 'Which of the following controller can be used to create/manage Pods with restartPolicy as OnFailure or Never<br />\r\n', 204, 6, 0),
(52, 'Which of the following controller can be used to create/manage Pods with restartPolicy as Always<br />\r\n', 205, 6, 0),
(53, 'Which of the following is responsible for implementing a form of Virtual IP for Services?<br />\r\n', 211, 6, 0),
(54, 'The docker command: eval $(docker-machine env default)<br />\r\n', 213, 6, 0),
(55, 'The docker command: docker exec -it <container_id> bash<br />\r\n', 218, 6, 0),
(56, 'The docker command: docker build -t my_user/repo_name:1.0<br />\r\n', 223, 6, 0),
(57, 'You need to list all records in your database that is showing  CompletedTime is Null. What SQL statement will you use?<br />\r\n', 227, 7, 0),
(58, 'Continuously bombarding a remote computer with broadcast pings that contain a bogus return address is an example of what specific type of attack?<br />\r\n', 231, 8, 0),
(59, 'Clark is troubleshooting a user\'s PC. They are using their browser to visit Web sites such as PayPal, eBay, and Newegg. They begin seeing SSL certificate mismatch warnings. Which of the following attacks could be happening?<br />\r\n', 233, 8, 0),
(60, 'Which choice is not true about protocol analyzers such as WireShark?<br />\r\n', 239, 8, 0),
(61, 'Network administrator Marie manages one Linux and two Windows servers. She wants to be able to review all of the server logs centrally. Which of the following services could Lisa use in this scenario?<br />\r\n', 243, 8, 0),
(62, 'When operating multiple, duplicate servers such as web servers, which method is best to to take advantage of the full power of all of the servers?<br />\r\n', 247, 8, 0),
(63, 'In a Windows based operating systems, what is the purpose of trust relationships and how would it break? Explain how you would remediate the issue.<br />\r\n', 0, 9, 0),
(64, 'What are the practical ways to make sure you have backup for your Domain Controller? Please describe how to do it.<br />\r\n', 0, 9, 0),
(65, 'What are the various states that a Docker container can be in at any given point in time? And how do Docker images differ?<br />\r\n', 0, 9, 0),
(66, 'Your network administrator has just added a small router to connect to the Internet, but now you can\'t connect to your network server. Your system is configured to obtain an IP address automatically. You ran the ipconfig command to find your default gateway address, which is 192.168.4.152. You successfully pinged your default gateway. You still cannot connect to your server. List down the isolation steps and describe how you will troubleshoot this issue.<br />\r\n', 0, 9, 0),
(67, 'In VMware, what are the advantages and disadvantages of using a vSphere Distributed Switch over a vSphere Standard Switch <br />\r\n', 0, 9, 0),
(68, 'You have a container host named Server1 that runs Windows Server 2016. You need to start a Hyper-V container on Server1. Which parameter should you use with the docker run command?<br />\r\n', 269, 2, 0),
(69, 'Server1 is configured to obtain an IPv4 address by using DHCP.<br />\r\n<br />\r\nYou need to configure the IPv4 settings of the network connection on Server1 as follows:<br />\r\nIP address: 10.1.1.1,<br />\r\nSubnet Mask: 255.255.240.0,<br />\r\nDefault Gateway: 10.1.1.254', 274, 2, 0),
(70, 'The domain postmanoy.com contains two servers named Server1 and Server2 that run Windows Server 2012 R2. You create a security template named Template1 by using the Security Templates snap-in.<br />\r\n<br />\r\nYou need to apply Template1 to Server2.<br />\r\nWhich tool should you use?<br />\r\n<br />\r\n', 278, 2, 0),
(71, 'What is the difference between TRUNCATE and DELETE queries?', 282, 7, 0),
(72, 'A DNS Client queries a DNS Server for a domain name and the information that the server returned is a referral to an another authorative DNS server. The DNS Client can then query the DNS server for which it obtained a referral. The above example is what kind of DNS query?', 286, 2, 0),
(73, 'You are the Windows Administrator for Postmanoy Corp. and you created a Powershell Script to automate some tasks. When you run the script an error appears that has a category info of PSSecurityException and the error ID is Unauthorized Access, what command will you run to bypass this error?', 289, 2, 0),
(74, 'You are an IT administrator for a small company. Due to internal requirements, you need to restrict the access of removable devices in the company, which of the following is the most practical way to achieve this?', 294, 2, 0),
(75, 'You need to configure a user to only have the ability to alter and create any role in the Database, what role will you assign that user?', 297, 7, 0),
(76, 'You are the Database Administrator for Sydney & Friends Incorporated. The company requires you to have backups of the database and the only requirement that they have is that downtime is unacceptable, that means that the restore time of the backups should be short and the space taken by the backups is not an issue, how would you achieve this?', 302, 7, 0),
(77, 'The company you are working for specifies that you need to retain the transaction log of the Database until a backup is made. What would be the most practical way to achieve this requirement?', 307, 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `usersession`
--

CREATE TABLE `usersession` (
  `u_id` int(100) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `u_q_id` int(100) NOT NULL,
  `u_a_id` int(100) NOT NULL,
  `net_sc` int(11) NOT NULL,
  `win_sc` int(11) NOT NULL,
  `lin_sc` int(11) NOT NULL,
  `clo_sc` int(11) NOT NULL,
  `vir_sc` int(11) NOT NULL,
  `dev_sc` int(11) NOT NULL,
  `db_sc` int(11) NOT NULL,
  `ot_sc` int(11) NOT NULL,
  `ess_sc` int(100) NOT NULL,
  `date` varchar(100) NOT NULL,
  `essay_sc1` varchar(2000) NOT NULL,
  `essay_sc2` varchar(2000) NOT NULL,
  `essay_sc3` varchar(2000) NOT NULL,
  `essay_sc4` varchar(2000) NOT NULL,
  `essay_sc5` varchar(2000) NOT NULL,
  `q_essay_id1` int(100) NOT NULL,
  `q_essay_id2` int(100) NOT NULL,
  `q_essay_id3` int(100) NOT NULL,
  `q_essay_id4` int(100) NOT NULL,
  `q_essay_id5` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usersession`
--

INSERT INTO `usersession` (`u_id`, `name`, `u_q_id`, `u_a_id`, `net_sc`, `win_sc`, `lin_sc`, `clo_sc`, `vir_sc`, `dev_sc`, `db_sc`, `ot_sc`, `ess_sc`, `date`, `essay_sc1`, `essay_sc2`, `essay_sc3`, `essay_sc4`, `essay_sc5`, `q_essay_id1`, `q_essay_id2`, `q_essay_id3`, `q_essay_id4`, `q_essay_id5`) VALUES
(1, 'Aaron Joshua Lee', 60, 24, 6, 2, 6, 5, 2, 0, 1, 2, 1, '08/12/2019 05:18:01 pm', '', '', '', 'Check the IP address of the server - make sure you are on the same vlan<br />\r\nTry to ping the server\'s IP address<br />\r\nUse another workstation to check id the server is turned on - see if that other workstation can connect to the server<br />\r\nTry to turn off windows firewall on the workstation', '', 63, 64, 65, 66, 67),
(2, 'Andre Manatag', 60, 18, 5, 3, 5, 1, 0, 1, 2, 1, 2, '08/13/2019 04:58:05 pm', '', '', '', 'ifconf -a<br />\r\nmore /etc/resolve.conf<br />\r\n<br />\r\n', 'Advantage<br />\r\nAutomatically distribute network load<br />\r\n<br />\r\nDisadvantage<br />\r\n<br />\r\n', 63, 64, 65, 66, 67),
(3, 'Felix Yang', 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '08/14/2019 10:27:23 am', '', '', '', '', '', 63, 64, 65, 66, 67),
(4, 'clark-test', 60, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, '03/09/2020 02:26:51 pm', '', '', '', '', '', 63, 64, 65, 66, 67);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`user_ID`);

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`a_id`);

--
-- Indexes for table `passwordtest`
--
ALTER TABLE `passwordtest`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`q_id`);

--
-- Indexes for table `usersession`
--
ALTER TABLE `usersession`
  ADD PRIMARY KEY (`u_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `user_ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `a_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=309;

--
-- AUTO_INCREMENT for table `passwordtest`
--
ALTER TABLE `passwordtest`
  MODIFY `p_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `q_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `usersession`
--
ALTER TABLE `usersession`
  MODIFY `u_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
