# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20050
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: 127.0.0.1 (MySQL 5.6.39)
# 数据库: grafana
# 生成时间: 2025-05-27 23:46:58 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE database if NOT EXISTS `grafana` default character set utf8mb4 collate utf8mb4_0900_ai_ci;
use `grafana`;

# 转储表 alert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert`;

CREATE TABLE `alert` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `panel_id` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` mediumtext COLLATE utf8mb4_unicode_ci,
  `frequency` bigint(20) NOT NULL,
  `handler` bigint(20) NOT NULL,
  `severity` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `silenced` tinyint(1) NOT NULL,
  `execution_error` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `eval_data` text COLLATE utf8mb4_unicode_ci,
  `eval_date` datetime DEFAULT NULL,
  `new_state_date` datetime NOT NULL,
  `state_changes` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `for` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_alert_org_id_id` (`org_id`,`id`),
  KEY `IDX_alert_state` (`state`),
  KEY `IDX_alert_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_configuration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_configuration`;

CREATE TABLE `alert_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alertmanager_configuration` mediumtext COLLATE utf8mb4_unicode_ci,
  `configuration_version` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `org_id` bigint(20) NOT NULL DEFAULT '0',
  `configuration_hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not-yet-calculated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_configuration_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `alert_configuration` WRITE;
/*!40000 ALTER TABLE `alert_configuration` DISABLE KEYS */;


/*!40000 ALTER TABLE `alert_configuration` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 alert_configuration_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_configuration_history`;

CREATE TABLE `alert_configuration_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL DEFAULT '0',
  `alertmanager_configuration` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `configuration_hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not-yet-calculated',
  `configuration_version` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `last_applied` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `alert_configuration_history` WRITE;
/*!40000 ALTER TABLE `alert_configuration_history` DISABLE KEYS */;


