-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 18-09-21 07:20
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
-- 테이블 구조 `bookmark`
--

CREATE TABLE `bookmark` (
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `designer_id` varchar(30) NOT NULL COMMENT '디자이너 아이디',
  `requestcode` int(30) NOT NULL COMMENT '의뢰글코드',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '등록일시'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='즐겨찾기테이블';

--
-- 테이블의 덤프 데이터 `bookmark`
--

INSERT INTO `bookmark` (`id`, `designer_id`, `requestcode`, `reg_date`) VALUES
('jo', 'test', 1, '2018-09-20 02:32:29'),
('test', 'jo', 2, '2018-09-20 06:49:28');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
