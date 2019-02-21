-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 18-09-21 07:23
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
-- 테이블 구조 `request`
--

CREATE TABLE `request` (
  `requestcode` int(30) NOT NULL COMMENT '글번호',
  `id` varchar(30) NOT NULL COMMENT '회원 아이디',
  `title` varchar(30) NOT NULL COMMENT '제목',
  `service` varchar(50) NOT NULL COMMENT '내용(서비스설명)',
  `category` varchar(30) NOT NULL COMMENT '카테고리',
  `request` varchar(100) NOT NULL COMMENT '디자인 요구사항',
  `file` varchar(50) NOT NULL COMMENT '참고자료',
  `viewcount` int(30) NOT NULL COMMENT '조회수',
  `cost` int(30) NOT NULL COMMENT '의뢰금',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성날짜',
  `end_date` datetime NOT NULL COMMENT '마감날짜',
  `workcode` int(30) NOT NULL COMMENT '채택한 작품코드',
  `color` varchar(30) NOT NULL COMMENT '색상',
  `job_kind` varchar(30) NOT NULL COMMENT '업종',
  `plan` varchar(30) NOT NULL COMMENT '로고 사용 계획',
  `slogan` varchar(30) NOT NULL COMMENT '로고에 표기할 상호명/슬로건'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='의뢰글 테이블';

--
-- 테이블의 덤프 데이터 `request`
--

INSERT INTO `request` (`requestcode`, `id`, `title`, `service`, `category`, `request`, `file`, `viewcount`, `cost`, `reg_date`, `end_date`, `workcode`, `color`, `job_kind`, `plan`, `slogan`) VALUES
(1, 'jo', '의뢰글 제목', '서비스내용', '로고', '상세내용', '파일', 0, 300000, '2018-09-20 02:38:57', '2018-09-27 00:00:00', 1, 'blue', 'it', '플랜', '슬로건'),
(2, 'jo', '의뢰글 제목2', '서비스내용2', '로고', 'ㅇㅇㅇㅇ', '파일', 0, 500000, '2018-09-21 07:01:04', '2018-09-28 00:00:00', 1, 'black', '카페', '계획', '약관');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`requestcode`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `request`
--
ALTER TABLE `request`
  MODIFY `requestcode` int(30) NOT NULL AUTO_INCREMENT COMMENT '글번호', AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