/*!40000 ALTER TABLE `alert_configuration_history` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 alert_image
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_image`;

CREATE TABLE `alert_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_image_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_instance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_instance`;

CREATE TABLE `alert_instance` (
  `rule_org_id` bigint(20) NOT NULL DEFAULT '0',
  `rule_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `labels` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels_hash` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state_since` bigint(20) NOT NULL,
  `last_eval_time` bigint(20) NOT NULL,
  `current_state_end` bigint(20) NOT NULL DEFAULT '0',
  `current_reason` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rule_org_id`,`rule_uid`,`labels_hash`),
  KEY `IDX_alert_instance_rule_org_id_rule_uid_current_state` (`rule_org_id`,`rule_uid`,`current_state`),
  KEY `IDX_alert_instance_rule_org_id_current_state` (`rule_org_id`,`current_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_notification
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_notification`;

CREATE TABLE `alert_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `frequency` bigint(20) DEFAULT NULL,
  `send_reminder` tinyint(1) DEFAULT '0',
  `disable_resolve_message` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secure_settings` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_notification_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_notification_state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_notification_state`;

CREATE TABLE `alert_notification_state` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `alert_id` bigint(20) NOT NULL,
  `notifier_id` bigint(20) NOT NULL,
  `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  `alert_rule_state_updated_version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_notification_state_org_id_alert_id_notifier_id` (`org_id`,`alert_id`,`notifier_id`),
  KEY `IDX_alert_notification_state_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_rule`;

CREATE TABLE `alert_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `updated` datetime NOT NULL,
  `interval_seconds` bigint(20) NOT NULL DEFAULT '60',
  `version` int(11) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `namespace_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_data_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint(20) NOT NULL DEFAULT '0',
  `annotations` text COLLATE utf8mb4_unicode_ci,
  `labels` text COLLATE utf8mb4_unicode_ci,
  `dashboard_uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `panel_id` bigint(20) DEFAULT NULL,
  `rule_group_idx` int(11) NOT NULL DEFAULT '1',
  `is_paused` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_org_id_uid` (`org_id`,`uid`),
  UNIQUE KEY `UQE_alert_rule_org_id_namespace_uid_title` (`org_id`,`namespace_uid`,`title`),
  KEY `IDX_alert_rule_org_id_namespace_uid_rule_group` (`org_id`,`namespace_uid`,`rule_group`),
  KEY `IDX_alert_rule_org_id_dashboard_uid_panel_id` (`org_id`,`dashboard_uid`,`panel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_rule_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_rule_tag`;

CREATE TABLE `alert_rule_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alert_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_tag_alert_id_tag_id` (`alert_id`,`tag_id`),
  KEY `IDX_alert_rule_tag_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 alert_rule_version
# ------------------------------------------------------------

DROP TABLE IF EXISTS `alert_rule_version`;

CREATE TABLE `alert_rule_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rule_org_id` bigint(20) NOT NULL,
  `rule_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `rule_namespace_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_version` int(11) NOT NULL,
  `restored_from` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `interval_seconds` bigint(20) NOT NULL,
  `no_data_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint(20) NOT NULL DEFAULT '0',
  `annotations` text COLLATE utf8mb4_unicode_ci,
  `labels` text COLLATE utf8mb4_unicode_ci,
  `rule_group_idx` int(11) NOT NULL DEFAULT '1',
  `is_paused` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_version_rule_org_id_rule_uid_version` (`rule_org_id`,`rule_uid`,`version`),
  KEY `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` (`rule_org_id`,`rule_namespace_uid`,`rule_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 annotation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `annotation`;

CREATE TABLE `annotation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `alert_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `dashboard_id` bigint(20) DEFAULT NULL,
  `panel_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_state` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_state` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `epoch` bigint(20) NOT NULL,
  `region_id` bigint(20) DEFAULT '0',
  `tags` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` bigint(20) DEFAULT '0',
  `updated` bigint(20) DEFAULT '0',
  `epoch_end` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_annotation_org_id_alert_id` (`org_id`,`alert_id`),
  KEY `IDX_annotation_org_id_type` (`org_id`,`type`),
  KEY `IDX_annotation_org_id_created` (`org_id`,`created`),
  KEY `IDX_annotation_org_id_updated` (`org_id`,`updated`),
  KEY `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`),
  KEY `IDX_annotation_org_id_epoch_end_epoch` (`org_id`,`epoch_end`,`epoch`),
  KEY `IDX_annotation_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 annotation_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `annotation_tag`;

CREATE TABLE `annotation_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `annotation_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_annotation_tag_annotation_id_tag_id` (`annotation_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 anon_device
# ------------------------------------------------------------

DROP TABLE IF EXISTS `anon_device`;

CREATE TABLE `anon_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `device_id` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_anon_device_device_id` (`device_id`),
  KEY `IDX_anon_device_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 api_key
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_key`;

CREATE TABLE `api_key` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `expires` bigint(20) DEFAULT NULL,
  `service_account_id` bigint(20) DEFAULT NULL,
  `last_used_at` datetime DEFAULT NULL,
  `is_revoked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_api_key_key` (`key`),
  UNIQUE KEY `UQE_api_key_org_id_name` (`org_id`,`name`),
  KEY `IDX_api_key_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 builtin_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `builtin_role`;

CREATE TABLE `builtin_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `org_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_builtin_role_org_id_role_id_role` (`org_id`,`role_id`,`role`),
  KEY `IDX_builtin_role_role_id` (`role_id`),
  KEY `IDX_builtin_role_role` (`role`),
  KEY `IDX_builtin_role_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `builtin_role` WRITE;
/*!40000 ALTER TABLE `builtin_role` DISABLE KEYS */;


/*!40000 ALTER TABLE `builtin_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 cache_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cache_data`;

CREATE TABLE `cache_data` (
  `cache_key` varchar(168) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expires` int(255) NOT NULL,
  `created_at` int(255) NOT NULL,
  PRIMARY KEY (`cache_key`),
  UNIQUE KEY `UQE_cache_data_cache_key` (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 correlation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `correlation`;

CREATE TABLE `correlation` (
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL DEFAULT '0',
  `source_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` text COLLATE utf8mb4_unicode_ci,
  `provisioned` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`,`org_id`,`source_uid`),
  KEY `IDX_correlation_uid` (`uid`),
  KEY `IDX_correlation_source_uid` (`source_uid`),
  KEY `IDX_correlation_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 dashboard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard`;

CREATE TABLE `dashboard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `slug` varchar(189) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(189) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `gnet_id` bigint(20) DEFAULT NULL,
  `plugin_id` varchar(189) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint(20) NOT NULL DEFAULT '0',
  `is_folder` tinyint(1) NOT NULL DEFAULT '0',
  `has_acl` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_org_id_folder_id_title` (`org_id`,`folder_id`,`title`),
  UNIQUE KEY `UQE_dashboard_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_dashboard_org_id` (`org_id`),
  KEY `IDX_dashboard_gnet_id` (`gnet_id`),
  KEY `IDX_dashboard_org_id_plugin_id` (`org_id`,`plugin_id`),
  KEY `IDX_dashboard_title` (`title`),
  KEY `IDX_dashboard_is_folder` (`is_folder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;


/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 dashboard_acl
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_acl`;

CREATE TABLE `dashboard_acl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `team_id` bigint(20) DEFAULT NULL,
  `permission` smallint(6) NOT NULL DEFAULT '4',
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_acl_dashboard_id_user_id` (`dashboard_id`,`user_id`),
  UNIQUE KEY `UQE_dashboard_acl_dashboard_id_team_id` (`dashboard_id`,`team_id`),
  KEY `IDX_dashboard_acl_dashboard_id` (`dashboard_id`),
  KEY `IDX_dashboard_acl_user_id` (`user_id`),
  KEY `IDX_dashboard_acl_team_id` (`team_id`),
  KEY `IDX_dashboard_acl_org_id_role` (`org_id`,`role`),
  KEY `IDX_dashboard_acl_permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `dashboard_acl` WRITE;
/*!40000 ALTER TABLE `dashboard_acl` DISABLE KEYS */;


