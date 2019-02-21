-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 18-09-21 07:19
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
-- 테이블 구조 `alarm`
--

CREATE TABLE `alarm` (
  `to_id` varchar(30) NOT NULL COMMENT '수신자 아이디',
  `from_id` varchar(30) NOT NULL COMMENT '액션을 취한 회원',
  `noticedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '알림 발생 일시',
  `url` varchar(30) NOT NULL COMMENT '클릭시 이동할 주소',
  `contents` varchar(50) NOT NULL COMMENT '내용'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='알림테이블';

--
-- 테이블의 덤프 데이터 `alarm`
--

INSERT INTO `alarm` (`to_id`, `from_id`, `noticedate`, `url`, `contents`) VALUES
('jo', 'test', '2018-09-13 15:00:00', 'https://www.naver.com/', '알람'),
('test', 'jo', '2018-09-19 19:07:37', 'https://www.daum.net/', 'jo님으로부터 쪽지가 도착했습니다.');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
