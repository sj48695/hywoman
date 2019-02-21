-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 18-09-21 07:21
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
-- 테이블 구조 `notice`
--

CREATE TABLE `notice` (
  `noticecode` int(30) NOT NULL COMMENT '공지사항코드',
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `title` varchar(30) NOT NULL COMMENT '제목',
  `contents` varchar(30) NOT NULL COMMENT '내용',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성날짜'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공지사항';

--
-- 테이블의 덤프 데이터 `notice`
--

INSERT INTO `notice` (`noticecode`, `id`, `title`, `contents`, `reg_date`) VALUES
(1, 'test', '[공지사항]오늘은 축제입니다', '한양여대 축제입니다.', '2018-09-20 07:04:06');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `notice`
--
ALTER TABLE `notice`
  ADD PRIMARY KEY (`noticecode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `notice`
--
ALTER TABLE `notice`
  MODIFY `noticecode` int(30) NOT NULL AUTO_INCREMENT COMMENT '공지사항코드', AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
