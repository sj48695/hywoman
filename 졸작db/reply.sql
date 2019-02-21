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
-- 테이블 구조 `reply`
--

CREATE TABLE `reply` (
  `replycode` int(50) NOT NULL COMMENT '댓글번호',
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `division` varchar(10) NOT NULL COMMENT '의뢰글/포트폴리오',
  `reply` varchar(100) NOT NULL COMMENT '댓글',
  `re_level` int(30) NOT NULL COMMENT '댓글단계',
  `re_step` int(30) NOT NULL COMMENT '댓글순서',
  `ref` int(50) NOT NULL COMMENT '글번호',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성날짜'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='댓글테이블';

--
-- 테이블의 덤프 데이터 `reply`
--

INSERT INTO `reply` (`replycode`, `id`, `division`, `reply`, `re_level`, `re_step`, `ref`, `reg_date`) VALUES
(1, 'test', '의뢰글', '댓글', 0, 0, 1, '2018-09-20 07:21:58');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `reply`
--
ALTER TABLE `reply`
  ADD PRIMARY KEY (`replycode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `reply`
--
ALTER TABLE `reply`
  MODIFY `replycode` int(50) NOT NULL AUTO_INCREMENT COMMENT '댓글번호', AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
