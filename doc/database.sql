-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Loomise aeg: Aprill 16, 2014 kell 01:20 PL
-- Serveri versioon: 5.6.16
-- PHP versioon: 5.5.9

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Andmebaas: `pm`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `abstract_templates`
--

DROP TABLE IF EXISTS `abstract_templates`;
CREATE TABLE IF NOT EXISTS `abstract_templates` (
  `id`                   INT(11)     NOT NULL AUTO_INCREMENT,
  `active`               TINYINT(1)  NOT NULL DEFAULT '0',
  `name`                 VARCHAR(50) NOT NULL,
  `type`                 VARCHAR(50) NOT NULL,
  `ticket_media_id`      INT(11)     NOT NULL,
  `user_id`              INT(11)     NOT NULL,
  `allowed_for_everyone` TINYINT(1)  NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `bank_messages`
--

DROP TABLE IF EXISTS `bank_messages`;
CREATE TABLE IF NOT EXISTS `bank_messages` (
  `id`  INT(11) NOT NULL AUTO_INCREMENT,
  `msg` TEXT    NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE IF NOT EXISTS `campaigns` (
  `id`                           INT(11)      NOT NULL,
  `title`                        VARCHAR(255) NOT NULL,
  `state`                        VARCHAR(20) DEFAULT 'being_created',
  `allow_multiple_uses_of_codes` TINYINT(1) DEFAULT '0',
  `start_date`                   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date`                     TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at`                   TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at`                   TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `max_allowed_tickets`          INT(11) DEFAULT NULL,
  `partner_id`                   INT(11)      NOT NULL,
  `description`                  TEXT
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `campaign_codes`
--

DROP TABLE IF EXISTS `campaign_codes`;
CREATE TABLE IF NOT EXISTS `campaign_codes` (
  `id`          INT(11)      NOT NULL,
  `code_value`  VARCHAR(255) NOT NULL,
  `used`        TINYINT(1)   NOT NULL DEFAULT '0',
  `use_date`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `campaign_id` INT(11) DEFAULT NULL,
  `created_at`  TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at`  TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id`      INT(11)     NOT NULL AUTO_INCREMENT,
  `name_et` VARCHAR(50) NOT NULL,
  `name_en` VARCHAR(50) NOT NULL,
  `name_ru` VARCHAR(50) NOT NULL,
  `name_fi` TEXT,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id`                     INT(11)     NOT NULL AUTO_INCREMENT,
  `type`                   VARCHAR(50) NOT NULL,
  `first_name`             VARCHAR(50) NOT NULL,
  `last_name`              VARCHAR(50) NOT NULL,
  `code`                   VARCHAR(100) DEFAULT NULL,
  `phone`                  VARCHAR(30) DEFAULT NULL,
  `email`                  VARCHAR(100) DEFAULT NULL,
  `birthdate`              TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sending_emails_allowed` TINYINT(1)  NOT NULL DEFAULT '0',
  `notes`                  VARCHAR(255) DEFAULT NULL,
  `business_type`          INT(11) DEFAULT NULL,
  `business_name`          VARCHAR(100) DEFAULT NULL,
  `address`                VARCHAR(200) DEFAULT NULL,
  `archived_at`            TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id`         INT(11) DEFAULT NULL,
  `password_hash`          VARCHAR(255) DEFAULT NULL,
  `salt`                   VARCHAR(255) DEFAULT NULL,
  `registered`             TINYINT(1) DEFAULT NULL,
  `reset_password_token`   VARCHAR(255) DEFAULT NULL,
  `confirmation_token`     TEXT,
  `confirmed_at`           TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `session_key`            VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `client_marketing_subscriptions`
--

DROP TABLE IF EXISTS `client_marketing_subscriptions`;
CREATE TABLE IF NOT EXISTS `client_marketing_subscriptions` (
  `id`               INT(11)   NOT NULL AUTO_INCREMENT,
  `client_id`        INT(11)   NOT NULL,
  `administrator_id` INT(11)   NOT NULL,
  `created_at`       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`       TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `db_files`
--

DROP TABLE IF EXISTS `db_files`;
CREATE TABLE IF NOT EXISTS `db_files` (
  `id`   INT(11) NOT NULL AUTO_INCREMENT,
  `data` BLOB,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id`                          INT(11)      NOT NULL AUTO_INCREMENT,
  `type`                        VARCHAR(50)  NOT NULL,
  `main_pos_sales_start`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pos_sales_start`             TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `web_sales_start`             TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `main_pos_sales_end`          INT(11)      NOT NULL DEFAULT '-3600',
  `pos_sales_end`               INT(11)      NOT NULL DEFAULT '0',
  `web_sales_end`               INT(11)      NOT NULL DEFAULT '0',
  `additional_information`      TEXT,
  `hall_plan_id`                INT(11) DEFAULT NULL,
  `booking_purchase_limit_days` INT(11) DEFAULT NULL,
  `booking_valid_days`          INT(11) DEFAULT NULL,
  `comment`                     TEXT,
  `administrator_id`            INT(11) DEFAULT NULL,
  `time`                        TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state`                       VARCHAR(20) DEFAULT 'being_created',
  `name`                        VARCHAR(255) NOT NULL,
  `category_id`                 INT(11) DEFAULT NULL,
  `organizer_id`                INT(11) DEFAULT NULL,
  `archived_at`                 TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id`              INT(11) DEFAULT NULL,
  `created_at`                  TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `used_at`                     TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `event_id`                    INT(11) DEFAULT NULL,
  `abstract_template_id`        INT(11) DEFAULT NULL,
  `ticket_field_1`              VARCHAR(255) DEFAULT NULL,
  `ticket_field_2`              VARCHAR(255) DEFAULT NULL,
  `ticket_field_3`              VARCHAR(255) DEFAULT NULL,
  `name2`                       VARCHAR(255) DEFAULT NULL,
  `name3`                       VARCHAR(255) DEFAULT NULL,
  `short_description`           VARCHAR(255) DEFAULT NULL,
  `name_en`                     TEXT,
  `name_ru`                     TEXT,
  `name_fi`                     TEXT,
  `name2_en`                    TEXT,
  `name2_ru`                    TEXT,
  `name2_fi`                    TEXT,
  `name3_en`                    TEXT,
  `name3_ru`                    TEXT,
  `name3_fi`                    TEXT,
  `short_description_en`        TEXT,
  `short_description_ru`        TEXT,
  `short_description_fi`        TEXT,
  `additional_information_en`   TEXT,
  `additional_information_fi`   TEXT,
  `additional_information_ru`   TEXT,
  `free_form_comments`          TEXT,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `gift_cards`
--

DROP TABLE IF EXISTS `gift_cards`;
CREATE TABLE IF NOT EXISTS `gift_cards` (
  `id`                            INT(11)      NOT NULL AUTO_INCREMENT,
  `abstract_template_id`          INT(11) DEFAULT NULL,
  `name`                          VARCHAR(100) NOT NULL,
  `value`                         DECIMAL(12, 5) DEFAULT NULL,
  `active`                        TINYINT(1)   NOT NULL DEFAULT '0',
  `valid_from_purchase_in_months` INT(11) DEFAULT NULL,
  `type`                          VARCHAR(50)  NOT NULL,
  `partner_id`                    INT(11)      NOT NULL,
  `value_eek`                     DECIMAL(12, 5) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `gift_card_ranges`
--

DROP TABLE IF EXISTS `gift_card_ranges`;
CREATE TABLE IF NOT EXISTS `gift_card_ranges` (
  `id`           INT(11)      NOT NULL AUTO_INCREMENT,
  `gift_card_id` INT(11)      NOT NULL,
  `prefix`       VARCHAR(50) DEFAULT NULL,
  `from`         VARCHAR(255) NOT NULL,
  `to`           VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `gift_card_transactions`
--

DROP TABLE IF EXISTS `gift_card_transactions`;
CREATE TABLE IF NOT EXISTS `gift_card_transactions` (
  `id`                     INT(11)        NOT NULL AUTO_INCREMENT,
  `number`                 VARCHAR(50)    NOT NULL,
  `valid_until`            TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gift_card_id`           INT(11)        NOT NULL,
  `transaction_line_id`    INT(11)        NOT NULL,
  `price_value`            DECIMAL(12, 5) NOT NULL,
  `normal_price_value`     DECIMAL(12, 5) NOT NULL,
  `price_value_eek`        DECIMAL(12, 5) DEFAULT NULL,
  `normal_price_value_eek` DECIMAL(12, 5) DEFAULT NULL,
  `state`                  VARCHAR(255) DEFAULT NULL,
  `created_at`             TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at`             TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id`                                 INT(11)     NOT NULL AUTO_INCREMENT,
  `name`                               VARCHAR(50) NOT NULL,
  `partner_id`                         INT(11)     NOT NULL,
  `description`                        TEXT,
  `role_admin`                         TINYINT(1)  NOT NULL DEFAULT '0',
  `role_reporting`                     TINYINT(1)  NOT NULL DEFAULT '0',
  `action_booking`                     TINYINT(1)  NOT NULL DEFAULT '0',
  `action_booking_cancellation`        TINYINT(1)  NOT NULL DEFAULT '0',
  `action_reservation`                 TINYINT(1)  NOT NULL DEFAULT '0',
  `action_reservation_cancellation`    TINYINT(1)  NOT NULL DEFAULT '0',
  `action_waiting_list_administration` TINYINT(1)  NOT NULL DEFAULT '0',
  `action_refund`                      TINYINT(1)  NOT NULL DEFAULT '0',
  `action_reprint`                     TINYINT(1)  NOT NULL DEFAULT '0',
  `role_sales`                         TINYINT(1)  NOT NULL DEFAULT '0',
  `action_custom_discount`             TINYINT(1)  NOT NULL DEFAULT '0',
  `action_print_without_price`         TINYINT(1)  NOT NULL DEFAULT '0',
  `action_check_tickets`               TINYINT(1)  NOT NULL DEFAULT '0',
  `action_ticket_sales`                TINYINT(1)  NOT NULL DEFAULT '0',
  `action_send_tickets_to_email`       TINYINT(1) DEFAULT '0',
  `role_organizer`                     TINYINT(1)  NOT NULL DEFAULT '0',
  `action_add_performance_comments`    TINYINT(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `group_memberships`
--

DROP TABLE IF EXISTS `group_memberships`;
CREATE TABLE IF NOT EXISTS `group_memberships` (
  `id`       INT(11) NOT NULL AUTO_INCREMENT,
  `group_id` INT(11) NOT NULL,
  `user_id`  INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `halls`
--

DROP TABLE IF EXISTS `halls`;
CREATE TABLE IF NOT EXISTS `halls` (
  `id`       INT(11)     NOT NULL AUTO_INCREMENT,
  `name`     VARCHAR(50) NOT NULL,
  `venue_id` INT(11)     NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hall_areas`
--

DROP TABLE IF EXISTS `hall_areas`;
CREATE TABLE IF NOT EXISTS `hall_areas` (
  `id`                                INT(11)     NOT NULL AUTO_INCREMENT,
  `hall_plan_id`                      INT(11)     NOT NULL,
  `name`                              VARCHAR(50) NOT NULL,
  `unmarked_seat_count`               INT(11)     NOT NULL DEFAULT '0',
  `price_class_for_unmarked_seats_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hall_elements`
--

DROP TABLE IF EXISTS `hall_elements`;
CREATE TABLE IF NOT EXISTS `hall_elements` (
  `id`                       INT(11)     NOT NULL AUTO_INCREMENT,
  `type`                     VARCHAR(50) NOT NULL,
  `hall_plan_id`             INT(11)     NOT NULL,
  `screen_id`                INT(11) DEFAULT NULL,
  `sale_permission_main_pos` TINYINT(1)  NOT NULL DEFAULT '0',
  `sale_permission_pos`      TINYINT(1)  NOT NULL DEFAULT '0',
  `sale_permission_web`      TINYINT(1)  NOT NULL DEFAULT '0',
  `hall_area_id`             INT(11) DEFAULT NULL,
  `price_class_id`           INT(11) DEFAULT NULL,
  `row`                      VARCHAR(10) DEFAULT NULL,
  `column`                   VARCHAR(10) DEFAULT NULL,
  `coordinate_x`             INT(11) DEFAULT NULL,
  `coordinate_y`             INT(11) DEFAULT NULL,
  `comment`                  TEXT,
  `updated_at`               TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id`                INT(11) DEFAULT NULL,
  `default_transaction`      VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hall_plans`
--

DROP TABLE IF EXISTS `hall_plans`;
CREATE TABLE IF NOT EXISTS `hall_plans` (
  `id`                    INT(11)   NOT NULL AUTO_INCREMENT,
  `name`                  VARCHAR(50) DEFAULT NULL,
  `hall_id`               INT(11)   NOT NULL,
  `template_hall_plan_id` INT(11) DEFAULT NULL,
  `updated_at`            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_at`           TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id`        INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hall_plan_change_permissions`
--

DROP TABLE IF EXISTS `hall_plan_change_permissions`;
CREATE TABLE IF NOT EXISTS `hall_plan_change_permissions` (
  `id`               INT(11) NOT NULL AUTO_INCREMENT,
  `hall_plan_id`     INT(11) NOT NULL,
  `administrator_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hall_usage_permissions`
--

DROP TABLE IF EXISTS `hall_usage_permissions`;
CREATE TABLE IF NOT EXISTS `hall_usage_permissions` (
  `id`       INT(11) NOT NULL AUTO_INCREMENT,
  `hall_id`  INT(11) NOT NULL,
  `event_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `invalid_seats`
--

DROP TABLE IF EXISTS `invalid_seats`;
CREATE TABLE IF NOT EXISTS `invalid_seats` (
  `administrator_id` INT(11) DEFAULT NULL,
  `sch_event_id`     INT(11) DEFAULT NULL,
  `invalid_seats`    BIGINT(20) DEFAULT NULL
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `net_sale_logs`
--

DROP TABLE IF EXISTS `net_sale_logs`;
CREATE TABLE IF NOT EXISTS `net_sale_logs` (
  `id`            INT(11)      NOT NULL,
  `order`         INT(11)      NOT NULL,
  `payer_name`    VARCHAR(255) DEFAULT NULL,
  `bank_id`       VARCHAR(255) NOT NULL,
  `amount`        VARCHAR(255) NOT NULL,
  `payment_date`  VARCHAR(255) NOT NULL,
  `payer_account` VARCHAR(255) DEFAULT NULL,
  `bank_request`  TEXT         NOT NULL,
  `net_sale_info` TEXT         NOT NULL,
  `created_at`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00'
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `net_sale_payment_attempts`
--

DROP TABLE IF EXISTS `net_sale_payment_attempts`;
CREATE TABLE IF NOT EXISTS `net_sale_payment_attempts` (
  `id`             INT(11)   NOT NULL,
  `transaction_id` INT(11)   NOT NULL,
  `created_at`     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`     TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `giftcard_ids`   TEXT
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `newsarticle_containers`
--

DROP TABLE IF EXISTS `newsarticle_containers`;
CREATE TABLE IF NOT EXISTS `newsarticle_containers` (
  `id`         INT(11)   NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00'
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id`         INT(11)     NOT NULL AUTO_INCREMENT,
  `title`      VARCHAR(50) NOT NULL,
  `sent_at`    TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `newsletter_sections`
--

DROP TABLE IF EXISTS `newsletter_sections`;
CREATE TABLE IF NOT EXISTS `newsletter_sections` (
  `id`            INT(11)   NOT NULL,
  `newsletter_id` INT(11) DEFAULT NULL,
  `title`         VARCHAR(255) DEFAULT NULL,
  `content`       TEXT,
  `layout_type`   VARCHAR(255) DEFAULT NULL,
  `buy_link_url`  VARCHAR(255) DEFAULT NULL,
  `author_id`     INT(11) DEFAULT NULL,
  `created_at`    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00'
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `newsletter_subscriptions`
--

DROP TABLE IF EXISTS `newsletter_subscriptions`;
CREATE TABLE IF NOT EXISTS `newsletter_subscriptions` (
  `id`                    INT(11)      NOT NULL AUTO_INCREMENT,
  `email`                 VARCHAR(100) NOT NULL,
  `active`                TINYINT(1)   NOT NULL,
  `confirmation_key_salt` VARCHAR(10)  NOT NULL,
  `confirmation_key`      VARCHAR(40)  NOT NULL,
  `created_at`            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`            TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `partners`
--

DROP TABLE IF EXISTS `partners`;
CREATE TABLE IF NOT EXISTS `partners` (
  `id`                          INT(11)     NOT NULL AUTO_INCREMENT,
  `name`                        VARCHAR(50) NOT NULL,
  `business_type`               INT(11) DEFAULT NULL,
  `code`                        VARCHAR(50) DEFAULT NULL,
  `address`                     VARCHAR(200) DEFAULT NULL,
  `address_info`                VARCHAR(200) DEFAULT NULL,
  `city`                        VARCHAR(50) DEFAULT NULL,
  `contact_name`                VARCHAR(50) DEFAULT NULL,
  `contact_phone`               VARCHAR(30) DEFAULT NULL,
  `contact_email`               VARCHAR(100) DEFAULT NULL,
  `contact_notes`               VARCHAR(255) DEFAULT NULL,
  `is_administrator`            TINYINT(1)  NOT NULL DEFAULT '0',
  `is_organizer`                TINYINT(1)  NOT NULL DEFAULT '0',
  `is_reseller`                 TINYINT(1)  NOT NULL DEFAULT '0',
  `booking_purchase_limit_days` INT(11) DEFAULT NULL,
  `booking_valid_days`          INT(11) DEFAULT NULL,
  `archived_at`                 TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_by_id`              INT(11) DEFAULT NULL,
  `created_at`                  TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at`                  TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id`               INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `partner_notices`
--

DROP TABLE IF EXISTS `partner_notices`;
CREATE TABLE IF NOT EXISTS `partner_notices` (
  `id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `title`         VARCHAR(200) NOT NULL,
  `content`       TEXT,
  `active`        TINYINT(1)   NOT NULL DEFAULT '1',
  `created_at`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id`                INT(11)        NOT NULL AUTO_INCREMENT,
  `payable_id`        INT(11)        NOT NULL,
  `payable_type`      VARCHAR(255)   NOT NULL,
  `sale_discount`     DECIMAL(12, 5) NOT NULL DEFAULT '0.00000',
  `complete`          TINYINT(1)     NOT NULL DEFAULT '0',
  `created_at`        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`        TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sale_discount_eek` DECIMAL(12, 5) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE IF NOT EXISTS `payment_methods` (
  `id`                           INT(11)     NOT NULL AUTO_INCREMENT,
  `type`                         VARCHAR(50) NOT NULL,
  `paid_sum`                     DECIMAL(12, 5) DEFAULT NULL,
  `comment`                      TEXT,
  `payment_id`                   INT(11)     NOT NULL,
  `gift_card_transaction_id`     INT(11) DEFAULT NULL,
  `created_at`                   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`                   TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gift_card_transaction_number` VARCHAR(50) DEFAULT NULL,
  `issuing_partner_id`           INT(11) DEFAULT NULL,
  `paid_sum_eek`                 DECIMAL(12, 5) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `performance_sales_comments`
--

DROP TABLE IF EXISTS `performance_sales_comments`;
CREATE TABLE IF NOT EXISTS `performance_sales_comments` (
  `id`         INT(11)   NOT NULL,
  `event_id`   INT(11)   NOT NULL,
  `comment`    TEXT,
  `user_id`    INT(11) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00'
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `pictures`
--

DROP TABLE IF EXISTS `pictures`;
CREATE TABLE IF NOT EXISTS `pictures` (
  `id`               INT(11) NOT NULL AUTO_INCREMENT,
  `content_type`     VARCHAR(255) DEFAULT NULL,
  `filename`         VARCHAR(255) DEFAULT NULL,
  `size`             INT(11) DEFAULT NULL,
  `db_file_id`       INT(11) DEFAULT NULL,
  `pictureable_id`   INT(11) DEFAULT NULL,
  `pictureable_type` VARCHAR(50) DEFAULT NULL,
  `parent_id`        INT(11) DEFAULT NULL,
  `thumbnail`        VARCHAR(255) DEFAULT NULL,
  `width`            INT(11) DEFAULT NULL,
  `height`           INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `prices`
--

DROP TABLE IF EXISTS `prices`;
CREATE TABLE IF NOT EXISTS `prices` (
  `id`              INT(11)       NOT NULL AUTO_INCREMENT,
  `value`           DECIMAL(8, 2) NOT NULL,
  `price_model_id`  INT(11)       NOT NULL,
  `price_class_id`  INT(11)       NOT NULL,
  `price_schema_id` INT(11)       NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `price_classes`
--

DROP TABLE IF EXISTS `price_classes`;
CREATE TABLE IF NOT EXISTS `price_classes` (
  `id`                   INT(11)      NOT NULL AUTO_INCREMENT,
  `name`                 VARCHAR(100) NOT NULL,
  `color`                INT(11)      NOT NULL,
  `event_id`             INT(11)      NOT NULL,
  `abstract_template_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `price_models`
--

DROP TABLE IF EXISTS `price_models`;
CREATE TABLE IF NOT EXISTS `price_models` (
  `id`                        INT(11)     NOT NULL AUTO_INCREMENT,
  `type`                      VARCHAR(50) NOT NULL,
  `name`                      VARCHAR(50) DEFAULT NULL,
  `event_id`                  INT(11)     NOT NULL,
  `note`                      VARCHAR(255) DEFAULT NULL,
  `ticket_count_for_validity` INT(11) DEFAULT NULL,
  `free_tickets_count`        INT(11) DEFAULT NULL,
  `discount_percent`          INT(11) DEFAULT NULL,
  `valid_for_web_sales`       TINYINT(1) DEFAULT NULL,
  `valid_in_all_pos`          TINYINT(1) DEFAULT NULL,
  `campaign_id`               INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `price_schemas`
--

DROP TABLE IF EXISTS `price_schemas`;
CREATE TABLE IF NOT EXISTS `price_schemas` (
  `id`       INT(11)     NOT NULL AUTO_INCREMENT,
  `type`     VARCHAR(50) NOT NULL,
  `event_id` INT(11)     NOT NULL,
  `amount`   INT(11) DEFAULT NULL,
  `end_time` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `printouts`
--

DROP TABLE IF EXISTS `printouts`;
CREATE TABLE IF NOT EXISTS `printouts` (
  `id`             INT(11)     NOT NULL AUTO_INCREMENT,
  `printable_id`   INT(11)     NOT NULL,
  `printable_type` VARCHAR(50) NOT NULL,
  `created_by_id`  INT(11)     NOT NULL,
  `succeeded`      TINYINT(1) DEFAULT NULL,
  `created_at`     TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`     TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `store_id`       INT(11)     NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE IF NOT EXISTS `schema_info` (
  `version` INT(11) DEFAULT NULL
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `screens`
--

DROP TABLE IF EXISTS `screens`;
CREATE TABLE IF NOT EXISTS `screens` (
  `id`            INT(11)     NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(50) NOT NULL,
  `menu_position` INT(11) DEFAULT NULL,
  `hall_plan_id`  INT(11)     NOT NULL,
  `row_markers`   TEXT,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `seat_transactions`
--

DROP TABLE IF EXISTS `seat_transactions`;
CREATE TABLE IF NOT EXISTS `seat_transactions` (
  `id`                  INT(11)     NOT NULL AUTO_INCREMENT,
  `type`                VARCHAR(50) NOT NULL,
  `ticket_id`           INT(11) DEFAULT NULL,
  `transaction_line_id` INT(11) DEFAULT NULL,
  `seat_id`             INT(11)     NOT NULL,
  `created_by_id`       INT(11) DEFAULT NULL,
  `created_at`          TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id`         INT(11)   NOT NULL AUTO_INCREMENT,
  `session_id` VARCHAR(255) DEFAULT NULL,
  `data`       TEXT,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stores`
--

DROP TABLE IF EXISTS `stores`;
CREATE TABLE IF NOT EXISTS `stores` (
  `id`             INT(11)      NOT NULL AUTO_INCREMENT,
  `name`           VARCHAR(100) NOT NULL,
  `reseller_id`    INT(11)      NOT NULL,
  `internal_name`  VARCHAR(20) DEFAULT NULL,
  `archived_at`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_by_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `taggings`
--

DROP TABLE IF EXISTS `taggings`;
CREATE TABLE IF NOT EXISTS `taggings` (
  `id`            INT(11)   NOT NULL AUTO_INCREMENT,
  `tag_id`        INT(11) DEFAULT NULL,
  `taggable_id`   INT(11) DEFAULT NULL,
  `taggable_type` VARCHAR(255) DEFAULT NULL,
  `created_at`    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id`   INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `id`                     INT(11)        NOT NULL AUTO_INCREMENT,
  `transaction_line_id`    INT(11)        NOT NULL,
  `abstract_template_id`   INT(11)        NOT NULL,
  `state`                  VARCHAR(255)   NOT NULL,
  `serial_number`          VARCHAR(30) DEFAULT NULL,
  `price_value`            DECIMAL(12, 5) NOT NULL,
  `normal_price_value`     DECIMAL(12, 5) NOT NULL,
  `created_at`             TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`             TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ticket_group_id`        INT(11) DEFAULT NULL,
  `web_serial_number`      VARCHAR(30) DEFAULT NULL,
  `has_been_swapped`       TINYINT(1) DEFAULT '0',
  `checked_by_id`          INT(11) DEFAULT NULL,
  `checked_at`             TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `has_been_sent_by_email` TINYINT(1) DEFAULT '0',
  `swapped_by_id`          INT(11) DEFAULT NULL,
  `swapped_at`             TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `swapped_in_store_id`    INT(11) DEFAULT NULL,
  `price_value_eek`        DECIMAL(12, 5) DEFAULT NULL,
  `normal_price_value_eek` DECIMAL(12, 5) DEFAULT '0.00000',
  `price_model_class`      VARCHAR(50) DEFAULT NULL,
  `price_model_text`       VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `ticket_fields`
--

DROP TABLE IF EXISTS `ticket_fields`;
CREATE TABLE IF NOT EXISTS `ticket_fields` (
  `id`                   INT(11)     NOT NULL AUTO_INCREMENT,
  `type`                 VARCHAR(50) NOT NULL,
  `abstract_template_id` INT(11)     NOT NULL,
  `coordinate_x`         INT(11)     NOT NULL,
  `coordinate_y`         INT(11)     NOT NULL,
  `width`                INT(11)     NOT NULL,
  `height`               INT(11) DEFAULT NULL,
  `rotation`             INT(11)     NOT NULL DEFAULT '0',
  `font`                 VARCHAR(100) DEFAULT NULL,
  `font_size`            INT(11) DEFAULT NULL,
  `is_bold`              TINYINT(1)  NOT NULL DEFAULT '0',
  `is_italic`            TINYINT(1)  NOT NULL DEFAULT '0',
  `is_underlined`        TINYINT(1)  NOT NULL DEFAULT '0',
  `currency`             VARCHAR(3) DEFAULT NULL,
  `text`                 VARCHAR(255) DEFAULT NULL,
  `can_wrap`             TINYINT(1)  NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `ticket_groups`
--

DROP TABLE IF EXISTS `ticket_groups`;
CREATE TABLE IF NOT EXISTS `ticket_groups` (
  `id`                      INT(11)      NOT NULL AUTO_INCREMENT,
  `transaction_line_id`     INT(11)      NOT NULL,
  `price_model_description` VARCHAR(255) NOT NULL,
  `created_at`              TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `parent_id`               INT(11) DEFAULT NULL,
  `campaign_code_id`        INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `ticket_medias`
--

DROP TABLE IF EXISTS `ticket_medias`;
CREATE TABLE IF NOT EXISTS `ticket_medias` (
  `id`     INT(11)     NOT NULL AUTO_INCREMENT,
  `active` TINYINT(1)  NOT NULL DEFAULT '0',
  `name`   VARCHAR(50) NOT NULL,
  `width`  INT(11)     NOT NULL,
  `height` INT(11)     NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id`                     INT(11)        NOT NULL AUTO_INCREMENT,
  `type`                   VARCHAR(50)    NOT NULL,
  `client_id`              INT(11) DEFAULT NULL,
  `time`                   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment`                VARCHAR(255) DEFAULT NULL,
  `redemption_date`        TIMESTAMP      NOT NULL DEFAULT '0000-00-00 00:00:00',
  `use_booking_time_price` TINYINT(1) DEFAULT NULL,
  `transaction_id`         INT(11) DEFAULT NULL,
  `complete`               TINYINT(1)     NOT NULL DEFAULT '0',
  `created_by_id`          INT(11) DEFAULT NULL,
  `store_id`               INT(11) DEFAULT NULL,
  `lock_version`           INT(11)        NOT NULL DEFAULT '0',
  `transaction_fee`        DECIMAL(10, 0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `transaction_lines`
--

DROP TABLE IF EXISTS `transaction_lines`;
CREATE TABLE IF NOT EXISTS `transaction_lines` (
  `id`              INT(11)     NOT NULL AUTO_INCREMENT,
  `transaction_id`  INT(11)     NOT NULL,
  `type`            VARCHAR(50) NOT NULL,
  `performance_id`  INT(11) DEFAULT NULL,
  `refundable_id`   INT(11) DEFAULT NULL,
  `refundable_type` VARCHAR(255) DEFAULT NULL,
  `created_at`      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gift_card_id`    INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `user`
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
-- Andmete tõmmistamine tabelile `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `deleted`) VALUES
  (1, 'demo', 'demo', 0);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id`                         INT(11)     NOT NULL AUTO_INCREMENT,
  `username`                   VARCHAR(20) NOT NULL,
  `password_hash`              VARCHAR(40) NOT NULL,
  `salt`                       VARCHAR(10) NOT NULL,
  `first_name`                 VARCHAR(50) DEFAULT NULL,
  `last_name`                  VARCHAR(50) DEFAULT NULL,
  `email`                      VARCHAR(100) DEFAULT NULL,
  `super_admin`                TINYINT(1)  NOT NULL DEFAULT '0',
  `cart_transaction_opened_at` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active`                     TINYINT(1)  NOT NULL,
  `phone`                      VARCHAR(30) DEFAULT NULL,
  `notes`                      VARCHAR(255) DEFAULT NULL,
  `lock_version`               INT(11) DEFAULT '0',
  `created_at`                 TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at`                 TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `partner_id`                 INT(11)     NOT NULL,
  `store_id`                   INT(11) DEFAULT NULL,
  `active_transaction_id`      INT(11) DEFAULT NULL,
  `previous_sale_id`           INT(11) DEFAULT NULL,
  `archived_at`                TIMESTAMP   NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id`             INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `venues`
--

DROP TABLE IF EXISTS `venues`;
CREATE TABLE IF NOT EXISTS `venues` (
  `id`             INT(11)     NOT NULL AUTO_INCREMENT,
  `name`           VARCHAR(50) NOT NULL,
  `organizer_id`   INT(11) DEFAULT NULL,
  `address`        VARCHAR(200) DEFAULT NULL,
  `address_info`   VARCHAR(200) DEFAULT NULL,
  `city`           VARCHAR(50) DEFAULT NULL,
  `archived_at`    TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived_by_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `waiting_lists`
--

DROP TABLE IF EXISTS `waiting_lists`;
CREATE TABLE IF NOT EXISTS `waiting_lists` (
  `id`             INT(11) NOT NULL AUTO_INCREMENT,
  `performance_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `web_documents`
--

DROP TABLE IF EXISTS `web_documents`;
CREATE TABLE IF NOT EXISTS `web_documents` (
  `id`                       INT(11)      NOT NULL AUTO_INCREMENT,
  `type`                     VARCHAR(50)  NOT NULL,
  `description`              TEXT,
  `content`                  TEXT,
  `language`                 VARCHAR(2)   NOT NULL,
  `title`                    VARCHAR(100) NOT NULL,
  `active`                   TINYINT(1)   NOT NULL,
  `author_id`                INT(11)      NOT NULL,
  `created_at`               TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`               TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `layout_type`              VARCHAR(255) DEFAULT NULL,
  `newsarticle_container_id` INT(11) DEFAULT NULL,
  `image_link_url`           VARCHAR(255) DEFAULT NULL,
  `active_ad`                TINYINT(1)   NOT NULL DEFAULT '0',
  `youtube_url`              VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4
  AUTO_INCREMENT =1;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `web_organizer_menus`
--

DROP TABLE IF EXISTS `web_organizer_menus`;
CREATE TABLE IF NOT EXISTS `web_organizer_menus` (
  `id`             INT(11)      NOT NULL,
  `title`          VARCHAR(255) NOT NULL,
  `position`       INT(11)      NOT NULL,
  `organizer_id`   INT(11) DEFAULT NULL,
  `parent_menu_id` INT(11) DEFAULT NULL,
  `is_level_2`     TINYINT(1)   NOT NULL DEFAULT '0',
  `created_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at`     TIMESTAMP    NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title_en`       TEXT,
  `title_fi`       TEXT,
  `title_ru`       TEXT
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;