/*!40000 ALTER TABLE `dashboard_acl` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 dashboard_provisioning
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_provisioning`;

CREATE TABLE `dashboard_provisioning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int(11) NOT NULL DEFAULT '0',
  `check_sum` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_dashboard_provisioning_dashboard_id` (`dashboard_id`),
  KEY `IDX_dashboard_provisioning_dashboard_id_name` (`dashboard_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 dashboard_public
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_public`;

CREATE TABLE `dashboard_public` (
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `time_settings` text COLLATE utf8mb4_unicode_ci,
  `template_variables` mediumtext COLLATE utf8mb4_unicode_ci,
  `access_token` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `annotations_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `time_selection_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `share` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `UQE_dashboard_public_config_uid` (`uid`),
  UNIQUE KEY `UQE_dashboard_public_config_access_token` (`access_token`),
  KEY `IDX_dashboard_public_config_org_id_dashboard_uid` (`org_id`,`dashboard_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 dashboard_snapshot
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_snapshot`;

CREATE TABLE `dashboard_snapshot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delete_key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `external` tinyint(1) NOT NULL,
  `external_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external_delete_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_encrypted` mediumblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_snapshot_key` (`key`),
  UNIQUE KEY `UQE_dashboard_snapshot_delete_key` (`delete_key`),
  KEY `IDX_dashboard_snapshot_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 dashboard_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_tag`;

CREATE TABLE `dashboard_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) NOT NULL,
  `term` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_dashboard_tag_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 dashboard_version
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_version`;

CREATE TABLE `dashboard_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) NOT NULL,
  `parent_version` int(11) NOT NULL,
  `restored_from` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_version_dashboard_id_version` (`dashboard_id`,`version`),
  KEY `IDX_dashboard_version_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `dashboard_version` WRITE;
/*!40000 ALTER TABLE `dashboard_version` DISABLE KEYS */;


/*!40000 ALTER TABLE `dashboard_version` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 data_keys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `data_keys`;

CREATE TABLE `data_keys` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL,
  `scope` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encrypted_data` blob NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `data_keys` WRITE;
/*!40000 ALTER TABLE `data_keys` DISABLE KEYS */;


/*!40000 ALTER TABLE `data_keys` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 data_source
# ------------------------------------------------------------

DROP TABLE IF EXISTS `data_source`;

CREATE TABLE `data_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `database` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth` tinyint(1) NOT NULL,
  `basic_auth_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  `json_data` text COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `with_credentials` tinyint(1) NOT NULL DEFAULT '0',
  `secure_json_data` text COLLATE utf8mb4_unicode_ci,
  `read_only` tinyint(1) DEFAULT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_data_source_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_data_source_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_data_source_org_id` (`org_id`),
  KEY `IDX_data_source_org_id_is_default` (`org_id`,`is_default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `data_source` WRITE;
/*!40000 ALTER TABLE `data_source` DISABLE KEYS */;


/*!40000 ALTER TABLE `data_source` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 entity_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entity_event`;

CREATE TABLE `entity_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `path` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_folder_path_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contents` mediumblob,
  `etag` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cache_control` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_disposition` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  `size` bigint(20) NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_file_path_hash` (`path_hash`),
  KEY `IDX_file_parent_folder_path_hash` (`parent_folder_path_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 file_meta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `file_meta`;

CREATE TABLE `file_meta` (
  `path_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_file_meta_path_hash_key` (`path_hash`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 folder
# ------------------------------------------------------------

DROP TABLE IF EXISTS `folder`;

CREATE TABLE `folder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `title` varchar(189) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_folder_uid_org_id` (`uid`,`org_id`),
  UNIQUE KEY `UQE_folder_title_parent_uid_org_id` (`title`,`parent_uid`,`org_id`),
  KEY `IDX_folder_parent_uid_org_id` (`parent_uid`,`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 kv_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `kv_store`;

CREATE TABLE `kv_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `namespace` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_kv_store_org_id_namespace_key` (`org_id`,`namespace`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `kv_store` WRITE;
/*!40000 ALTER TABLE `kv_store` DISABLE KEYS */;


