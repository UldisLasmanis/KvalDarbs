-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 15, 2014 at 09:01 AM
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
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Lietotāja identifikators',
  `lietotajvards` varchar(45) NOT NULL COMMENT 'Lietotājvārds',
  `parole` varchar(100) NOT NULL COMMENT 'Parole šifrētā veidā',
  `Personas_ID` int(11) NOT NULL COMMENT 'Personas ID',
  `tips` tinyint(1) NOT NULL COMMENT 'Administratora veids',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācija par administratoriem' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `administratori`
--

INSERT INTO `administratori` (`ID`, `lietotajvards`, `parole`, `Personas_ID`, `tips`) VALUES
(1, 'SystemAdmin', 'parole', 1, 0),
(2, 'DV1_Admin', 'parole', 2, 1),
(3, 'DV2_Admin', 'parole', 3, 1),
(4, 'DV3_Admin', 'parole', 4, 1),
(5, 'DV4_Admin', 'parole', 5, 1),
(6, 'DV5_Admin', 'parole', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `istabas`
--

CREATE TABLE IF NOT EXISTS `istabas` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Istabiņas identifikators',
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Istabu informācija' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `istabas`
--

INSERT INTO `istabas` (`ID`, `ires_cena`, `Vietas`, `viesnica_fk`, `istabas_numurs`, `radit`, `apraksts`, `ir_izirejama`) VALUES
(1, 45.5, 3, 1, 101, 1, '3vietīga istaba', 0),
(2, 45.5, 4, 1, 102, 1, '4vietīga istaba', 1),
(3, 60, 2, 2, 101, 1, '2 vietīga, moderna istaba', 1),
(4, 80, 1, 2, 102, 1, 'Cilvēkiem, kuri vēlas dzīvot vienatnē', 1),
(5, 45.5, 3, 3, 101, 0, '3 vietīga istaba', 0),
(6, 45.5, 3, 3, 102, 0, '3 vietīga istaba', 0),
(7, 50.5, 4, 4, 101, 0, '3 vietīga istaba jaunuzceltā dienesta viesnīcā', 1),
(8, 80, 2, 4, 102, 0, '2 vietīga istaba jaunuzceltā dienesta viesnīcā', 1),
(9, 105.5, 3, 5, 101, 1, 'Plaša 3 vietīga istaba ar visām ērtībām', 0),
(10, 140, 2, 5, 102, 1, 'Plaša 2 vietīga istaba ar visām ērtībām', 1);

-- --------------------------------------------------------

--
-- Table structure for table `istabu_atteli`
--

CREATE TABLE IF NOT EXISTS `istabu_atteli` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Attēla identifikators',
  `istabas_id_fk` int(11) NOT NULL COMMENT 'Istabiņas identifikators',
  `attels` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'Attēla nosaukums',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `istabas_numurs` (`istabas_id_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `istabu_atteli`
--

INSERT INTO `istabu_atteli` (`ID`, `istabas_id_fk`, `attels`) VALUES
(1, 1, '101.istaba'),
(2, 2, '102.istaba'),
(3, 3, '101.istaba'),
(4, 4, '102.istaba'),
(5, 5, '101.istaba'),
(6, 6, '102.istaba'),
(7, 7, '101.istaba'),
(8, 8, '102.istaba'),
(9, 9, '101.istaba'),
(10, 10, '102.istaba');

-- --------------------------------------------------------

--
-- Table structure for table `istabu_pieprasijumi`
--

CREATE TABLE IF NOT EXISTS `istabu_pieprasijumi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Pieprasījuma identifikators',
  `istabas_id_fk` int(11) NOT NULL COMMENT 'Pieprasītās istabiņas identifikators',
  `statuss` varchar(45) NOT NULL COMMENT 'Pieprasījuma statuss',
  `administrators_fk` int(11) NOT NULL COMMENT 'Pārvaldnieka identifikators',
  `students_fk` int(11) NOT NULL COMMENT 'Studenta identifikators',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `istabas_id` (`istabas_id_fk`),
  KEY `administrators` (`administrators_fk`),
  KEY `students` (`students_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācija par istabu pieprasījumiem' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `istabu_pieprasijumi`
--

INSERT INTO `istabu_pieprasijumi` (`ID`, `istabas_id_fk`, `statuss`, `administrators_fk`, `students_fk`) VALUES
(1, 1, 'Nav brīvu vietu', 2, 9),
(2, 8, 'Remontā. Pieejama no 19.05.2014', 5, 11),
(3, 3, 'Vietas pieejamas. Griezties pie komandantes', 3, 10),
(4, 10, 'Vietas pieejamas. Griezties pie komandantes', 6, 12),
(5, 6, 'Brīvu vietu nav', 4, 3),
(6, 4, 'Brīvu vietu nav', 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `jaunumi`
--

CREATE TABLE IF NOT EXISTS `jaunumi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Raksta identifikators',
  `virsraksts` varchar(100) NOT NULL COMMENT 'Raksta nosaukums',
  `saturs` varchar(2000) NOT NULL COMMENT 'Raksta saturs',
  `kategorija_fk` int(11) NOT NULL COMMENT 'Viesnīcas identifikators',
  `autors_fk` int(11) NOT NULL COMMENT 'Administratora identifikators',
  `pievienosanas_datums` datetime NOT NULL COMMENT 'Laiks, kad raksts izveidots',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `kategorija` (`kategorija_fk`),
  KEY `autors` (`autors_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācija par jaunumiem' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `jaunumi`
--

INSERT INTO `jaunumi` (`ID`, `virsraksts`, `saturs`, `kategorija_fk`, `autors_fk`, `pievienosanas_datums`) VALUES
(1, 'Remonts', 'Dienesta viesnīcas 4.stāvā būs remonts no 13.04.2014-09.05.2014', 1, 2, '2014-04-08 10:30:00'),
(2, 'Remonts', 'Dienesta viesnīcas 2.stāvā būs remonts no 23.06.2014-09.07.2014', 2, 3, '2014-06-18 12:00:00'),
(3, 'Žurkas', 'Dienesta viesnīcā ir un būs žurkas', 1, 1, '2014-05-14 11:00:00'),
(4, 'Veļas maiņa', 'Dienesta viesnīcā no 12.05.2014-18.05.2014 nebūs iespējams apmainīt gultas veļu', 4, 5, '2014-05-01 10:00:00'),
(5, 'Pazudušas izlietnes', 'Persona, kurai likās ļoti smieklīgi nozagt 3 izlietnes 5.stāvā, lūdzu tās atgriezt atpakaļ', 5, 6, '2014-05-12 00:00:00'),
(6, 'Koju apkārtnes apkopšana', '12.05.2014 18:00 visi pulcējamies, lai sakoptu dienesta viesnīcas apkārtni.', 3, 4, '2014-05-09 16:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `ligumi`
--

CREATE TABLE IF NOT EXISTS `ligumi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Līguma identifikators',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācija par līgumiem' AUTO_INCREMENT=15 ;

--
-- Dumping data for table `ligumi`
--

INSERT INTO `ligumi` (`ID`, `students_fk`, `no`, `lidz`, `liguma_numurs`, `komentars`) VALUES
(1, 1, '2014-05-01', '2014-08-31', 'LUDV1-16532', 'Līgums noslēgts uz 4 mēnešiem'),
(2, 4, '2014-06-01', '2014-11-30', 'LUDV2-09812', 'Līgums noslēgts uz 6 mēnešiem'),
(3, 2, '2014-05-01', '2014-05-31', 'LUDV1-16725', 'Līgums noslēgts uz 1 mēnesi'),
(4, 3, '2014-05-01', '2014-08-31', 'LUDV2-08761', 'Līgums noslēgts uz 4 mēnešiem'),
(5, 5, '2014-01-01', '2014-06-30', 'LUDV3-87611', 'Līgums noslēgts uz 6 mēnešiem'),
(6, 6, '2014-01-01', '2014-12-31', 'LUDV3-87612', 'Līgums noslēgts uz 12 mēnešiem'),
(7, 7, '2014-01-01', '2014-10-31', 'LUDV3-61515', 'Līgums noslēgts uz 10 mēnešiem'),
(8, 8, '2014-05-01', '2014-07-31', 'LUDV4-19887', 'Līgums noslēgts uz 3 mēnešiem'),
(9, 9, '2013-09-01', '2014-06-30', 'LUDV4-12109', 'Līgums noslēgts uz 10 mēnešiem'),
(10, 10, '2014-09-01', '2014-12-31', 'LUDV4-12188', 'Līgums noslēgts uz 4 mēnešiem'),
(11, 11, '2014-06-01', '2014-08-31', 'LUDV4-78112', 'Līgums noslēgts uz 3 mēnešiem'),
(12, 12, '2014-01-01', '2014-05-31', 'LUDV5-10098', 'Līgums noslēgts uz 5 mēnešiem'),
(13, 13, '2014-04-01', '2014-05-31', 'LUDV5-10990', 'Līgums noslēgts uz 2 mēnešiem'),
(14, 14, '2014-03-01', '2014-06-30', 'LUDV5-10987', 'Līgums noslēgts uz 4 mēnešiem');

-- --------------------------------------------------------

--
-- Table structure for table `maksajumi`
--

CREATE TABLE IF NOT EXISTS `maksajumi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Maksājuma identifikators',
  `datums_no` date NOT NULL COMMENT 'Apmaksas perioda sākuma datums',
  `datums_lidz` date NOT NULL COMMENT 'Apmaksas perioda beigu datums',
  `students_fk` int(11) NOT NULL COMMENT 'Studenta identifikators',
  `statuss` tinyint(1) NOT NULL COMMENT 'Maksājuma statuss',
  `datums` date NOT NULL COMMENT 'Datums, kad maksājums iesniegts',
  `daudzums` float NOT NULL COMMENT 'Summa, kāda apmaksāta',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `students` (`students_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācija par maksājumiem' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `maksajumi`
--

INSERT INTO `maksajumi` (`ID`, `datums_no`, `datums_lidz`, `students_fk`, `statuss`, `datums`, `daudzums`) VALUES
(1, '2014-05-01', '2014-06-01', 8, 1, '2013-12-22', 50.5),
(2, '2014-05-08', '2014-06-07', 14, 1, '2014-05-01', 105.5),
(3, '2014-04-01', '2014-06-01', 1, 1, '2014-03-26', 91),
(4, '2014-05-01', '2014-08-31', 10, 1, '2014-04-21', 320),
(5, '2014-06-01', '2014-06-30', 2, 1, '2014-05-20', 91),
(6, '2014-03-01', '2014-06-30', 11, 0, '2014-02-20', 320),
(7, '2014-05-01', '2014-07-31', 9, 0, '2014-04-29', 151.5),
(8, '2014-05-01', '2014-07-31', 7, 1, '2014-04-21', 136.5),
(9, '2014-06-01', '2014-12-31', 6, 1, '2014-05-19', 273),
(10, '2014-05-01', '2014-05-31', 12, 1, '2014-04-21', 105.5);

-- --------------------------------------------------------

--
-- Table structure for table `personas`
--

CREATE TABLE IF NOT EXISTS `personas` (
  `Vards` varchar(45) NOT NULL,
  `Uzvards` varchar(45) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Personu tabula' AUTO_INCREMENT=21 ;

--
-- Dumping data for table `personas`
--

INSERT INTO `personas` (`Vards`, `Uzvards`, `ID`) VALUES
('Uldis', 'Lasmanis', 1),
('Ruta', 'Lejiņa', 2),
('Jānis', 'Uzraudziņš', 3),
('Ansis', 'Kalniņš', 4),
('Sintija', 'Laipa', 5),
('Uģis', 'Lipskis', 6),
('Lāsma', 'Devīte', 7),
('Guntis', 'Rieksts', 8),
('Kaspars', 'Jaunzems', 9),
('Jānis', 'Žipris', 10),
('Anna', 'Jaunā', 11),
('Vilnis', 'Valdnieciņš', 12),
('Toms', 'Trakulis', 13),
('Māris', 'Desa', 14),
('Liene', 'Atvara', 15),
('Inga', 'Jukuma', 16),
('Uldis', 'Smaiklis', 17),
('Juris', 'Dauksts', 18),
('Kārlis', 'Tapiņš', 19),
('Jolanta', 'Jautrīte', 20);

-- --------------------------------------------------------

--
-- Table structure for table `studenti`
--

CREATE TABLE IF NOT EXISTS `studenti` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Lietotāja identifikators',
  `id_numurs` varchar(10) NOT NULL COMMENT 'Studenta apliecības numurs',
  `Personas_ID` int(11) NOT NULL COMMENT 'Studenta vārds',
  `kurss` tinyint(4) NOT NULL COMMENT 'Studenta kursa numurs',
  `fakultate` varchar(45) CHARACTER SET utf32 NOT NULL COMMENT 'Fakultāte, kurā students studē',
  `istabas_id_fk` int(11) DEFAULT NULL COMMENT 'Istabiņa, kuru students īrē',
  `parole` varchar(100) NOT NULL COMMENT 'Parole šifrētā veidā',
  `epasts` varchar(255) DEFAULT NULL COMMENT 'Studenta e-pasts',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  KEY `istabas_numurs` (`istabas_id_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācijas par studentiem' AUTO_INCREMENT=15 ;

--
-- Dumping data for table `studenti`
--

INSERT INTO `studenti` (`ID`, `id_numurs`, `Personas_ID`, `kurss`, `fakultate`, `istabas_id_fk`, `parole`, `epasts`) VALUES
(1, 'ld12121', 7, 2, 'Datorikas fakultāte', 1, 'parole', 'ld12121@inbox.lv'),
(2, 'gr10988', 8, 1, 'Medicīnas fakultāte', 2, 'parole', 'guntis.rieksts@inbox.lv'),
(3, 'kj13091', 9, 4, 'Datorikas fakultāte', 2, 'parole', 'KasparsJ@gmail.com'),
(4, 'jz12871', 10, 3, 'Ekonomikas un vadības fakultāte', 3, 'parole', 'janko@inbox.lv'),
(5, 'aj12167', 11, 3, 'Datorikas fakultāte', 4, 'parole', 'anna.jauna@hotmail.com'),
(6, 'vv10071', 12, 1, 'Datorikas fakultāte', 5, 'parole', 'vilnis.valdniecins@gmail.com'),
(7, 'tt08761', 13, 2, 'Vēstures un filozofijas fakultāte', 6, 'parole', 'tomins@gmail.com'),
(8, 'md09098', 14, 3, 'Vēstures un filozofijas fakultāte', 7, 'parole', 'desainais@inbox.lv'),
(9, 'la12098', 15, 3, 'Ģeogrāfijas un Zemes zinātņu fakultāte', 7, 'parole', 'liene.atvara@inbox.lv'),
(10, 'ij08870', 16, 1, 'Teoloģijas fakultāte', 8, 'parole', 'inga.jukuma@gmail.com'),
(11, 'us13013', 17, 2, 'Ekonomikas un vadības fakultāte', 8, 'parole', 'uldins@gmail.com'),
(12, 'jd09761', 18, 4, 'Datorikas fakultāte', 9, 'parole', 'juris.dauksts@delfi.lv'),
(13, 'kt11071', 19, 1, 'Medicīnas fakultāte', 9, 'parole', 'karlist@gmail.com'),
(14, 'jj11098', 20, 1, 'Medicīnas fakultāte', 9, 'parole', 'jolanta.jautrite@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `vestules`
--

CREATE TABLE IF NOT EXISTS `vestules` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Ziņojuma identifikators',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Informācija par vēstulēm' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `vestules`
--

INSERT INTO `vestules` (`ID`, `virsraksts`, `saturs`, `autors_fk`, `sanemejs_fk`, `datums`) VALUES
(1, 'Kavēts maksājums', 'Lūgums steidzami veikt maksājumu par maija mēnesi', 2, 2, '2014-05-06 10:00:00'),
(2, 'Remonts 101.istabā', 'Sakarā ar remonta veikšanu 101.istabā, lūgums atbrīvot istabu līdz 15.05.2014 plkst. 12:00. Remonts notiks līdz 22.05.2014. Šo nedēļu paši izdomājiet kur dzīvot', 3, 4, '2014-05-11 13:00:00'),
(3, 'Skaļa mūzika vēlās stundās', 'Lūgums neklausīties skaļu mūziku pēc 23:00. Būsim saprotoši pret citiem koju iemītniekiem!', 5, 10, '2014-05-15 00:00:00'),
(4, 'Skaļa mūzika vēlās stundās', 'Lūgums neklausīties skaļu mūziku pēc 23:00. Būsim saprotoši pret citiem koju iemītniekiem!', 5, 11, '2014-05-15 00:00:00'),
(6, 'Kavēts maksājums', 'Lūgums veikt maksājumu par laika periodu no 01.04.2014 līdz 31.05.2014. Ja līdz 31.maijam maksājums nebūs veikts, mums ir tiesības lauzt līgumu.', 6, 14, '2014-05-15 00:00:00'),
(7, 'Kavēts maksājums', 'Lūgums veikt maksājumu par laika periodu no 01.02.2014 līdz 31.05.2014. Ja līdz 31.maijam maksājums nebūs veikts, mums ir tiesības lauzt līgumu.', 4, 7, '2014-05-15 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `viesnicas`
--

CREATE TABLE IF NOT EXISTS `viesnicas` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Dienesta viesnīcas identifikators',
  `nosaukums` varchar(100) NOT NULL COMMENT 'Viesnīcas nosaukums',
  `apraksts` varchar(1000) DEFAULT NULL COMMENT 'Viesnīcas apraksts',
  `istabu_skaits` int(11) DEFAULT NULL COMMENT 'Istabiņu skaits',
  `max_studentu_skaits` int(11) DEFAULT NULL COMMENT 'Maksimāli pieļaujamais studentu skaits',
  `adrese` varchar(100) NOT NULL COMMENT 'Viesnīcas atrašanās vietas adrese',
  `attels` varchar(100) DEFAULT NULL COMMENT 'Viesnīcas attēla nosaukums',
  `radit` tinyint(1) NOT NULL COMMENT 'Statuss, vai viesnīcas informācija ir pilnīga un viesnīcu drīkst rādīt',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Pašu viesnīcu tabula' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `viesnicas`
--

INSERT INTO `viesnicas` (`ID`, `nosaukums`, `apraksts`, `istabu_skaits`, `max_studentu_skaits`, `adrese`, `attels`, `radit`) VALUES
(1, 'Dienesta Viesnīca 1', '1.Dienesta viesnīca', 80, 210, 'Zeļļu iela 8', 'Skats no ārpuses', 1),
(2, 'Dienesta viesnīca 2', '2.Dienesta viesnīca', 110, 300, 'Brīvības iela 89', 'Skats no ārpuses', 1),
(3, 'Dienesta viesnīca 3', '3.Dienesta viesnīca', 90, 250, 'Rūķu iela 1', 'Skats no ārpuses', 0),
(4, 'Dienesta viesnīca 4', '4.Dienesta viesnīca ', 60, 260, 'Lielā iela 198', 'Skats no ārpuses', 1),
(5, 'Dienesta viesnīca 5', '5.Dienesta viesnīca', 150, 400, 'Kuģu iela 19', 'Skats no ārpuses', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `istabas`
--
ALTER TABLE `istabas`
  ADD CONSTRAINT `Viesnīcām piesaistītās istabas` FOREIGN KEY (`viesnica_fk`) REFERENCES `viesnicas` (`ID`);

--
-- Constraints for table `istabu_atteli`
--
ALTER TABLE `istabu_atteli`
  ADD CONSTRAINT `Istabas attēlam piesaistītais istabas ID` FOREIGN KEY (`istabas_id_fk`) REFERENCES `istabas` (`ID`);

--
-- Constraints for table `istabu_pieprasijumi`
--
ALTER TABLE `istabu_pieprasijumi`
  ADD CONSTRAINT `Studenta ID, kurš pieprasa istabu` FOREIGN KEY (`students_fk`) REFERENCES `studenti` (`ID`),
  ADD CONSTRAINT `Istabas ID, kuru pieprasa` FOREIGN KEY (`istabas_id_fk`) REFERENCES `istabas` (`ID`),
  ADD CONSTRAINT `Konkrētās dienesta viesnīcas administrators` FOREIGN KEY (`administrators_fk`) REFERENCES `administratori` (`ID`);

--
-- Constraints for table `jaunumi`
--
ALTER TABLE `jaunumi`
  ADD CONSTRAINT `Viesnīcas ID uz kuru attiecas jaunums` FOREIGN KEY (`kategorija_fk`) REFERENCES `viesnicas` (`ID`),
  ADD CONSTRAINT `Administratora, kurš izveidoja jaunumu, ID` FOREIGN KEY (`autors_fk`) REFERENCES `administratori` (`ID`);

--
-- Constraints for table `ligumi`
--
ALTER TABLE `ligumi`
  ADD CONSTRAINT `Studenta ID ar kuru noslēgts līgums` FOREIGN KEY (`students_fk`) REFERENCES `studenti` (`ID`);

--
-- Constraints for table `maksajumi`
--
ALTER TABLE `maksajumi`
  ADD CONSTRAINT `Studenta ID, kurš veic maksājumu` FOREIGN KEY (`students_fk`) REFERENCES `studenti` (`ID`);

--
-- Constraints for table `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `Istaba, kurā dzīvo students` FOREIGN KEY (`istabas_id_fk`) REFERENCES `istabas` (`ID`);

--
-- Constraints for table `vestules`
--
ALTER TABLE `vestules`
  ADD CONSTRAINT `Studenta ID, kuram tiek adresēta vēstule` FOREIGN KEY (`sanemejs_fk`) REFERENCES `studenti` (`ID`),
  ADD CONSTRAINT `Administratora,kurš izsūtīja vēstuli, ID` FOREIGN KEY (`autors_fk`) REFERENCES `administratori` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
