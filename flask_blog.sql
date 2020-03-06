-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2020 at 11:16 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flask_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `srno` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone_no` varchar(12) NOT NULL,
  `msg` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`srno`, `name`, `email`, `phone_no`, `msg`, `date`) VALUES
(1, 'test', 'aa@gmail.com', '223423434', 'dwfwfsdf', '2020-03-04 05:21:09'),
(2, 'ALOK Singh', 'aalok@gmail.com', '9967674409', 'message', '2020-03-04 06:02:10'),
(3, 'qqqqwqw', 'aaa@gmail.com', '2342353', 'sdfsdfgdf', '2020-03-04 06:10:38'),
(4, 'qqqqwqw', 'aaa@gmail.com', '2342353', 'sdfsdfgdf', '2020-03-04 07:20:06'),
(5, 'ALOK Singh', 'alok5n@gmail.com', '9967674409', 'test message ', '2020-03-04 07:33:47'),
(6, 'ALOK Singh', 'alok5n@gmail.com', '9967674409', 'test message ', '2020-03-04 07:35:17'),
(7, 'ALOK Singh', 'alok5n@gmail.com', '9967674409', 'test message ', '2020-03-04 07:38:30');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `srno` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `slug` varchar(25) NOT NULL,
  `tagline` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`srno`, `title`, `slug`, `tagline`, `content`, `img_file`, `date`) VALUES
(2, 'All You Need to Know About Cartridge Waxing', 'roll-on-wax-cartridge-wax', 'What is Roll-on wax or Cartridge wax?', 'Urban Company recently launched the Smart Roll-on Wax or Cartridge Wax in India and since many are are curious to know more about it, we decided to put all the information in one place, just for you.\r\n\r\nSo, in this post, we will cover the following topics:\r\n\r\nWhat is Roll-on wax or Cartridge wax\r\nBenefits of Roll-on wax or Cartridge wax\r\nDifference between Roll-on wax (or Cartridge wax) & Normal wax\r\nCost of waxing services at UrbanClap (now Urban Company)\r\nLet’s decode them one-by-one.', '', '2020-03-05 06:24:31'),
(3, '6 Yoga Asanas To Help You Burn Your Belly Fat', 'yoga-to-reduce-belly-fat', 'In this post, we share with you the top 6 poses of yoga to reduce belly fat', 'Despite several forms of workout being available today, yoga reigns as the most trusted and effective method of nourishing and toning one’s body in a holistic sense.\r\n\r\nMost sought out of the various asanas are the ones that help to tone and flatten your tummy, of course! Because who doesn’t want a toned tummy that ultimately projects your good health?\r\n\r\nSince yoga endeavors to work deeply on the core and the entire body with every asana, the poses mentioned below are a few of the easier ones, especially for beginners. These will help eliminate several stomach-related issues like constipation, indigestion and bloating along with strengthening the abdomen.\r\n\r\nHere are 6 asanas of yoga to reduce belly fat.\r\n1. Bhujangasana (Cobra pose)\r\nThis posture primarily works on strengthening your abdominal muscles and relaxing your lower back.', '', '2020-03-05 06:23:52'),
(4, 'Construction Terms That Every Homeowner Should Understand', 'construction-terms-post', 'Unlike subjects at school when it comes to construction', 'Floorplan:\r\nA floor plan is the actual layout of the building, with dimensions, details, notes, and any other aspects needed for construction. A homeowner must pay close attention to this at the initial stage.', '11.png', '2020-03-05 11:00:18'),
(5, 'qqqq', 'qqw', 'qwe', 'rwerwerwer', '11.png', '2020-03-06 07:19:22'),
(6, 'ttttttttttt', 'tttttt', 'tytyt', 'yrtyrtyrtyryryr', '11.png', '2020-03-06 07:19:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`srno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`srno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