/*!40000 ALTER TABLE `kv_store` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 library_element
# ------------------------------------------------------------

DROP TABLE IF EXISTS `library_element`;

CREATE TABLE `library_element` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `folder_id` bigint(20) NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kind` bigint(20) NOT NULL,
  `type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_library_element_org_id_folder_id_name_kind` (`org_id`,`folder_id`,`name`,`kind`),
  UNIQUE KEY `UQE_library_element_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 library_element_connection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `library_element_connection`;

CREATE TABLE `library_element_connection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `element_id` bigint(20) NOT NULL,
  `kind` bigint(20) NOT NULL,
  `connection_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_library_element_connection_element_id_kind_connection_id` (`element_id`,`kind`,`connection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 login_attempt
# ------------------------------------------------------------

DROP TABLE IF EXISTS `login_attempt`;

CREATE TABLE `login_attempt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_login_attempt_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 migration_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migration_log`;

CREATE TABLE `migration_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `migration_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sql` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `success` tinyint(1) NOT NULL,
  `error` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migration_log` WRITE;
/*!40000 ALTER TABLE `migration_log` DISABLE KEYS */;


/*!40000 ALTER TABLE `migration_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 ngalert_configuration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ngalert_configuration`;

CREATE TABLE `ngalert_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `alertmanagers` text COLLATE utf8mb4_unicode_ci,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `send_alerts_to` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_ngalert_configuration_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 org
# ------------------------------------------------------------

DROP TABLE IF EXISTS `org`;

CREATE TABLE `org` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_org_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `org` WRITE;
/*!40000 ALTER TABLE `org` DISABLE KEYS */;


/*!40000 ALTER TABLE `org` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 org_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `org_user`;

CREATE TABLE `org_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_org_user_org_id_user_id` (`org_id`,`user_id`),
  KEY `IDX_org_user_org_id` (`org_id`),
  KEY `IDX_org_user_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `org_user` WRITE;
/*!40000 ALTER TABLE `org_user` DISABLE KEYS */;


/*!40000 ALTER TABLE `org_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `action` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `kind` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `attribute` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `identifier` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_permission_role_id_action_scope` (`role_id`,`action`,`scope`),
  KEY `IDX_permission_role_id` (`role_id`),
  KEY `IDX_permission_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;


/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 playlist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `playlist`;

CREATE TABLE `playlist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `created_at` bigint(20) NOT NULL DEFAULT '0',
  `updated_at` bigint(20) NOT NULL DEFAULT '0',
  `uid` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_playlist_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 playlist_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `playlist_item`;

CREATE TABLE `playlist_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 plugin_setting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugin_setting`;

CREATE TABLE `plugin_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `plugin_id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `json_data` text COLLATE utf8mb4_unicode_ci,
  `secure_json_data` text COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `plugin_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_plugin_setting_org_id_plugin_id` (`org_id`,`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `preferences`;

CREATE TABLE `preferences` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `home_dashboard_id` bigint(20) NOT NULL,
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `team_id` bigint(20) DEFAULT NULL,
  `week_start` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `json_data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_preferences_org_id` (`org_id`),
  KEY `IDX_preferences_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `preferences` WRITE;
/*!40000 ALTER TABLE `preferences` DISABLE KEYS */;


/*!40000 ALTER TABLE `preferences` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 provenance_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `provenance_type`;

CREATE TABLE `provenance_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `record_key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_type` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provenance` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_provenance_type_record_type_record_key_org_id` (`record_type`,`record_key`,`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 query_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `query_history`;

CREATE TABLE `query_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `datasource_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queries` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_query_history_org_id_created_by_datasource_uid` (`org_id`,`created_by`,`datasource_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 query_history_star
# ------------------------------------------------------------

DROP TABLE IF EXISTS `query_history_star`;

CREATE TABLE `query_history_star` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `query_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_query_history_star_user_id_query_uid` (`user_id`,`query_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 quota
# ------------------------------------------------------------

DROP TABLE IF EXISTS `quota`;

CREATE TABLE `quota` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `target` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `limit` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_quota_org_id_user_id_target` (`org_id`,`user_id`,`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `version` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `display_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_role_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_role_uid` (`uid`),
  KEY `IDX_role_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;


/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 secrets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `secrets`;

CREATE TABLE `secrets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `secrets` WRITE;
/*!40000 ALTER TABLE `secrets` DISABLE KEYS */;


