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
-- 테이블 구조 `portfolio`
--

CREATE TABLE `portfolio` (
  `portfoliocode` int(30) NOT NULL COMMENT '포트폴리오코드',
  `file` varchar(30) NOT NULL COMMENT '파일',
  `title` varchar(30) NOT NULL COMMENT '제목',
  `contents` varchar(100) NOT NULL COMMENT '내용',
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `choosecount` int(11) NOT NULL COMMENT '채택수',
  `viewcount` int(11) NOT NULL COMMENT '조회수',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성시간'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `portfolio`
--

INSERT INTO `portfolio` (`portfoliocode`, `file`, `title`, `contents`, `id`, `choosecount`, `viewcount`, `reg_date`) VALUES
(1, '파일', '포트폴리오', '포트폴리오 내용', 'test', 0, 0, '2018-09-20 07:05:17');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`portfoliocode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `portfolio`
--
ALTER TABLE `portfolio`
  MODIFY `portfoliocode` int(30) NOT NULL AUTO_INCREMENT COMMENT '포트폴리오코드', AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
