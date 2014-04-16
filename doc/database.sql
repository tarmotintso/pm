-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2014 at 02:59 PM
-- Server version: 5.5.34
-- PHP Version: 5.4.22

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `pm`
--

-- --------------------------------------------------------

--
-- Table structure for table `abstract_templates`
--

DROP TABLE IF EXISTS `abstract_templates`;
CREATE TABLE IF NOT EXISTS `abstract_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `ticket_media_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `allowed_for_everyone` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bank_messages`
--

DROP TABLE IF EXISTS `bank_messages`;
CREATE TABLE IF NOT EXISTS `bank_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE IF NOT EXISTS `campaigns` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `state` varchar(20) DEFAULT 'being_created',
  `allow_multiple_uses_of_codes` tinyint(1) DEFAULT '0',
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `max_allowed_tickets` int(11) DEFAULT NULL,
  `partner_id` int(11) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `campaign_codes`
--

DROP TABLE IF EXISTS `campaign_codes`;
CREATE TABLE IF NOT EXISTS `campaign_codes` (
  `id` int(11) NOT NULL,
  `code_value` varchar(255) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `use_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `campaign_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_et` varchar(50) NOT NULL,
  `name_en` varchar(50) NOT NULL,
  `name_ru` varchar(50) NOT NULL,
  `name_fi` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `birthdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sending_emails_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `business_type` int(11) DEFAULT NULL,
  `business_name` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `archived_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id` int(11) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `registered` tinyint(1) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `confirmation_token` text,
  `confirmed_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `session_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `client_marketing_subscriptions`
--

DROP TABLE IF EXISTS `client_marketing_subscriptions`;
CREATE TABLE IF NOT EXISTS `client_marketing_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `administrator_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `db_files`
--

DROP TABLE IF EXISTS `db_files`;
CREATE TABLE IF NOT EXISTS `db_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `main_pos_sales_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pos_sales_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `web_sales_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `main_pos_sales_end` int(11) NOT NULL DEFAULT '-3600',
  `pos_sales_end` int(11) NOT NULL DEFAULT '0',
  `web_sales_end` int(11) NOT NULL DEFAULT '0',
  `additional_information` text,
  `hall_plan_id` int(11) DEFAULT NULL,
  `booking_purchase_limit_days` int(11) DEFAULT NULL,
  `booking_valid_days` int(11) DEFAULT NULL,
  `comment` text,
  `administrator_id` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` varchar(20) DEFAULT 'being_created',
  `name` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `organizer_id` int(11) DEFAULT NULL,
  `archived_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `used_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `event_id` int(11) DEFAULT NULL,
  `abstract_template_id` int(11) DEFAULT NULL,
  `ticket_field_1` varchar(255) DEFAULT NULL,
  `ticket_field_2` varchar(255) DEFAULT NULL,
  `ticket_field_3` varchar(255) DEFAULT NULL,
  `name2` varchar(255) DEFAULT NULL,
  `name3` varchar(255) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `name_en` text,
  `name_ru` text,
  `name_fi` text,
  `name2_en` text,
  `name2_ru` text,
  `name2_fi` text,
  `name3_en` text,
  `name3_ru` text,
  `name3_fi` text,
  `short_description_en` text,
  `short_description_ru` text,
  `short_description_fi` text,
  `additional_information_en` text,
  `additional_information_fi` text,
  `additional_information_ru` text,
  `free_form_comments` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=46013 ;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `type`, `main_pos_sales_start`, `pos_sales_start`, `web_sales_start`, `main_pos_sales_end`, `pos_sales_end`, `web_sales_end`, `additional_information`, `hall_plan_id`, `booking_purchase_limit_days`, `booking_valid_days`, `comment`, `administrator_id`, `time`, `state`, `name`, `category_id`, `organizer_id`, `archived_at`, `archived_by_id`, `created_at`, `used_at`, `event_id`, `abstract_template_id`, `ticket_field_1`, `ticket_field_2`, `ticket_field_3`, `name2`, `name3`, `short_description`, `name_en`, `name_ru`, `name_fi`, `name2_en`, `name2_ru`, `name2_fi`, `name3_en`, `name3_ru`, `name3_fi`, `short_description_en`, `short_description_ru`, `short_description_fi`, `additional_information_en`, `additional_information_fi`, `additional_information_ru`, `free_form_comments`) VALUES
