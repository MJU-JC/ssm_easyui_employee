/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : employee

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2017-10-01 16:09:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_department`
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `departmentNo` varchar(20) NOT NULL COMMENT 'departmentNo',
  `departmentName` varchar(50) NOT NULL COMMENT '部门名称',
  PRIMARY KEY  (`departmentNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('BM001', '财务部');
INSERT INTO `t_department` VALUES ('BM002', '市场部');
INSERT INTO `t_department` VALUES ('BM003', '开发部啊');

-- ----------------------------
-- Table structure for `t_employee`
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `employeeNo` varchar(20) NOT NULL COMMENT 'employeeNo',
  `positionObj` int(11) NOT NULL COMMENT '职位',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(4) NOT NULL COMMENT '性别',
  `employeePhoto` varchar(60) NOT NULL COMMENT '员工照片',
  `birthday` varchar(20) default NULL COMMENT '出生日期',
  `schoolRecord` varchar(20) NOT NULL COMMENT '学历',
  `employeeDesc` varchar(5000) default NULL COMMENT '员工介绍',
  PRIMARY KEY  (`employeeNo`),
  KEY `positionObj` (`positionObj`),
  CONSTRAINT `t_employee_ibfk_1` FOREIGN KEY (`positionObj`) REFERENCES `t_position` (`positionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO `t_employee` VALUES ('EM001', '1', '李明翠', '女', 'upload/137ea561-c82d-4025-9c2d-f3abf5cfb3b2.jpg', '1998-10-07', '大专', '精通公司财务管理');
INSERT INTO `t_employee` VALUES ('EM002', '4', '双鱼林', '男', 'upload/802350db-0589-46aa-a117-215551565eac.jpg', '1998-10-06', '硕士', '此人很牛逼，专业搞计算机源码开发，哈哈');

-- ----------------------------
-- Table structure for `t_position`
-- ----------------------------
DROP TABLE IF EXISTS `t_position`;
CREATE TABLE `t_position` (
  `positionId` int(11) NOT NULL auto_increment COMMENT '职位id',
  `departmentObj` varchar(20) NOT NULL COMMENT '所属部门',
  `positionName` varchar(50) NOT NULL COMMENT '职位名称',
  `baseSalary` float NOT NULL COMMENT '基本工资',
  `sellPercent` varchar(20) NOT NULL COMMENT '销售提成',
  PRIMARY KEY  (`positionId`),
  KEY `departmentObj` (`departmentObj`),
  CONSTRAINT `t_position_ibfk_1` FOREIGN KEY (`departmentObj`) REFERENCES `t_department` (`departmentNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_position
-- ----------------------------
INSERT INTO `t_position` VALUES ('1', 'BM001', '财务会计', '5600', '0');
INSERT INTO `t_position` VALUES ('2', 'BM002', '市场营销专员', '2000', '18%');
INSERT INTO `t_position` VALUES ('4', 'BM003', '技术总监', '15000', '10%');
