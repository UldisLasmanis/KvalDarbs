-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 13, 2014 at 11:46 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `komandantstunda`
--
CREATE DATABASE IF NOT EXISTS `komandantstunda` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `komandantstunda`;

-- --------------------------------------------------------

--
-- Table structure for table `administratori`
--

CREATE TABLE IF NOT EXISTS `administratori` (
  `ID` int(11) NOT NULL COMMENT 'Lietotāja identifikators',
  `lietotajvards` varchar(45) NOT NULL COMMENT 'Lietotājvārds',
  `parole` varchar(100) NOT NULL COMMENT 'Parole šifrētā veidā',
  `vards` varchar(45) NOT NULL COMMENT 'Cilvēka vārds',
  `uzvards` varchar(45) NOT NULL COMMENT 'Cilvēka uzvārds',
  `tips` tinyint(1) NOT NULL COMMENT 'Administratora veids',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācija par administratoriem';

--
-- Dumping data for table `administratori`
--

INSERT INTO `administratori` (`ID`, `lietotajvards`, `parole`, `vards`, `uzvards`, `tips`) VALUES
(1, 'SuperAdmin', 'parole', 'Uldis', 'Lasmanis', 1),
(2, 'Admin', 'parole', 'Jānis', 'Valdnieks', 0),
(3, 'Admin2', 'parole', 'Valdis', 'Visvaldis', 0);

-- --------------------------------------------------------

--
-- Table structure for table `istabas`
--

CREATE TABLE IF NOT EXISTS `istabas` (
  `ID` int(11) NOT NULL COMMENT 'Istabiņas identifikators',
  `ires_cena` float DEFAULT NULL COMMENT 'Istabiņas īres maksa',
  `Vietas` tinyint(4) NOT NULL COMMENT 'Guļvietu skaits istabiņā',
  `viesnica_fk` int(11) NOT NULL COMMENT 'Dienesta viesnīcas identifikators',
  `istabas_numurs` int(11) NOT NULL COMMENT 'Istabiņas numurs',
  `radit` tinyint(1) NOT NULL COMMENT 'Statuss, vai istabiņas informācija ir    pilnīga un istabiņu drīkst rādīt',
  `apraksts` varchar(1000) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Istabiņas apraksts',
  `ir_izirejama` tinyint(1) NOT NULL COMMENT 'Norāde, vai tā ir palīgtelpa (piem., virtuve), kuru izīrēt nevar',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `viesnica` (`viesnica_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Istabu informācija';

--
-- Dumping data for table `istabas`
--

INSERT INTO `istabas` (`ID`, `ires_cena`, `Vietas`, `viesnica_fk`, `istabas_numurs`, `radit`, `apraksts`, `ir_izirejama`) VALUES
(1, 45.5, 3, 1, 101, 0, 'Istabas apraksts', 0),
(2, 45.5, 3, 1, 102, 1, 'Istabas apraksts', 1);

-- --------------------------------------------------------

--
-- Table structure for table `istabu_atteli`
--

CREATE TABLE IF NOT EXISTS `istabu_atteli` (
  `ID` int(11) NOT NULL COMMENT 'Attēla identifikators',
  `istabas_numurs_id` int(11) NOT NULL COMMENT 'Istabiņas identifikators',
  `attels` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'Attēla nosaukums',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `istabas_numurs` (`istabas_numurs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `istabu_atteli`
--

INSERT INTO `istabu_atteli` (`ID`, `istabas_numurs_id`, `attels`) VALUES
(1, 1, '101.istabas attēls'),
(2, 2, '102.istabas attēls');

-- --------------------------------------------------------

--
-- Table structure for table `istabu_pieprasijumi`
--

CREATE TABLE IF NOT EXISTS `istabu_pieprasijumi` (
  `ID` int(11) NOT NULL COMMENT 'Pieprasījuma identifikators',
  `istabas_id_fk` int(11) NOT NULL COMMENT 'Pieprasītās istabiņas identifikators',
  `statuss` varchar(45) NOT NULL COMMENT 'Pieprasījuma statuss',
  `administrators_fk` int(11) NOT NULL COMMENT 'Pārvaldnieka identifikators',
  `students_fk` int(11) NOT NULL COMMENT 'Studenta identifikators',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `istabas_id` (`istabas_id_fk`),
  KEY `administrators` (`administrators_fk`),
  KEY `students` (`students_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācija par istabu pieprasījumiem';

--
-- Dumping data for table `istabu_pieprasijumi`
--

INSERT INTO `istabu_pieprasijumi` (`ID`, `istabas_id_fk`, `statuss`, `administrators_fk`, `students_fk`) VALUES
(1, 1, 'Atteikts', 1, 3),
(2, 2, 'Apstiprināts', 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `jaunumi`
--

CREATE TABLE IF NOT EXISTS `jaunumi` (
  `ID` int(11) NOT NULL COMMENT 'Raksta identifikators',
  `virsraksts` varchar(100) NOT NULL COMMENT 'Raksta nosaukums',
  `saturs` varchar(2000) NOT NULL COMMENT 'Raksta saturs',
  `kategorija_fk` int(11) NOT NULL COMMENT 'Viesnīcas identifikators',
  `autors_fk` int(11) NOT NULL COMMENT 'Administratora identifikators',
  `pievienosanas_datums` datetime NOT NULL COMMENT 'Laiks, kad raksts izveidots',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `kategorija` (`kategorija_fk`),
  KEY `autors` (`autors_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācija par jaunumiem';

--
-- Dumping data for table `jaunumi`
--

INSERT INTO `jaunumi` (`ID`, `virsraksts`, `saturs`, `kategorija_fk`, `autors_fk`, `pievienosanas_datums`) VALUES
(1, 'Remonts', 'Kojās būs remonts no 18.maija līdz 28.maijam', 1, 2, '2014-05-12 08:00:00'),
(2, 'Bojāta veļas mašīna', 'Lūdzu personīgi griezties pie dienesta viesnīcas komandantes, personai, kura sabojāja veļas mašīnu', 2, 3, '2014-05-13 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `ligumi`
--

CREATE TABLE IF NOT EXISTS `ligumi` (
  `ID` int(11) NOT NULL COMMENT 'Līguma identifikators',
  `students_fk` int(11) NOT NULL COMMENT 'Students, ar kuru līgums noslēgts',
  `no` date NOT NULL COMMENT 'Īres sākuma datums',
  `lidz` date NOT NULL COMMENT 'Īres beigu datums',
  `liguma_numurs` varchar(45) NOT NULL COMMENT 'Līguma numurs',
  `komentars` varchar(200) DEFAULT NULL COMMENT 'Komentārs par līgumu',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `lidz` (`lidz`),
  KEY `liguma_numurs` (`liguma_numurs`),
  KEY `liguma_numurs_2` (`liguma_numurs`),
  KEY `studenta_id` (`students_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācija par līgumiem';

--
-- Dumping data for table `ligumi`
--

INSERT INTO `ligumi` (`ID`, `students_fk`, `no`, `lidz`, `liguma_numurs`, `komentars`) VALUES
(1, 1, '2014-05-01', '2014-09-01', 'LUDV12348826', 'Vieta komentāram'),
(2, 2, '2013-09-01', '2014-06-01', 'LUDV18786512', 'Vieta komentāram');

-- --------------------------------------------------------

--
-- Table structure for table `maksajumi`
--

CREATE TABLE IF NOT EXISTS `maksajumi` (
  `ID` int(11) NOT NULL COMMENT 'Maksājuma identifikators',
  `datums_no` date NOT NULL COMMENT 'Apmaksas perioda sākuma datums',
  `datums_lidz` date NOT NULL COMMENT 'Apmaksas perioda beigu datums',
  `students_fk` int(11) NOT NULL COMMENT 'Studenta identifikators',
  `statuss` tinyint(1) NOT NULL COMMENT 'Maksājuma statuss',
  `datums` date NOT NULL COMMENT 'Datums, kad maksājums iesniegts',
  `daudzums` float NOT NULL COMMENT 'Summa, kāda apmaksāta',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `students` (`students_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācija par maksājumiem';

--
-- Dumping data for table `maksajumi`
--

INSERT INTO `maksajumi` (`ID`, `datums_no`, `datums_lidz`, `students_fk`, `statuss`, `datums`, `daudzums`) VALUES
(1, '2014-05-12', '2014-06-12', 1, 1, '2014-05-01', 45.5),
(2, '2014-05-30', '2014-06-30', 3, 0, '2014-05-22', 12);

-- --------------------------------------------------------

--
-- Table structure for table `studenti`
--

CREATE TABLE IF NOT EXISTS `studenti` (
  `ID` int(11) NOT NULL COMMENT 'Lietotāja identifikators',
  `id_numurs` varchar(10) NOT NULL COMMENT 'Studenta apliecības numurs',
  `vards` varchar(45) NOT NULL COMMENT 'Studenta vārds',
  `uzvards` varchar(45) NOT NULL COMMENT 'Studenta uzvārds',
  `kurss` tinyint(4) NOT NULL COMMENT 'Studenta kursa numurs',
  `fakultate` varchar(45) CHARACTER SET utf32 NOT NULL COMMENT 'Fakultāte, kurā students studē',
  `istabas_numurs_fk` int(11) DEFAULT NULL COMMENT 'Istabiņa, kuru students īrē',
  `parole` varchar(100) NOT NULL COMMENT 'Parole šifrētā veidā',
  `epasts` varchar(255) DEFAULT NULL COMMENT 'Studenta e-pasts',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `istabas_numurs` (`istabas_numurs_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācijas par studentiem';

--
-- Dumping data for table `studenti`
--

INSERT INTO `studenti` (`ID`, `id_numurs`, `vards`, `uzvards`, `kurss`, `fakultate`, `istabas_numurs_fk`, `parole`, `epasts`) VALUES
(1, 'ul12012', 'Uldis', 'Lasmanis', 2, 'Datorikas fakultāte', 1, 'parole', 'uldisgc@inbox.lv'),
(2, 'kt11098', 'Kārlis', 'Taurēns', 3, 'Ekonomikas un vadības fakultāte', 1, 'parole', 'karlis@inbox.lv'),
(3, 'so10109', 'Solveiga', 'Orinska', 1, 'Datorikas fakultāte', 2, 'parole', 'solveiga.orinska@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `vestules`
--

CREATE TABLE IF NOT EXISTS `vestules` (
  `ID` int(11) NOT NULL COMMENT 'Ziņojuma identifikators',
  `virsraksts` varchar(100) NOT NULL COMMENT 'Ziņojuma nosaukums',
  `saturs` varchar(2000) NOT NULL COMMENT 'Ziņojuma saturs',
  `autors_fk` int(11) NOT NULL COMMENT 'Administratora identifikators',
  `sanemejs_fk` int(11) NOT NULL COMMENT 'Studenta identifikators',
  `datums` datetime NOT NULL COMMENT 'Datums, kad ziņojums izsūtīts',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `autors` (`autors_fk`),
  KEY `sanemejs` (`sanemejs_fk`),
  KEY `autors_2` (`autors_fk`),
  KEY `sanemejs_2` (`sanemejs_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informācija par vēstulēm';

--
-- Dumping data for table `vestules`
--

INSERT INTO `vestules` (`ID`, `virsraksts`, `saturs`, `autors_fk`, `sanemejs_fk`, `datums`) VALUES
(1, 'Kavēts maksājums', 'Lūgums steidzami samaksāt īres maksu par maiju', 2, 1, '2014-05-12 12:00:00'),
(2, 'Remonts', 'Lūdzu izvākties no savas istabiņas uz 2nedēļām laika posmā no 13.05.2014 līdz 28.05.2014 sakarā ar istabiņas remontu. Pagaidu naktsmājas nepiešķiram.', 3, 3, '2014-05-12 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `viesnicas`
--

CREATE TABLE IF NOT EXISTS `viesnicas` (
  `ID` int(11) NOT NULL COMMENT 'Dienesta viesnīcas identifikators',
  `nosaukums` varchar(100) NOT NULL COMMENT 'Viesnīcas nosaukums',
  `apraksts` varchar(1000) DEFAULT NULL COMMENT 'Viesnīcas apraksts',
  `istabu_skaits` int(11) DEFAULT NULL COMMENT 'Istabiņu skaits',
  `max_studentu_skaits` int(11) DEFAULT NULL COMMENT 'Maksimāli pieļaujamais studentu skaits',
  `adrese` varchar(100) NOT NULL COMMENT 'Viesnīcas atrašanās vietas adrese',
  `attels` varchar(100) DEFAULT NULL COMMENT 'Viesnīcas attēla nosaukums',
  `radit` tinyint(1) NOT NULL COMMENT 'Statuss, vai viesnīcas informācija ir pilnīga un viesnīcu drīkst rādīt',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pašu viesnīcu tabula';

--
-- Dumping data for table `viesnicas`
--

INSERT INTO `viesnicas` (`ID`, `nosaukums`, `apraksts`, `istabu_skaits`, `max_studentu_skaits`, `adrese`, `attels`, `radit`) VALUES
(1, 'DV1', 'te būs apraksts', 80, 230, 'Adrešu iela 11', 'DV no ārpuses', 1),
(2, 'DV2', 'te būs apraksts', 110, 300, 'Jaunā iela 17', 'Skats no ārpuses', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `istabas`
--
ALTER TABLE `istabas`
  ADD CONSTRAINT `Viesnīcu istabas ID` FOREIGN KEY (`viesnica_fk`) REFERENCES `viesnicas` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `istabu_atteli`
--
ALTER TABLE `istabu_atteli`
  ADD CONSTRAINT `Istabu attēlu identifikators` FOREIGN KEY (`istabas_numurs_id`) REFERENCES `istabas` (`ID`);

--
-- Constraints for table `istabu_pieprasijumi`
--
ALTER TABLE `istabu_pieprasijumi`
  ADD CONSTRAINT `DV pārvaldnieka ID` FOREIGN KEY (`administrators_fk`) REFERENCES `administratori` (`ID`),
  ADD CONSTRAINT `Istaba, kuru pieprasa` FOREIGN KEY (`istabas_id_fk`) REFERENCES `istabas` (`ID`),
  ADD CONSTRAINT `Studenta, kurš pieprasa istabiņu, ID` FOREIGN KEY (`students_fk`) REFERENCES `studenti` (`ID`);

--
-- Constraints for table `jaunumi`
--
ALTER TABLE `jaunumi`
  ADD CONSTRAINT `Administrators, kurš ir jaunumu autors` FOREIGN KEY (`autors_fk`) REFERENCES `administratori` (`ID`),
  ADD CONSTRAINT `Viesnīcas ID, uz kuru attiecas raksts` FOREIGN KEY (`kategorija_fk`) REFERENCES `viesnicas` (`ID`);

--
-- Constraints for table `ligumi`
--
ALTER TABLE `ligumi`
  ADD CONSTRAINT `Studenta ID, ar kuru noslēgts līgums` FOREIGN KEY (`students_fk`) REFERENCES `studenti` (`ID`);

--
-- Constraints for table `maksajumi`
--
ALTER TABLE `maksajumi`
  ADD CONSTRAINT `Studenta ID, kurš veic maksājumu` FOREIGN KEY (`students_fk`) REFERENCES `studenti` (`ID`);

--
-- Constraints for table `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `Istaba, kuru students īrē` FOREIGN KEY (`istabas_numurs_fk`) REFERENCES `istabas` (`ID`);

--
-- Constraints for table `vestules`
--
ALTER TABLE `vestules`
  ADD CONSTRAINT `Administrators, kurš sūta vēstuli` FOREIGN KEY (`autors_fk`) REFERENCES `administratori` (`ID`),
  ADD CONSTRAINT `Students, kurš saņem vēstuli` FOREIGN KEY (`sanemejs_fk`) REFERENCES `studenti` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
