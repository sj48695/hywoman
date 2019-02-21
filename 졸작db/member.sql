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
-- 테이블 구조 `member`
--

CREATE TABLE `member` (
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `passwd` varchar(30) NOT NULL COMMENT '회원 비밀번호',
  `name` varchar(30) NOT NULL COMMENT '회원 이름',
  `tel` varchar(30) NOT NULL COMMENT '회원 전화번호',
  `email` varchar(30) NOT NULL COMMENT '이메일 아이디',
  `type` varchar(30) NOT NULL COMMENT '회원 구분',
  `profileimg` varchar(50) DEFAULT '기본이미지.png' COMMENT '프로필이미지',
  `introduction` varchar(50) DEFAULT NULL COMMENT '한줄소개',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '가입 날짜'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원 테이블';

--
-- 테이블의 덤프 데이터 `member`
--

INSERT INTO `member` (`id`, `passwd`, `name`, `tel`, `email`, `type`, `profileimg`, `introduction`, `reg_date`) VALUES
('jo', '1234', '조수정', '01054827608', 'sj48695@nate.com', '의뢰인', '수정.jpg', '안녕하세요 의뢰자 조수정입니다.', '2018-09-15 17:43:58'),
('kkk', '1234', 'ㅎㅎㅎ', '01040593820', 'kkk@naver.com', '의뢰인', '기본이미지.png', '', '2018-09-15 16:55:45'),
('phj', '1234', '박현지', '01034329584', 'phj@naver.com', '의뢰인', '기본이미지.png', '', '2018-09-15 16:53:42'),
('q', 'q', 'q', '01022232134', 'q@daum.net', '디자이너', '기본이미지.png', '', '2018-09-15 16:55:54'),
('test', '1234', '테스트', '01011112212', 'test@gmail.com', '디자이너', 'images.png', 'test중입니다.', '2018-09-20 02:53:34');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