/*!40000 ALTER TABLE `secrets` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 seed_assignment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `seed_assignment`;

CREATE TABLE `seed_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `builtin_role` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_seed_assignment_builtin_role_role_name` (`builtin_role`,`role_name`),
  UNIQUE KEY `UQE_seed_assignment_builtin_role_action_scope` (`builtin_role`,`action`,`scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 server_lock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `server_lock`;

CREATE TABLE `server_lock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_uid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint(20) NOT NULL,
  `last_execution` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_server_lock_operation_uid` (`operation_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `server_lock` WRITE;
/*!40000 ALTER TABLE `server_lock` DISABLE KEYS */;


/*!40000 ALTER TABLE `server_lock` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
  `key` char(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expiry` int(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 short_url
# ------------------------------------------------------------

DROP TABLE IF EXISTS `short_url`;

CREATE TABLE `short_url` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `last_seen_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_short_url_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 signing_key
# ------------------------------------------------------------

DROP TABLE IF EXISTS `signing_key`;

CREATE TABLE `signing_key` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `private_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_at` datetime NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `alg` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_signing_key_key_id` (`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 star
# ------------------------------------------------------------

DROP TABLE IF EXISTS `star`;

CREATE TABLE `star` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_star_user_id_dashboard_id` (`user_id`,`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_tag_key_value` (`key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 team
# ------------------------------------------------------------

DROP TABLE IF EXISTS `team`;

CREATE TABLE `team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_team_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_team_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 team_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `team_member`;

CREATE TABLE `team_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `team_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external` tinyint(1) DEFAULT NULL,
  `permission` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_member_org_id_team_id_user_id` (`org_id`,`team_id`,`user_id`),
  KEY `IDX_team_member_org_id` (`org_id`),
  KEY `IDX_team_member_team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 team_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `team_role`;

CREATE TABLE `team_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `team_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_role_org_id_team_id_role_id` (`org_id`,`team_id`,`role_id`),
  KEY `IDX_team_role_org_id` (`org_id`),
  KEY `IDX_team_role_team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 temp_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `temp_user`;

CREATE TABLE `temp_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invited_by_user_id` bigint(20) DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL,
  `email_sent_on` datetime DEFAULT NULL,
  `remote_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  `updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_temp_user_email` (`email`),
  KEY `IDX_temp_user_org_id` (`org_id`),
  KEY `IDX_temp_user_code` (`code`),
  KEY `IDX_temp_user_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 test_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `test_data`;

CREATE TABLE `test_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `metric1` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metric2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_big_int` bigint(20) DEFAULT NULL,
  `value_double` double DEFAULT NULL,
  `value_float` float DEFAULT NULL,
  `value_int` int(11) DEFAULT NULL,
  `time_epoch` bigint(20) NOT NULL,
  `time_date_time` datetime NOT NULL,
  `time_time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `login` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rands` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `org_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `theme` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `help_flags1` bigint(20) NOT NULL DEFAULT '0',
  `last_seen_at` datetime DEFAULT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_account` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_login` (`login`),
  UNIQUE KEY `UQE_user_email` (`email`),
  KEY `IDX_user_login_email` (`login`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;


/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_auth
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_auth`;

CREATE TABLE `user_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `auth_module` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_id` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `o_auth_access_token` text COLLATE utf8mb4_unicode_ci,
  `o_auth_refresh_token` text COLLATE utf8mb4_unicode_ci,
  `o_auth_token_type` text COLLATE utf8mb4_unicode_ci,
  `o_auth_expiry` datetime DEFAULT NULL,
  `o_auth_id_token` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_user_auth_auth_module_auth_id` (`auth_module`,`auth_id`),
  KEY `IDX_user_auth_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 user_auth_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_auth_token`;

CREATE TABLE `user_auth_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `auth_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prev_auth_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_token_seen` tinyint(1) NOT NULL,
  `seen_at` int(11) DEFAULT NULL,
  `rotated_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `revoked_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_auth_token_auth_token` (`auth_token`),
  UNIQUE KEY `UQE_user_auth_token_prev_auth_token` (`prev_auth_token`),
  KEY `IDX_user_auth_token_user_id` (`user_id`),
  KEY `IDX_user_auth_token_revoked_at` (`revoked_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user_auth_token` WRITE;
/*!40000 ALTER TABLE `user_auth_token` DISABLE KEYS */;


/*!40000 ALTER TABLE `user_auth_token` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_role_org_id_user_id_role_id` (`org_id`,`user_id`,`role_id`),
  KEY `IDX_user_role_org_id` (`org_id`),
  KEY `IDX_user_role_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;


/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
