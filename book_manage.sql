/*
 Navicat Premium Data Transfer

 Source Server         :
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30-0ubuntu0.20.04.2)
 Source Host           :
 Source Schema         : book_manage

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30-0ubuntu0.20.04.2)
 File Encoding         : 65001

 Date: 07/01/2023 15:50:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `bid` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sid` int DEFAULT NULL,
  `bid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_sid_bid` (`sid`,`bid`),
  KEY `f_bid` (`bid`),
  CONSTRAINT `f_bid` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`),
  CONSTRAINT `f_sid` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `sid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sex` enum('男','女') NOT NULL DEFAULT '男',
  `grade` int NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Triggers structure for table book
-- ----------------------------
DROP TRIGGER IF EXISTS `del_book`;
delimiter ;;
CREATE TRIGGER `del_book` BEFORE DELETE ON `book` FOR EACH ROW DELETE FROM borrow WHERE bid = old.bid
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `del`;
delimiter ;;
CREATE TRIGGER `del` BEFORE DELETE ON `student` FOR EACH ROW DELETE FROM borrow WHERE sid = old.sid
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
