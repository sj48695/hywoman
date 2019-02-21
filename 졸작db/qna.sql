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
-- 테이블 구조 `qna`
--

CREATE TABLE `qna` (
  `QnAcode` int(50) NOT NULL COMMENT 'Q&A코드',
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `contents` varchar(50) NOT NULL COMMENT '문의내용',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성날짜',
  `re_step` int(30) NOT NULL COMMENT '댓글순서',
  `re_level` int(10) NOT NULL COMMENT '댓글단계',
  `ref` int(50) NOT NULL COMMENT '댓글그룹'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='문의게시판';

--
-- 테이블의 덤프 데이터 `qna`
--

INSERT INTO `qna` (`QnAcode`, `id`, `contents`, `reg_date`, `re_step`, `re_level`, `ref`) VALUES
(1, 'jo', '상금은 어떻게 나눠지나요?', '2018-09-20 06:10:59', 0, 0, 1);

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `qna`
--
ALTER TABLE `qna`
  ADD PRIMARY KEY (`QnAcode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `qna`
--
ALTER TABLE `qna`
  MODIFY `QnAcode` int(50) NOT NULL AUTO_INCREMENT COMMENT 'Q&A코드', AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
