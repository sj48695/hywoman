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
-- 테이블 구조 `message`
--

CREATE TABLE `message` (
  `msgcode` int(30) NOT NULL COMMENT '쪽지코드',
  `to_id` varchar(30) NOT NULL COMMENT '받는사람',
  `from_id` varchar(30) NOT NULL COMMENT '보낸사람',
  `contents` varchar(50) NOT NULL COMMENT '쪽지내용',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '전송날짜'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쪽지';

--
-- 테이블의 덤프 데이터 `message`
--

INSERT INTO `message` (`msgcode`, `to_id`, `from_id`, `contents`, `reg_date`) VALUES
(1, 'jo', 'test', '쪽지보내ㄱ', '2018-09-17 11:13:33'),
(2, 'test', 'jo', 'ㄱㄱ', '2018-09-17 11:14:03'),
(3, 'jo', 'test', '쪽지 test중입니다.', '2018-09-17 16:44:31'),
(4, 'jo', 'phj', '박현지님이 조수정님에게 쪽지를 보냈습니다. 확인해주세요', '2018-09-17 16:46:59');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`msgcode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `message`
--
ALTER TABLE `message`
  MODIFY `msgcode` int(30) NOT NULL AUTO_INCREMENT COMMENT '쪽지코드', AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
