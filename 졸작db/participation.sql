-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 18-09-21 07:22
-- 서버 버전: 5.7.21-log
-- PHP 버전: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `signd`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `participation`
--

CREATE TABLE `participation` (
  `ppcode` int(30) NOT NULL COMMENT '작품코드',
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `title` varchar(30) NOT NULL COMMENT '제목',
  `contents` varchar(100) NOT NULL COMMENT '작품설명',
  `file` varchar(50) NOT NULL COMMENT '디자인 파일',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성날짜',
  `clause` int(10) NOT NULL COMMENT '등록 약관 코드'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='작품테이블';

--
-- 테이블의 덤프 데이터 `participation`
--

INSERT INTO `participation` (`ppcode`, `id`, `title`, `contents`, `file`, `reg_date`, `clause`) VALUES
(1, 'test', '디자인 공모', '디자인 공모 test입니다.', '파일', '2018-09-20 06:08:12', 1);

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `participation`
--
ALTER TABLE `participation`
  ADD PRIMARY KEY (`ppcode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `participation`
--
ALTER TABLE `participation`
  MODIFY `ppcode` int(30) NOT NULL AUTO_INCREMENT COMMENT '작품코드', AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