(22841, 'Event', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26856, 10, NULL, '', 1, '2014-04-16 11:37:57', 'archived', 'Kaunimate Aastate Vennaskond', 1, 144, '2012-02-09 15:49:53', 35, '2011-01-26 07:54:20', '2014-04-16 11:37:57', NULL, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', 'Kaunimate Aastate Vennaskond', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22842, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2011-09-07 21:00:00', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26857, 10, NULL, 'Kontsert jÃ¤Ã¤b Ã¤ra, toimub 21.03 Salme kultuurikeskuses. ostetud piletid kehtivad, kuid soovi korral ostame ka piletid tagasi.', 1, '2011-03-06 16:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-26 08:09:12', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', 'NaistepÃ¤evakontsert', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22843, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26859, 10, NULL, '', 1, '2011-03-07 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-26 08:34:48', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', 'NaistepÃ¤evakontsert', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22844, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26862, 10, NULL, '', 1, '2011-03-08 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-26 08:44:06', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', 'NaistepÃ¤evakontsert', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22873, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26963, 10, NULL, '', 1, '2011-03-10 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:10', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22874, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26960, 10, NULL, '', 1, '2011-03-11 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:11', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22875, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26962, 10, NULL, '', 1, '2011-03-13 13:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:12', '2014-04-16 11:37:57', 22841, 9, 'Kohad on vabalt valitavad', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22876, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26935, 10, NULL, '', 1, '2011-03-14 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:13', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22877, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26936, 10, NULL, '', 1, '2011-03-19 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:13', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22878, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26937, 10, NULL, '', 1, '2011-03-20 15:00:00', 'being_created', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:14', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22879, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 26940, 10, NULL, '', 1, '2011-03-27 16:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-01-28 13:43:15', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23128, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<h1>Kaunimate Aastate Vennaskond</h1><h1>Naistep&auml;evakontserdid <br /></h1>', 27252, 10, NULL, '6.03 Estonia kontsertsaali ostetud piletid kehtivad sellel kontserdil! Soovi korral osta piletid tagasi Ãµige (Estonia 6.03) saali plaani pealt.', 1, '2011-03-21 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 144, '2014-04-16 11:37:57', NULL, '2011-02-07 12:19:00', '2014-04-16 11:37:57', 22841, 258, '', '', '', 'MUUSIKALine KEVAD', 'NaistepÃ¤evakontsert', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46008, 'Event', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<!--[if gte mso 9]><xml>  <o:OfficeDocumentSettings>   <o:AllowPNG/>  </o:OfficeDocumentSettings> </xml><![endif]-->  <p style="text-align: justify" class="MsoNormal">Mis saab olla veel kaunim, kui &uuml;ks meelierutav suve&otilde;htu, koos teatri, laulu ja hea tujuga.<br /> Tule teatraalselt elegantsele kontserdile, kus astuvad &uuml;les humoorika kavaga laulvad n&auml;itlejad: Andres Dvinjaninov, Hannes Kaljuj&auml;rv, Indrek Kalda, Toomas Lunge ja J&uuml;ri Lumiste ehk Kaunimate Aastate Vennaskond.</p>  E 14. juuli - Saue, Vanam&otilde;isa Vaba&otilde;hukeskus, kell 20<br /> T 15. juuli - Vihula m&otilde;isa aed, kell 20<br /> K 16. juuli - P&auml;rnu, Ammende Villa aed, kell 20<br /> N 17. juuli - Tallinn, Linnateatri lavaauk, kell 20<br /> <br /> Piletihind eelm&uuml;&uuml;gist: 16 &euro;, 14 &euro; (pension&auml;r)<br /> Tallinna kontserdi piletihind eelm&uuml;&uuml;gist: 17 &euro;, 15 &euro; (pension&auml;rid)<br /> <br /> Lisainfo: <a href="http://www.kontsert.ee/">www.kontsert.ee</a> <br /> <br /> <br /> <!--[if gte mso 9]><xml>  <w:WordDocument>   <w:View>Normal</w:View>   <w:Zoom>0</w:Zoom>   <w:TrackMoves/>   <w:TrackFormatting/>   <w:HyphenationZone>21</w:HyphenationZone>   <w:PunctuationKerning/>   <w:ValidateAgainstSchemas/>   <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>   <w:IgnoreMixedContent>false</w:IgnoreMixedContent>   <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>   <w:DoNotPromoteQF/>   <w:LidThemeOther>ET</w:LidThemeOther>   <w:LidThemeAsian>X-NONE</w:LidThemeAsian>   <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>   <w:Compatibility>    <w:BreakWrappedTables/>    <w:SnapToGridInCell/>    <w:WrapTextWithPunct/>    <w:UseAsianBreakRules/>    <w:DontGrowAutofit/>    <w:SplitPgBreakAndParaMark/>    <w:EnableOpenTypeKerning/>    <w:DontFlipMirrorIndents/>    <w:OverrideTableStyleHps/>   </w:Compatibility>   <m:mathPr>    <m:mathFont m:val="Cambria Math"/>    <m:brkBin m:val="before"/>    <m:brkBinSub m:val="&#45;-"/>    <m:smallFrac m:val="off"/>    <m:dispDef/>    <m:lMargin m:val="0"/>    <m:rMargin m:val="0"/>    <m:defJc m:val="centerGroup"/>    <m:wrapIndent m:val="1440"/>    <m:intLim m:val="subSup"/>    <m:naryLim m:val="undOvr"/>   </m:mathPr></w:WordDocument> </xml><![endif]--><!--[if gte mso 9]><xml>  <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"   DefSemiHidden="true" DefQFormat="false" DefPriority="99"   LatentStyleCount="267">   <w:LsdException Locked="false" Priority="0" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Normal"/>   <w:LsdException Locked="false" Priority="9" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>   <w:LsdException Locked="false" Priority="39" Name="toc 1"/>   <w:LsdException Locked="false" Priority="39" Name="toc 2"/>   <w:LsdException Locked="false" Priority="39" Name="toc 3"/>   <w:LsdException Locked="false" Priority="39" Name="toc 4"/>   <w:LsdException Locked="false" Priority="39" Name="toc 5"/>   <w:LsdException Locked="false" Priority="39" Name="toc 6"/>   <w:LsdException Locked="false" Priority="39" Name="toc 7"/>   <w:LsdException Locked="false" Priority="39" Name="toc 8"/>   <w:LsdException Locked="false" Priority="39" Name="toc 9"/>   <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>   <w:LsdException Locked="false" Priority="10" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Title"/>   <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>   <w:LsdException Locked="false" Priority="11" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>   <w:LsdException Locked="false" Priority="22" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Strong"/>   <w:LsdException Locked="false" Priority="20" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>   <w:LsdException Locked="false" Priority="59" SemiHidden="false"    UnhideWhenUsed="false" Name="Table Grid"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>   <w:LsdException Locked="false" Priority="1" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 1"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 1"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 1"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>   <w:LsdException Locked="false" Priority="34" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>   <w:LsdException Locked="false" Priority="29" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Quote"/>   <w:LsdException Locked="false" Priority="30" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 1"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 1"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 2"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 2"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 2"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 2"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 2"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 3"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 3"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 3"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 3"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 3"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 4"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 4"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 4"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 4"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 4"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 5"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 5"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 5"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 5"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 5"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 6"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 6"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 6"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 6"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 6"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>   <w:LsdException Locked="false" Priority="19" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>   <w:LsdException Locked="false" Priority="21" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>   <w:LsdException Locked="false" Priority="31" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>   <w:LsdException Locked="false" Priority="32" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>   <w:LsdException Locked="false" Priority="33" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>   <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>   <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>  </w:LatentStyles> </xml><![endif]--><!--[if gte mso 10]> <style>  /* Style Definitions */  table.MsoNormalTable 	{mso-style-name:"Table Normal"; 	mso-tstyle-rowband-size:0; 	mso-tstyle-colband-size:0; 	mso-style-noshow:yes; 	mso-style-priority:99; 	mso-style-parent:""; 	mso-padding-alt:0cm 5.4pt 0cm 5.4pt; 	mso-para-margin:0cm; 	mso-para-margin-bottom:.0001pt; 	mso-pagination:widow-orphan; 	font-size:10.0pt; 	font-family:"Times New Roman","serif";} </style> <![endif]-->', 54677, 10, NULL, '', 1, '2014-04-16 11:37:57', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 279, '2014-04-16 11:37:57', NULL, '2014-04-14 11:23:25', '2014-04-16 11:37:57', NULL, 9, 'Kohad on nummerdamata', '', '', 'Ãœks, kaks, kolm, neli, mÃ¶Ã¶dus jÃ¤llegi Ã¼ks pÃ¤ev', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL),
(46009, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<!--[if gte mso 9]><xml>  <o:OfficeDocumentSettings>   <o:AllowPNG/>  </o:OfficeDocumentSettings> </xml><![endif]-->  <p style="text-align: justify" class="MsoNormal">Mis saab olla veel kaunim, kui &uuml;ks meelierutav suve&otilde;htu, koos teatri, laulu ja hea tujuga.<br /> Tule teatraalselt elegantsele kontserdile, kus astuvad &uuml;les humoorika kavaga laulvad n&auml;itlejad: Andres Dvinjaninov, Hannes Kaljuj&auml;rv, Indrek Kalda, Toomas Lunge ja J&uuml;ri Lumiste ehk Kaunimate Aastate Vennaskond.</p>  E 14. juuli - Saue, Vanam&otilde;isa Vaba&otilde;hukeskus, kell 20<br /> T 15. juuli - Vihula m&otilde;isa aed, kell 20<br /> K 16. juuli - P&auml;rnu, Ammende Villa aed, kell 20<br /> N 17. juuli - Tallinn, Linnateatri lavaauk, kell 20<br /> <br /> Piletihind eelm&uuml;&uuml;gist: 16 &euro;, 14 &euro; (pension&auml;r)<br /> Tallinna kontserdi piletihind eelm&uuml;&uuml;gist: 17 &euro;, 15 &euro; (pension&auml;rid)<br /> <br /> Lisainfo: <a href="http://www.kontsert.ee/">www.kontsert.ee</a> <br /> <br /> <br /> <!--[if gte mso 9]><xml>  <w:WordDocument>   <w:View>Normal</w:View>   <w:Zoom>0</w:Zoom>   <w:TrackMoves/>   <w:TrackFormatting/>   <w:HyphenationZone>21</w:HyphenationZone>   <w:PunctuationKerning/>   <w:ValidateAgainstSchemas/>   <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>   <w:IgnoreMixedContent>false</w:IgnoreMixedContent>   <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>   <w:DoNotPromoteQF/>   <w:LidThemeOther>ET</w:LidThemeOther>   <w:LidThemeAsian>X-NONE</w:LidThemeAsian>   <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>   <w:Compatibility>    <w:BreakWrappedTables/>    <w:SnapToGridInCell/>    <w:WrapTextWithPunct/>    <w:UseAsianBreakRules/>    <w:DontGrowAutofit/>    <w:SplitPgBreakAndParaMark/>    <w:EnableOpenTypeKerning/>    <w:DontFlipMirrorIndents/>    <w:OverrideTableStyleHps/>   </w:Compatibility>   <m:mathPr>    <m:mathFont m:val="Cambria Math"/>    <m:brkBin m:val="before"/>    <m:brkBinSub m:val="&#45;-"/>    <m:smallFrac m:val="off"/>    <m:dispDef/>    <m:lMargin m:val="0"/>    <m:rMargin m:val="0"/>    <m:defJc m:val="centerGroup"/>    <m:wrapIndent m:val="1440"/>    <m:intLim m:val="subSup"/>    <m:naryLim m:val="undOvr"/>   </m:mathPr></w:WordDocument> </xml><![endif]--><!--[if gte mso 9]><xml>  <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"   DefSemiHidden="true" DefQFormat="false" DefPriority="99"   LatentStyleCount="267">   <w:LsdException Locked="false" Priority="0" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Normal"/>   <w:LsdException Locked="false" Priority="9" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>   <w:LsdException Locked="false" Priority="39" Name="toc 1"/>   <w:LsdException Locked="false" Priority="39" Name="toc 2"/>   <w:LsdException Locked="false" Priority="39" Name="toc 3"/>   <w:LsdException Locked="false" Priority="39" Name="toc 4"/>   <w:LsdException Locked="false" Priority="39" Name="toc 5"/>   <w:LsdException Locked="false" Priority="39" Name="toc 6"/>   <w:LsdException Locked="false" Priority="39" Name="toc 7"/>   <w:LsdException Locked="false" Priority="39" Name="toc 8"/>   <w:LsdException Locked="false" Priority="39" Name="toc 9"/>   <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>   <w:LsdException Locked="false" Priority="10" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Title"/>   <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>   <w:LsdException Locked="false" Priority="11" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>   <w:LsdException Locked="false" Priority="22" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Strong"/>   <w:LsdException Locked="false" Priority="20" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>   <w:LsdException Locked="false" Priority="59" SemiHidden="false"    UnhideWhenUsed="false" Name="Table Grid"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>   <w:LsdException Locked="false" Priority="1" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 1"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 1"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 1"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>   <w:LsdException Locked="false" Priority="34" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>   <w:LsdException Locked="false" Priority="29" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Quote"/>   <w:LsdException Locked="false" Priority="30" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 1"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 1"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 2"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 2"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 2"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 2"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 2"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 3"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 3"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 3"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 3"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 3"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 4"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 4"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 4"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 4"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 4"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 5"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 5"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 5"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 5"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 5"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 6"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 6"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 6"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 6"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 6"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>   <w:LsdException Locked="false" Priority="19" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>   <w:LsdException Locked="false" Priority="21" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>   <w:LsdException Locked="false" Priority="31" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>   <w:LsdException Locked="false" Priority="32" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>   <w:LsdException Locked="false" Priority="33" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>   <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>   <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>  </w:LatentStyles> </xml><![endif]--><!--[if gte mso 10]> <style>  /* Style Definitions */  table.MsoNormalTable 	{mso-style-name:"Table Normal"; 	mso-tstyle-rowband-size:0; 	mso-tstyle-colband-size:0; 	mso-style-noshow:yes; 	mso-style-priority:99; 	mso-style-parent:""; 	mso-padding-alt:0cm 5.4pt 0cm 5.4pt; 	mso-para-margin:0cm; 	mso-para-margin-bottom:.0001pt; 	mso-pagination:widow-orphan; 	font-size:10.0pt; 	font-family:"Times New Roman","serif";} </style> <![endif]-->', 54678, 10, NULL, '', 1, '2014-07-14 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 279, '2014-04-16 11:37:57', NULL, '2014-04-14 11:24:15', '2014-04-16 11:37:57', 46008, 9, 'Kohad on nummerdamata', '', '', 'Ãœks, kaks, kolm, neli, mÃ¶Ã¶dus jÃ¤llegi Ã¼ks pÃ¤ev', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL);
INSERT INTO `events` (`id`, `type`, `main_pos_sales_start`, `pos_sales_start`, `web_sales_start`, `main_pos_sales_end`, `pos_sales_end`, `web_sales_end`, `additional_information`, `hall_plan_id`, `booking_purchase_limit_days`, `booking_valid_days`, `comment`, `administrator_id`, `time`, `state`, `name`, `category_id`, `organizer_id`, `archived_at`, `archived_by_id`, `created_at`, `used_at`, `event_id`, `abstract_template_id`, `ticket_field_1`, `ticket_field_2`, `ticket_field_3`, `name2`, `name3`, `short_description`, `name_en`, `name_ru`, `name_fi`, `name2_en`, `name2_ru`, `name2_fi`, `name3_en`, `name3_ru`, `name3_fi`, `short_description_en`, `short_description_ru`, `short_description_fi`, `additional_information_en`, `additional_information_fi`, `additional_information_ru`, `free_form_comments`) VALUES
(46010, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<!--[if gte mso 9]><xml>  <o:OfficeDocumentSettings>   <o:AllowPNG/>  </o:OfficeDocumentSettings> </xml><![endif]-->  <p style="text-align: justify" class="MsoNormal">Mis saab olla veel kaunim, kui &uuml;ks meelierutav suve&otilde;htu, koos teatri, laulu ja hea tujuga.<br /> Tule teatraalselt elegantsele kontserdile, kus astuvad &uuml;les humoorika kavaga laulvad n&auml;itlejad: Andres Dvinjaninov, Hannes Kaljuj&auml;rv, Indrek Kalda, Toomas Lunge ja J&uuml;ri Lumiste ehk Kaunimate Aastate Vennaskond.</p>  E 14. juuli - Saue, Vanam&otilde;isa Vaba&otilde;hukeskus, kell 20<br /> T 15. juuli - Vihula m&otilde;isa aed, kell 20<br /> K 16. juuli - P&auml;rnu, Ammende Villa aed, kell 20<br /> N 17. juuli - Tallinn, Linnateatri lavaauk, kell 20<br /> <br /> Piletihind eelm&uuml;&uuml;gist: 16 &euro;, 14 &euro; (pension&auml;r)<br /> Tallinna kontserdi piletihind eelm&uuml;&uuml;gist: 17 &euro;, 15 &euro; (pension&auml;rid)<br /> <br /> Lisainfo: <a href="http://www.kontsert.ee/">www.kontsert.ee</a> <br /> <br /> <br /> <!--[if gte mso 9]><xml>  <w:WordDocument>   <w:View>Normal</w:View>   <w:Zoom>0</w:Zoom>   <w:TrackMoves/>   <w:TrackFormatting/>   <w:HyphenationZone>21</w:HyphenationZone>   <w:PunctuationKerning/>   <w:ValidateAgainstSchemas/>   <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>   <w:IgnoreMixedContent>false</w:IgnoreMixedContent>   <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>   <w:DoNotPromoteQF/>   <w:LidThemeOther>ET</w:LidThemeOther>   <w:LidThemeAsian>X-NONE</w:LidThemeAsian>   <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>   <w:Compatibility>    <w:BreakWrappedTables/>    <w:SnapToGridInCell/>    <w:WrapTextWithPunct/>    <w:UseAsianBreakRules/>    <w:DontGrowAutofit/>    <w:SplitPgBreakAndParaMark/>    <w:EnableOpenTypeKerning/>    <w:DontFlipMirrorIndents/>    <w:OverrideTableStyleHps/>   </w:Compatibility>   <m:mathPr>    <m:mathFont m:val="Cambria Math"/>    <m:brkBin m:val="before"/>    <m:brkBinSub m:val="&#45;-"/>    <m:smallFrac m:val="off"/>    <m:dispDef/>    <m:lMargin m:val="0"/>    <m:rMargin m:val="0"/>    <m:defJc m:val="centerGroup"/>    <m:wrapIndent m:val="1440"/>    <m:intLim m:val="subSup"/>    <m:naryLim m:val="undOvr"/>   </m:mathPr></w:WordDocument> </xml><![endif]--><!--[if gte mso 9]><xml>  <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"   DefSemiHidden="true" DefQFormat="false" DefPriority="99"   LatentStyleCount="267">   <w:LsdException Locked="false" Priority="0" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Normal"/>   <w:LsdException Locked="false" Priority="9" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>   <w:LsdException Locked="false" Priority="39" Name="toc 1"/>   <w:LsdException Locked="false" Priority="39" Name="toc 2"/>   <w:LsdException Locked="false" Priority="39" Name="toc 3"/>   <w:LsdException Locked="false" Priority="39" Name="toc 4"/>   <w:LsdException Locked="false" Priority="39" Name="toc 5"/>   <w:LsdException Locked="false" Priority="39" Name="toc 6"/>   <w:LsdException Locked="false" Priority="39" Name="toc 7"/>   <w:LsdException Locked="false" Priority="39" Name="toc 8"/>   <w:LsdException Locked="false" Priority="39" Name="toc 9"/>   <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>   <w:LsdException Locked="false" Priority="10" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Title"/>   <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>   <w:LsdException Locked="false" Priority="11" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>   <w:LsdException Locked="false" Priority="22" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Strong"/>   <w:LsdException Locked="false" Priority="20" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>   <w:LsdException Locked="false" Priority="59" SemiHidden="false"    UnhideWhenUsed="false" Name="Table Grid"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>   <w:LsdException Locked="false" Priority="1" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 1"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 1"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 1"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>   <w:LsdException Locked="false" Priority="34" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>   <w:LsdException Locked="false" Priority="29" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Quote"/>   <w:LsdException Locked="false" Priority="30" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 1"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 1"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 2"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 2"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 2"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 2"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 2"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 3"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 3"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 3"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 3"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 3"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 4"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 4"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 4"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 4"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 4"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 5"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 5"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 5"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 5"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 5"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 6"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 6"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 6"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 6"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 6"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>   <w:LsdException Locked="false" Priority="19" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>   <w:LsdException Locked="false" Priority="21" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>   <w:LsdException Locked="false" Priority="31" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>   <w:LsdException Locked="false" Priority="32" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>   <w:LsdException Locked="false" Priority="33" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>   <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>   <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>  </w:LatentStyles> </xml><![endif]--><!--[if gte mso 10]> <style>  /* Style Definitions */  table.MsoNormalTable 	{mso-style-name:"Table Normal"; 	mso-tstyle-rowband-size:0; 	mso-tstyle-colband-size:0; 	mso-style-noshow:yes; 	mso-style-priority:99; 	mso-style-parent:""; 	mso-padding-alt:0cm 5.4pt 0cm 5.4pt; 	mso-para-margin:0cm; 	mso-para-margin-bottom:.0001pt; 	mso-pagination:widow-orphan; 	font-size:10.0pt; 	font-family:"Times New Roman","serif";} </style> <![endif]-->', 54682, 10, NULL, '', 1, '2014-07-15 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 279, '2014-04-16 11:37:57', NULL, '2014-04-14 11:24:15', '2014-04-16 11:37:57', 46008, 9, 'Kohad on nummerdamata', '', '', 'Ãœks, kaks, kolm, neli, mÃ¶Ã¶dus jÃ¤llegi Ã¼ks pÃ¤ev', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL),
(46011, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<!--[if gte mso 9]><xml>  <o:OfficeDocumentSettings>   <o:AllowPNG/>  </o:OfficeDocumentSettings> </xml><![endif]-->  <p style="text-align: justify" class="MsoNormal">Mis saab olla veel kaunim, kui &uuml;ks meelierutav suve&otilde;htu, koos teatri, laulu ja hea tujuga.<br /> Tule teatraalselt elegantsele kontserdile, kus astuvad &uuml;les humoorika kavaga laulvad n&auml;itlejad: Andres Dvinjaninov, Hannes Kaljuj&auml;rv, Indrek Kalda, Toomas Lunge ja J&uuml;ri Lumiste ehk Kaunimate Aastate Vennaskond.</p>  E 14. juuli - Saue, Vanam&otilde;isa Vaba&otilde;hukeskus, kell 20<br /> T 15. juuli - Vihula m&otilde;isa aed, kell 20<br /> K 16. juuli - P&auml;rnu, Ammende Villa aed, kell 20<br /> N 17. juuli - Tallinn, Linnateatri lavaauk, kell 20<br /> <br /> Piletihind eelm&uuml;&uuml;gist: 16 &euro;, 14 &euro; (pension&auml;r)<br /> Tallinna kontserdi piletihind eelm&uuml;&uuml;gist: 17 &euro;, 15 &euro; (pension&auml;rid)<br /> <br /> Lisainfo: <a href="http://www.kontsert.ee/">www.kontsert.ee</a> <br /> <br /> <br /> <!--[if gte mso 9]><xml>  <w:WordDocument>   <w:View>Normal</w:View>   <w:Zoom>0</w:Zoom>   <w:TrackMoves/>   <w:TrackFormatting/>   <w:HyphenationZone>21</w:HyphenationZone>   <w:PunctuationKerning/>   <w:ValidateAgainstSchemas/>   <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>   <w:IgnoreMixedContent>false</w:IgnoreMixedContent>   <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>   <w:DoNotPromoteQF/>   <w:LidThemeOther>ET</w:LidThemeOther>   <w:LidThemeAsian>X-NONE</w:LidThemeAsian>   <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>   <w:Compatibility>    <w:BreakWrappedTables/>    <w:SnapToGridInCell/>    <w:WrapTextWithPunct/>    <w:UseAsianBreakRules/>    <w:DontGrowAutofit/>    <w:SplitPgBreakAndParaMark/>    <w:EnableOpenTypeKerning/>    <w:DontFlipMirrorIndents/>    <w:OverrideTableStyleHps/>   </w:Compatibility>   <m:mathPr>    <m:mathFont m:val="Cambria Math"/>    <m:brkBin m:val="before"/>    <m:brkBinSub m:val="&#45;-"/>    <m:smallFrac m:val="off"/>    <m:dispDef/>    <m:lMargin m:val="0"/>    <m:rMargin m:val="0"/>    <m:defJc m:val="centerGroup"/>    <m:wrapIndent m:val="1440"/>    <m:intLim m:val="subSup"/>    <m:naryLim m:val="undOvr"/>   </m:mathPr></w:WordDocument> </xml><![endif]--><!--[if gte mso 9]><xml>  <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"   DefSemiHidden="true" DefQFormat="false" DefPriority="99"   LatentStyleCount="267">   <w:LsdException Locked="false" Priority="0" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Normal"/>   <w:LsdException Locked="false" Priority="9" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>   <w:LsdException Locked="false" Priority="39" Name="toc 1"/>   <w:LsdException Locked="false" Priority="39" Name="toc 2"/>   <w:LsdException Locked="false" Priority="39" Name="toc 3"/>   <w:LsdException Locked="false" Priority="39" Name="toc 4"/>   <w:LsdException Locked="false" Priority="39" Name="toc 5"/>   <w:LsdException Locked="false" Priority="39" Name="toc 6"/>   <w:LsdException Locked="false" Priority="39" Name="toc 7"/>   <w:LsdException Locked="false" Priority="39" Name="toc 8"/>   <w:LsdException Locked="false" Priority="39" Name="toc 9"/>   <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>   <w:LsdException Locked="false" Priority="10" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Title"/>   <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>   <w:LsdException Locked="false" Priority="11" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>   <w:LsdException Locked="false" Priority="22" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Strong"/>   <w:LsdException Locked="false" Priority="20" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>   <w:LsdException Locked="false" Priority="59" SemiHidden="false"    UnhideWhenUsed="false" Name="Table Grid"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>   <w:LsdException Locked="false" Priority="1" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 1"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 1"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 1"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>   <w:LsdException Locked="false" Priority="34" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>   <w:LsdException Locked="false" Priority="29" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Quote"/>   <w:LsdException Locked="false" Priority="30" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 1"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 1"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 2"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 2"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 2"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 2"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 2"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 3"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 3"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 3"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 3"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 3"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 4"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 4"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 4"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 4"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 4"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 5"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 5"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 5"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 5"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 5"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 6"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 6"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 6"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 6"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 6"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>   <w:LsdException Locked="false" Priority="19" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>   <w:LsdException Locked="false" Priority="21" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>   <w:LsdException Locked="false" Priority="31" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>   <w:LsdException Locked="false" Priority="32" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>   <w:LsdException Locked="false" Priority="33" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>   <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>   <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>  </w:LatentStyles> </xml><![endif]--><!--[if gte mso 10]> <style>  /* Style Definitions */  table.MsoNormalTable 	{mso-style-name:"Table Normal"; 	mso-tstyle-rowband-size:0; 	mso-tstyle-colband-size:0; 	mso-style-noshow:yes; 	mso-style-priority:99; 	mso-style-parent:""; 	mso-padding-alt:0cm 5.4pt 0cm 5.4pt; 	mso-para-margin:0cm; 	mso-para-margin-bottom:.0001pt; 	mso-pagination:widow-orphan; 	font-size:10.0pt; 	font-family:"Times New Roman","serif";} </style> <![endif]-->', 54684, 10, NULL, '', 1, '2014-07-16 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 279, '2014-04-16 11:37:57', NULL, '2014-04-14 11:24:15', '2014-04-16 11:37:57', 46008, 9, 'Kohad on nummerdamata', '', '', 'Ãœks, kaks, kolm, neli, mÃ¶Ã¶dus jÃ¤llegi Ã¼ks pÃ¤ev', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL);
INSERT INTO `events` (`id`, `type`, `main_pos_sales_start`, `pos_sales_start`, `web_sales_start`, `main_pos_sales_end`, `pos_sales_end`, `web_sales_end`, `additional_information`, `hall_plan_id`, `booking_purchase_limit_days`, `booking_valid_days`, `comment`, `administrator_id`, `time`, `state`, `name`, `category_id`, `organizer_id`, `archived_at`, `archived_by_id`, `created_at`, `used_at`, `event_id`, `abstract_template_id`, `ticket_field_1`, `ticket_field_2`, `ticket_field_3`, `name2`, `name3`, `short_description`, `name_en`, `name_ru`, `name_fi`, `name2_en`, `name2_ru`, `name2_fi`, `name3_en`, `name3_ru`, `name3_fi`, `short_description_en`, `short_description_ru`, `short_description_fi`, `additional_information_en`, `additional_information_fi`, `additional_information_ru`, `free_form_comments`) VALUES
(46012, 'Performance', '2014-04-16 11:37:57', '2014-04-16 11:37:57', '2014-04-16 11:37:57', -3600, 0, 0, '<!--[if gte mso 9]><xml>  <o:OfficeDocumentSettings>   <o:AllowPNG/>  </o:OfficeDocumentSettings> </xml><![endif]-->  <p style="text-align: justify" class="MsoNormal">Mis saab olla veel kaunim, kui &uuml;ks meelierutav suve&otilde;htu, koos teatri, laulu ja hea tujuga.<br /> Tule teatraalselt elegantsele kontserdile, kus astuvad &uuml;les humoorika kavaga laulvad n&auml;itlejad: Andres Dvinjaninov, Hannes Kaljuj&auml;rv, Indrek Kalda, Toomas Lunge ja J&uuml;ri Lumiste ehk Kaunimate Aastate Vennaskond.</p>  E 14. juuli - Saue, Vanam&otilde;isa Vaba&otilde;hukeskus, kell 20<br /> T 15. juuli - Vihula m&otilde;isa aed, kell 20<br /> K 16. juuli - P&auml;rnu, Ammende Villa aed, kell 20<br /> N 17. juuli - Tallinn, Linnateatri lavaauk, kell 20<br /> <br /> Piletihind eelm&uuml;&uuml;gist: 16 &euro;, 14 &euro; (pension&auml;r)<br /> Tallinna kontserdi piletihind eelm&uuml;&uuml;gist: 17 &euro;, 15 &euro; (pension&auml;rid)<br /> <br /> Lisainfo: <a href="http://www.kontsert.ee/">www.kontsert.ee</a> <br /> <br /> <br /> <!--[if gte mso 9]><xml>  <w:WordDocument>   <w:View>Normal</w:View>   <w:Zoom>0</w:Zoom>   <w:TrackMoves/>   <w:TrackFormatting/>   <w:HyphenationZone>21</w:HyphenationZone>   <w:PunctuationKerning/>   <w:ValidateAgainstSchemas/>   <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>   <w:IgnoreMixedContent>false</w:IgnoreMixedContent>   <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>   <w:DoNotPromoteQF/>   <w:LidThemeOther>ET</w:LidThemeOther>   <w:LidThemeAsian>X-NONE</w:LidThemeAsian>   <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>   <w:Compatibility>    <w:BreakWrappedTables/>    <w:SnapToGridInCell/>    <w:WrapTextWithPunct/>    <w:UseAsianBreakRules/>    <w:DontGrowAutofit/>    <w:SplitPgBreakAndParaMark/>    <w:EnableOpenTypeKerning/>    <w:DontFlipMirrorIndents/>    <w:OverrideTableStyleHps/>   </w:Compatibility>   <m:mathPr>    <m:mathFont m:val="Cambria Math"/>    <m:brkBin m:val="before"/>    <m:brkBinSub m:val="&#45;-"/>    <m:smallFrac m:val="off"/>    <m:dispDef/>    <m:lMargin m:val="0"/>    <m:rMargin m:val="0"/>    <m:defJc m:val="centerGroup"/>    <m:wrapIndent m:val="1440"/>    <m:intLim m:val="subSup"/>    <m:naryLim m:val="undOvr"/>   </m:mathPr></w:WordDocument> </xml><![endif]--><!--[if gte mso 9]><xml>  <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"   DefSemiHidden="true" DefQFormat="false" DefPriority="99"   LatentStyleCount="267">   <w:LsdException Locked="false" Priority="0" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Normal"/>   <w:LsdException Locked="false" Priority="9" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="heading 1"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"/>   <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"/>   <w:LsdException Locked="false" Priority="39" Name="toc 1"/>   <w:LsdException Locked="false" Priority="39" Name="toc 2"/>   <w:LsdException Locked="false" Priority="39" Name="toc 3"/>   <w:LsdException Locked="false" Priority="39" Name="toc 4"/>   <w:LsdException Locked="false" Priority="39" Name="toc 5"/>   <w:LsdException Locked="false" Priority="39" Name="toc 6"/>   <w:LsdException Locked="false" Priority="39" Name="toc 7"/>   <w:LsdException Locked="false" Priority="39" Name="toc 8"/>   <w:LsdException Locked="false" Priority="39" Name="toc 9"/>   <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"/>   <w:LsdException Locked="false" Priority="10" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Title"/>   <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>   <w:LsdException Locked="false" Priority="11" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtitle"/>   <w:LsdException Locked="false" Priority="22" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Strong"/>   <w:LsdException Locked="false" Priority="20" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Emphasis"/>   <w:LsdException Locked="false" Priority="59" SemiHidden="false"    UnhideWhenUsed="false" Name="Table Grid"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"/>   <w:LsdException Locked="false" Priority="1" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="No Spacing"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 1"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 1"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 1"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 1"/>   <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"/>   <w:LsdException Locked="false" Priority="34" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"/>   <w:LsdException Locked="false" Priority="29" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Quote"/>   <w:LsdException Locked="false" Priority="30" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 1"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 1"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 1"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 1"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 1"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 2"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 2"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 2"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 2"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 2"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 2"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 2"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 2"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 2"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 3"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 3"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 3"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 3"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 3"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 3"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 3"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 3"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 3"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 4"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 4"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 4"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 4"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 4"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 4"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 4"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 4"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 4"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 5"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 5"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 5"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 5"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 5"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 5"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 5"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 5"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 5"/>   <w:LsdException Locked="false" Priority="60" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Shading Accent 6"/>   <w:LsdException Locked="false" Priority="61" SemiHidden="false"    UnhideWhenUsed="false" Name="Light List Accent 6"/>   <w:LsdException Locked="false" Priority="62" SemiHidden="false"    UnhideWhenUsed="false" Name="Light Grid Accent 6"/>   <w:LsdException Locked="false" Priority="63" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"/>   <w:LsdException Locked="false" Priority="64" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"/>   <w:LsdException Locked="false" Priority="65" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 1 Accent 6"/>   <w:LsdException Locked="false" Priority="66" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium List 2 Accent 6"/>   <w:LsdException Locked="false" Priority="67" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"/>   <w:LsdException Locked="false" Priority="68" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"/>   <w:LsdException Locked="false" Priority="69" SemiHidden="false"    UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"/>   <w:LsdException Locked="false" Priority="70" SemiHidden="false"    UnhideWhenUsed="false" Name="Dark List Accent 6"/>   <w:LsdException Locked="false" Priority="71" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Shading Accent 6"/>   <w:LsdException Locked="false" Priority="72" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful List Accent 6"/>   <w:LsdException Locked="false" Priority="73" SemiHidden="false"    UnhideWhenUsed="false" Name="Colorful Grid Accent 6"/>   <w:LsdException Locked="false" Priority="19" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"/>   <w:LsdException Locked="false" Priority="21" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"/>   <w:LsdException Locked="false" Priority="31" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"/>   <w:LsdException Locked="false" Priority="32" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"/>   <w:LsdException Locked="false" Priority="33" SemiHidden="false"    UnhideWhenUsed="false" QFormat="true" Name="Book Title"/>   <w:LsdException Locked="false" Priority="37" Name="Bibliography"/>   <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"/>  </w:LatentStyles> </xml><![endif]--><!--[if gte mso 10]> <style>  /* Style Definitions */  table.MsoNormalTable 	{mso-style-name:"Table Normal"; 	mso-tstyle-rowband-size:0; 	mso-tstyle-colband-size:0; 	mso-style-noshow:yes; 	mso-style-priority:99; 	mso-style-parent:""; 	mso-padding-alt:0cm 5.4pt 0cm 5.4pt; 	mso-para-margin:0cm; 	mso-para-margin-bottom:.0001pt; 	mso-pagination:widow-orphan; 	font-size:10.0pt; 	font-family:"Times New Roman","serif";} </style> <![endif]-->', 54685, 10, NULL, '', 1, '2014-07-17 17:00:00', 'on_sale', 'Kaunimate Aastate Vennaskond', 1, 279, '2014-04-16 11:37:57', NULL, '2014-04-14 11:24:16', '2014-04-16 11:37:57', 46008, 9, 'Kohad on nummerdamata', '', '', 'Ãœks, kaks, kolm, neli, mÃ¶Ã¶dus jÃ¤llegi Ã¼ks pÃ¤ev', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

DROP TABLE IF EXISTS `gift_cards`;
CREATE TABLE IF NOT EXISTS `gift_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abstract_template_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `value` decimal(12,5) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `valid_from_purchase_in_months` int(11) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `value_eek` decimal(12,5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_ranges`
--

DROP TABLE IF EXISTS `gift_card_ranges`;
CREATE TABLE IF NOT EXISTS `gift_card_ranges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gift_card_id` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `from` varchar(255) NOT NULL,
  `to` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_transactions`
--

DROP TABLE IF EXISTS `gift_card_transactions`;
CREATE TABLE IF NOT EXISTS `gift_card_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `valid_until` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gift_card_id` int(11) NOT NULL,
  `transaction_line_id` int(11) NOT NULL,
  `price_value` decimal(12,5) NOT NULL,
  `normal_price_value` decimal(12,5) NOT NULL,
  `price_value_eek` decimal(12,5) DEFAULT NULL,
  `normal_price_value_eek` decimal(12,5) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `description` text,
  `role_admin` tinyint(1) NOT NULL DEFAULT '0',
  `role_reporting` tinyint(1) NOT NULL DEFAULT '0',
  `action_booking` tinyint(1) NOT NULL DEFAULT '0',
  `action_booking_cancellation` tinyint(1) NOT NULL DEFAULT '0',
  `action_reservation` tinyint(1) NOT NULL DEFAULT '0',
  `action_reservation_cancellation` tinyint(1) NOT NULL DEFAULT '0',
  `action_waiting_list_administration` tinyint(1) NOT NULL DEFAULT '0',
  `action_refund` tinyint(1) NOT NULL DEFAULT '0',
  `action_reprint` tinyint(1) NOT NULL DEFAULT '0',
  `role_sales` tinyint(1) NOT NULL DEFAULT '0',
  `action_custom_discount` tinyint(1) NOT NULL DEFAULT '0',
  `action_print_without_price` tinyint(1) NOT NULL DEFAULT '0',
  `action_check_tickets` tinyint(1) NOT NULL DEFAULT '0',
  `action_ticket_sales` tinyint(1) NOT NULL DEFAULT '0',
  `action_send_tickets_to_email` tinyint(1) DEFAULT '0',
  `role_organizer` tinyint(1) NOT NULL DEFAULT '0',
  `action_add_performance_comments` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group_memberships`
--

DROP TABLE IF EXISTS `group_memberships`;
CREATE TABLE IF NOT EXISTS `group_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `halls`
--

DROP TABLE IF EXISTS `halls`;
CREATE TABLE IF NOT EXISTS `halls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `venue_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1236 ;

--
-- Dumping data for table `halls`
--

INSERT INTO `halls` (`id`, `name`, `venue_id`) VALUES
(1, 'name', 0),
(2, 'suur saal', 2),
(9, 'suur saal', 7),
(18, 'suur saal', 10),
(68, 'saal', 43),
(141, 'Suur saal', 52),
(205, 'Saal', 132),
(472, 'saal', 351),
(509, 'istekohtadega saal', 330),
(688, 'Kohtadega saal', 133),
(847, 'Saal', 674),
(848, 'saal kohtadega', 91),
(876, 'aed', 696),
(1132, ' lavaauk', 910),
(1232, 'keskus', 989),
(1235, 'aed', 992);

-- --------------------------------------------------------

--
-- Table structure for table `hall_areas`
--

DROP TABLE IF EXISTS `hall_areas`;
CREATE TABLE IF NOT EXISTS `hall_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hall_plan_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `unmarked_seat_count` int(11) NOT NULL DEFAULT '0',
  `price_class_for_unmarked_seats_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hall_elements`
--

DROP TABLE IF EXISTS `hall_elements`;
CREATE TABLE IF NOT EXISTS `hall_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `hall_plan_id` int(11) NOT NULL,
  `screen_id` int(11) DEFAULT NULL,
  `sale_permission_main_pos` tinyint(1) NOT NULL DEFAULT '0',
  `sale_permission_pos` tinyint(1) NOT NULL DEFAULT '0',
  `sale_permission_web` tinyint(1) NOT NULL DEFAULT '0',
  `hall_area_id` int(11) DEFAULT NULL,
  `price_class_id` int(11) DEFAULT NULL,
  `row` varchar(10) DEFAULT NULL,
  `column` varchar(10) DEFAULT NULL,
  `coordinate_x` int(11) DEFAULT NULL,
  `coordinate_y` int(11) DEFAULT NULL,
  `comment` text,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` int(11) DEFAULT NULL,
  `default_transaction` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hall_plans`
--

DROP TABLE IF EXISTS `hall_plans`;
CREATE TABLE IF NOT EXISTS `hall_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `hall_id` int(11) NOT NULL,
  `template_hall_plan_id` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=54686 ;

--
-- Dumping data for table `hall_plans`
--

INSERT INTO `hall_plans` (`id`, `name`, `hall_id`, `template_hall_plan_id`, `updated_at`, `archived_at`, `archived_by_id`) VALUES
(1, 'name', 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0),
(26856, 'tavaasetus', 18, 77, '2011-01-26 08:08:29', '2014-04-16 11:50:36', NULL),
(26857, 'tavaasetus', 18, 77, '2011-01-26 08:09:13', '2014-04-16 11:50:36', NULL),
(26859, 'suur saal', 141, 1847, '2011-02-28 10:10:49', '2014-04-16 11:50:36', NULL),
(26862, 'suur saal', 2, 18, '2011-02-28 10:06:41', '2014-04-16 11:50:36', NULL),
(26935, 'Saal pÃµrand ja rÃµdu', 9, 212, '2011-03-14 12:11:27', '2014-04-16 11:50:36', NULL),
(26936, 'Saal pÃµrand ja rÃµdu', 509, 10368, '2011-01-31 09:32:52', '2014-04-16 11:50:36', NULL),
(26937, 'Saal kohtadega', 472, 24311, '2011-01-31 09:32:38', '2014-04-16 11:50:36', NULL),
(26940, 'Teatrisaal', 688, 17879, '2011-01-31 09:32:23', '2014-04-16 11:50:36', NULL),
(26960, 'Saal', 847, 26959, '2011-01-31 09:33:25', '2014-04-16 11:50:36', NULL),
(26962, 'PÃµrand', 205, 2916, '2011-01-31 09:29:34', '2014-04-16 11:50:36', NULL),
(26963, 'Saal', 848, 26961, '2011-01-31 09:39:41', '2014-04-16 11:50:36', NULL),
(27252, 'Saal', 68, 476, '2011-02-22 13:09:44', '2014-04-16 11:50:36', NULL),
(54677, 'keskus', 1232, 54660, '2014-04-14 11:23:25', '2014-04-16 11:50:36', NULL),
(54678, 'keskus', 1232, 54660, '2014-04-14 11:24:50', '2014-04-16 11:50:36', NULL),
(54682, 'aed', 1235, 54663, '2014-04-14 11:25:24', '2014-04-16 11:50:36', NULL),
(54684, 'aed', 876, 28246, '2014-04-14 11:25:58', '2014-04-16 11:50:36', NULL),
(54685, 'lavaauk', 1132, 45780, '2014-04-14 11:26:34', '2014-04-16 11:50:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hall_plan_change_permissions`
--

DROP TABLE IF EXISTS `hall_plan_change_permissions`;
CREATE TABLE IF NOT EXISTS `hall_plan_change_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hall_plan_id` int(11) NOT NULL,
  `administrator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hall_usage_permissions`
--

DROP TABLE IF EXISTS `hall_usage_permissions`;
CREATE TABLE IF NOT EXISTS `hall_usage_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hall_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `invalid_seats`
--

DROP TABLE IF EXISTS `invalid_seats`;
CREATE TABLE IF NOT EXISTS `invalid_seats` (
  `administrator_id` int(11) DEFAULT NULL,
  `sch_event_id` int(11) DEFAULT NULL,
  `invalid_seats` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `net_sale_logs`
--

DROP TABLE IF EXISTS `net_sale_logs`;
CREATE TABLE IF NOT EXISTS `net_sale_logs` (
  `id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `payer_name` varchar(255) DEFAULT NULL,
  `bank_id` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `payment_date` varchar(255) NOT NULL,
  `payer_account` varchar(255) DEFAULT NULL,
  `bank_request` text NOT NULL,
  `net_sale_info` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `net_sale_payment_attempts`
--

DROP TABLE IF EXISTS `net_sale_payment_attempts`;
CREATE TABLE IF NOT EXISTS `net_sale_payment_attempts` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `giftcard_ids` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `newsarticle_containers`
--

DROP TABLE IF EXISTS `newsarticle_containers`;
CREATE TABLE IF NOT EXISTS `newsarticle_containers` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_sections`
--

DROP TABLE IF EXISTS `newsletter_sections`;
CREATE TABLE IF NOT EXISTS `newsletter_sections` (
  `id` int(11) NOT NULL,
  `newsletter_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `layout_type` varchar(255) DEFAULT NULL,
  `buy_link_url` varchar(255) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscriptions`
--

DROP TABLE IF EXISTS `newsletter_subscriptions`;
CREATE TABLE IF NOT EXISTS `newsletter_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `confirmation_key_salt` varchar(10) NOT NULL,
  `confirmation_key` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
CREATE TABLE IF NOT EXISTS `partners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `business_type` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `address_info` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `contact_name` varchar(50) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `contact_notes` varchar(255) DEFAULT NULL,
  `is_administrator` tinyint(1) NOT NULL DEFAULT '0',
  `is_organizer` tinyint(1) NOT NULL DEFAULT '0',
  `is_reseller` tinyint(1) NOT NULL DEFAULT '0',
  `booking_purchase_limit_days` int(11) DEFAULT NULL,
  `booking_valid_days` int(11) DEFAULT NULL,
  `archived_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=280 ;

--
-- Dumping data for table `partners`
--

INSERT INTO `partners` (`id`, `name`, `business_type`, `code`, `address`, `address_info`, `city`, `contact_name`, `contact_phone`, `contact_email`, `contact_notes`, `is_administrator`, `is_organizer`, `is_reseller`, `booking_purchase_limit_days`, `booking_valid_days`, `archived_at`, `archived_by_id`, `created_at`, `updated_at`, `updated_by_id`) VALUES
(1, 'name', 0, 'code', 'address', 'address_info', 'city', 'contact_name', 'contact_phone', 'contact_email', 'contact_notes', 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0),
(8, 'Eesti Kontsert', 10, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, '2014-04-16 12:17:47', NULL, '2007-10-27 20:59:43', '2007-10-27 20:59:43', 2),
(9, 'Eesti Kontsert Vanemuise Kontserdimaja', 10, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, '2014-04-16 12:17:47', NULL, '2007-10-27 21:00:09', '2007-10-27 21:04:34', 2),
(10, 'Eesti Kontsert Pärnu Kontserdimaja', 10, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, '2014-04-16 12:17:47', NULL, '2007-10-27 21:00:26', '2007-10-27 21:04:45', 2),
(16, 'Paide Kultuurikeskus', 9, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, '2014-04-16 12:17:47', NULL, '2007-10-27 23:55:29', '2007-10-27 23:55:29', 2),
(17, 'name', 0, 'code', 'address', 'address_info', 'city', 'contact_name', 'contact_phone', 'contact_email', 'contact_notes', 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0),
(144, 'MTÜ Tartu Suveteatri Selts', 4, '', NULL, NULL, NULL, 'Juta Kuhlberg', '5062545', 'juta@kodu.ee', NULL, 0, 1, 1, NULL, NULL, '2014-04-16 12:42:59', NULL, '2008-01-22 10:13:06', '2013-06-14 08:00:16', 35),
(279, 'Sole', 4, '', 'Laulupeo pst. 25', NULL, 'Tartu', 'Lauri Land', '7422655', 'lauriland@hotmail.com', NULL, 0, 1, 0, NULL, NULL, '2014-04-16 12:41:09', NULL, '2008-09-02 17:38:02', '2008-09-02 17:38:02', 5);

-- --------------------------------------------------------

--
-- Table structure for table `partner_notices`
--

DROP TABLE IF EXISTS `partner_notices`;
CREATE TABLE IF NOT EXISTS `partner_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payable_id` int(11) NOT NULL,
  `payable_type` varchar(255) NOT NULL,
  `sale_discount` decimal(12,5) NOT NULL DEFAULT '0.00000',
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sale_discount_eek` decimal(12,5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE IF NOT EXISTS `payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `paid_sum` decimal(12,5) DEFAULT NULL,
  `comment` text,
  `payment_id` int(11) NOT NULL,
  `gift_card_transaction_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gift_card_transaction_number` varchar(50) DEFAULT NULL,
  `issuing_partner_id` int(11) DEFAULT NULL,
  `paid_sum_eek` decimal(12,5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `performance_sales_comments`
--

DROP TABLE IF EXISTS `performance_sales_comments`;
CREATE TABLE IF NOT EXISTS `performance_sales_comments` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `comment` text,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
CREATE TABLE IF NOT EXISTS `pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_type` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `db_file_id` int(11) DEFAULT NULL,
  `pictureable_id` int(11) DEFAULT NULL,
  `pictureable_type` varchar(50) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
CREATE TABLE IF NOT EXISTS `prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(8,2) NOT NULL,
  `price_model_id` int(11) NOT NULL,
  `price_class_id` int(11) NOT NULL,
  `price_schema_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `price_classes`
--

DROP TABLE IF EXISTS `price_classes`;
CREATE TABLE IF NOT EXISTS `price_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `color` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `abstract_template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `price_models`
--

DROP TABLE IF EXISTS `price_models`;
CREATE TABLE IF NOT EXISTS `price_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `ticket_count_for_validity` int(11) DEFAULT NULL,
  `free_tickets_count` int(11) DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `valid_for_web_sales` tinyint(1) DEFAULT NULL,
  `valid_in_all_pos` tinyint(1) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `price_schemas`
--

DROP TABLE IF EXISTS `price_schemas`;
CREATE TABLE IF NOT EXISTS `price_schemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `event_id` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `printouts`
--

DROP TABLE IF EXISTS `printouts`;
CREATE TABLE IF NOT EXISTS `printouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `printable_id` int(11) NOT NULL,
  `printable_type` varchar(50) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `succeeded` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE IF NOT EXISTS `schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
CREATE TABLE IF NOT EXISTS `screens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `menu_position` int(11) DEFAULT NULL,
  `hall_plan_id` int(11) NOT NULL,
  `row_markers` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `seat_transactions`
--

DROP TABLE IF EXISTS `seat_transactions`;
CREATE TABLE IF NOT EXISTS `seat_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `transaction_line_id` int(11) DEFAULT NULL,
  `seat_id` int(11) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) DEFAULT NULL,
  `data` text,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
CREATE TABLE IF NOT EXISTS `stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `reseller_id` int(11) NOT NULL,
  `internal_name` varchar(20) DEFAULT NULL,
  `archived_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
CREATE TABLE IF NOT EXISTS `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_line_id` int(11) NOT NULL,
  `abstract_template_id` int(11) NOT NULL,
  `state` varchar(255) NOT NULL,
  `serial_number` varchar(30) DEFAULT NULL,
  `price_value` decimal(12,5) NOT NULL,
  `normal_price_value` decimal(12,5) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ticket_group_id` int(11) DEFAULT NULL,
  `web_serial_number` varchar(30) DEFAULT NULL,
  `has_been_swapped` tinyint(1) DEFAULT '0',
  `checked_by_id` int(11) DEFAULT NULL,
  `checked_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `has_been_sent_by_email` tinyint(1) DEFAULT '0',
  `swapped_by_id` int(11) DEFAULT NULL,
  `swapped_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `swapped_in_store_id` int(11) DEFAULT NULL,
  `price_value_eek` decimal(12,5) DEFAULT NULL,
  `normal_price_value_eek` decimal(12,5) DEFAULT '0.00000',
  `price_model_class` varchar(50) DEFAULT NULL,
  `price_model_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_fields`
--

DROP TABLE IF EXISTS `ticket_fields`;
CREATE TABLE IF NOT EXISTS `ticket_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `abstract_template_id` int(11) NOT NULL,
  `coordinate_x` int(11) NOT NULL,
  `coordinate_y` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) DEFAULT NULL,
  `rotation` int(11) NOT NULL DEFAULT '0',
  `font` varchar(100) DEFAULT NULL,
  `font_size` int(11) DEFAULT NULL,
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_underlined` tinyint(1) NOT NULL DEFAULT '0',
  `currency` varchar(3) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `can_wrap` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_groups`
--

DROP TABLE IF EXISTS `ticket_groups`;
CREATE TABLE IF NOT EXISTS `ticket_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_line_id` int(11) NOT NULL,
  `price_model_description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `parent_id` int(11) DEFAULT NULL,
  `campaign_code_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_medias`
--

DROP TABLE IF EXISTS `ticket_medias`;
CREATE TABLE IF NOT EXISTS `ticket_medias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(255) DEFAULT NULL,
  `redemption_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `use_booking_time_price` tinyint(1) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `transaction_fee` decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_lines`
--

DROP TABLE IF EXISTS `transaction_lines`;
CREATE TABLE IF NOT EXISTS `transaction_lines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `performance_id` int(11) DEFAULT NULL,
  `refundable_id` int(11) DEFAULT NULL,
  `refundable_type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gift_card_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `deleted`) VALUES
(1, 'demo', 'demo', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password_hash` varchar(40) NOT NULL,
  `salt` varchar(10) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `super_admin` tinyint(1) NOT NULL DEFAULT '0',
  `cart_transaction_opened_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `lock_version` int(11) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `partner_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  `active_transaction_id` int(11) DEFAULT NULL,
  `previous_sale_id` int(11) DEFAULT NULL,
  `archived_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=795 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `salt`, `first_name`, `last_name`, `email`, `super_admin`, `cart_transaction_opened_at`, `active`, `phone`, `notes`, `lock_version`, `created_at`, `updated_at`, `partner_id`, `store_id`, `active_transaction_id`, `previous_sale_id`, `archived_at`, `archived_by_id`) VALUES
(794, 'migratsioon_13', 'd2bedcb32d51bea796d3939ff45471c8a200d410', '1hscjwfnfc', 'migratsiooni', 'müüja', 'info@itech.ee', 0, '2014-04-16 12:34:36', 0, NULL, NULL, 0, '2008-01-02 17:24:43', '2008-01-02 17:24:43', 13, 709, NULL, NULL, '2014-04-16 12:34:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

DROP TABLE IF EXISTS `venues`;
CREATE TABLE IF NOT EXISTS `venues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `organizer_id` int(11) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `address_info` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `archived_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=993 ;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `name`, `organizer_id`, `address`, `address_info`, `city`, `archived_at`, `archived_by_id`) VALUES
(1, 'name', NULL, 'address', 'address_info', 'city', '2014-04-16 12:24:17', NULL),
(2, 'Vanemuise Kontserdimaja', 9, 'Vanemuise 6, Tartu', NULL, 'Tartu', '2014-04-16 12:06:03', NULL),
(7, 'Paide Kultuurikeskus', 16, 'Pärnu 18', NULL, NULL, '2014-04-16 12:06:03', NULL),
(10, 'Estonia kontserdisaal', 8, 'Estonia pst. 4', '10148', 'Tallinn', '2014-04-16 12:06:03', NULL),
(43, 'Salme Kultuurikeskus, Tallinn', NULL, 'Salme tn. 12', NULL, 'Tallinn', '2014-04-16 12:06:03', NULL),
(52, 'Pärnu Kontserdimaja', 10, 'Aida 4,  80011 Pärnu', NULL, 'Pärnu', '2014-04-16 12:06:03', NULL),
(91, 'Keila Kultuurikeskus', NULL, 'Keskväljak 12', '', 'Keila', '2014-04-16 12:06:03', NULL),
(132, 'Rakvere Rahvamaja', NULL, NULL, NULL, 'Rakvere', '2014-04-16 12:06:03', NULL),
(133, 'Võru Kultuurimaja Kannel', NULL, NULL, NULL, 'Võru', '2014-04-16 12:06:03', NULL),
(330, 'Viljandi Pärimusmuusika Ait', NULL, 'Tasuja pst.6', 'folk@folk.ee', 'Viljandi', '2014-04-16 12:06:03', NULL),
(351, 'Valga Kultuuri- ja Huvialakeskus', NULL, 'Kesk 1, Valga', '68203', 'Valga', '2014-04-16 12:06:03', NULL),
(674, 'Otepää kultuurikeskus', NULL, NULL, NULL, NULL, '2014-04-16 12:06:03', NULL),
(696, 'Pärnu Ammende Villa aed', NULL, NULL, NULL, NULL, '2014-04-16 12:06:03', NULL),
(910, 'Tallinna Linnateatri lavaauk', NULL, NULL, NULL, NULL, '2014-04-16 12:06:03', NULL),
(989, 'Saue, Vanamõisa Vabaõhukeskus', NULL, NULL, NULL, NULL, '2014-04-16 12:06:03', NULL),
(992, 'Vihula mõisa aed', NULL, NULL, NULL, NULL, '2014-04-16 12:06:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `waiting_lists`
--

DROP TABLE IF EXISTS `waiting_lists`;
CREATE TABLE IF NOT EXISTS `waiting_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `performance_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `web_documents`
--

DROP TABLE IF EXISTS `web_documents`;
CREATE TABLE IF NOT EXISTS `web_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `description` text,
  `content` text,
  `language` varchar(2) NOT NULL,
  `title` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `author_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `layout_type` varchar(255) DEFAULT NULL,
  `newsarticle_container_id` int(11) DEFAULT NULL,
  `image_link_url` varchar(255) DEFAULT NULL,
  `active_ad` tinyint(1) NOT NULL DEFAULT '0',
  `youtube_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `web_organizer_menus`
--

DROP TABLE IF EXISTS `web_organizer_menus`;
CREATE TABLE IF NOT EXISTS `web_organizer_menus` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `position` int(11) NOT NULL,
  `organizer_id` int(11) DEFAULT NULL,
  `parent_menu_id` int(11) DEFAULT NULL,
  `is_level_2` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title_en` text,
  `title_fi` text,
  `title_ru` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
SET FOREIGN_KEY_CHECKS=1;
