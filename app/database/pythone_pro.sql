-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2024 at 07:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pythone_pro`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `name`, `email`, `phone_number`, `password`) VALUES
(1, 'John Doe', 'johndoe@example.com', '0123456789', 'adminpassword123'),
(2, 'Alice Smith', 'alice.smith@example.com', '0987654321', 'adminpassword456');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `class_id` int(11) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `class_name`, `section`, `level`) VALUES
(1, 'Math 101', 'A', 'Undergraduate'),
(2, 'CS 101', 'B', 'Undergraduate');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `Course_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `course_name` varchar(50) DEFAULT NULL,
  `file_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`Course_id`, `subject_id`, `course_name`, `file_name`) VALUES
(1, 1, 'Algebra Assignment 1', 'algebra_assignment_1.pdf'),
(2, 2, 'Programming Assignment 1', 'programming_assignment_1.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `module_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `module_name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `semester` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`module_id`, `class_id`, `module_name`, `description`, `semester`) VALUES
(1, 1, 'Algebra', 'Introduction to Algebra', 'Semester 1'),
(2, 2, 'Computer Science Basics', 'Introduction to Programming', 'Semester 1'),
(3, 1, 'Advanced Algebra', 'Advanced topics in Algebra', 'Semester 2'),
(4, 1, 'Statistics', 'Introduction to Statistics', 'Semester 2'),
(5, 1, 'Calculus', 'Calculus fundamentals', 'Semester 2');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` char(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `name`, `date_of_birth`, `email`, `phone_number`, `password`) VALUES
('S123456789', 'Hassan Ali', '2000-05-15', 'hassan.ali@student.com', '0687654321', 'studentpassword123'),
('S987654321', 'aziz king', '2001-02-20', 'aziz.belharcha@student.com', '0681234567', 'studentpassword456');

-- --------------------------------------------------------

--
-- Table structure for table `student_subject_information`
--

CREATE TABLE `student_subject_information` (
  `subject_id` int(11) NOT NULL,
  `student_id` char(10) NOT NULL,
  `controle` float DEFAULT NULL,
  `final_exam` float DEFAULT NULL,
  `late` int(11) DEFAULT NULL,
  `absence` int(11) DEFAULT NULL,
  `tp` float NOT NULL,
  `controle_percentage` float NOT NULL,
  `final_exam_percentage` float NOT NULL,
  `tp_percentage` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_subject_information`
--

INSERT INTO `student_subject_information` (`subject_id`, `student_id`, `controle`, `final_exam`, `late`, `absence`, `tp`, `controle_percentage`, `final_exam_percentage`, `tp_percentage`) VALUES
(1, 'S987654321', 14.5, 16, 0, 1, 10, 0, 0, 0),
(2, 'S123456789', 12, 13.5, 1, 0, 15, 0, 0, 0),
(3, 'S123456789', 12, 15, 1, 0, 15, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `subject_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `admin_id2` int(11) NOT NULL,
  `subject_name` varchar(50) DEFAULT NULL,
  `numbers_hours` int(11) DEFAULT NULL,
  `passed_hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`subject_id`, `module_id`, `admin_id2`, `subject_name`, `numbers_hours`, `passed_hours`) VALUES
(1, 1, 1, 'Linear Algebra', 40, 30),
(2, 2, 2, 'Programming in C', 45, 30),
(3, 2, 2, 'managment', 45, 30);

-- --------------------------------------------------------

--
-- Table structure for table `supervision`
--

CREATE TABLE `supervision` (
  `admin_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervision`
--

INSERT INTO `supervision` (`admin_id`, `class_id`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `teatcher`
--

CREATE TABLE `teatcher` (
  `admin_id2` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teatcher`
--

INSERT INTO `teatcher` (`admin_id2`, `name`, `email`, `phone_number`, `password`) VALUES
(1, 'Dr. Aziz', 'dr.aziz@example.com', '0745123456', 'teacherpassword123'),
(2, 'Prof. Thomas', 'prof.thomas@example.com', '0745987654', 'teacherpassword456');

-- --------------------------------------------------------

--
-- Table structure for table `time_table`
--

CREATE TABLE `time_table` (
  `time_table_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `course_type` varchar(50) DEFAULT NULL,
  `course_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_table`
--

INSERT INTO `time_table` (`time_table_id`, `subject_id`, `course_type`, `course_time`) VALUES
(1, 1, 'Lecture', '09:00:00'),
(2, 2, 'Practical', '14:30:00'),
(3, 3, 'Lecture', '11:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`Course_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`module_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_subject_information`
--
ALTER TABLE `student_subject_information`
  ADD PRIMARY KEY (`subject_id`,`student_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`subject_id`),
  ADD KEY `module_id` (`module_id`),
  ADD KEY `admin_id2` (`admin_id2`);

--
-- Indexes for table `supervision`
--
ALTER TABLE `supervision`
  ADD PRIMARY KEY (`admin_id`,`class_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `teatcher`
--
ALTER TABLE `teatcher`
  ADD PRIMARY KEY (`admin_id2`);

--
-- Indexes for table `time_table`
--
ALTER TABLE `time_table`
  ADD PRIMARY KEY (`time_table_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `Course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `module`
--
ALTER TABLE `module`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teatcher`
--
ALTER TABLE `teatcher`
  MODIFY `admin_id2` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `time_table`
--
ALTER TABLE `time_table`
  MODIFY `time_table_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

--
-- Constraints for table `module`
--
ALTER TABLE `module`
  ADD CONSTRAINT `module_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`);

--
-- Constraints for table `student_subject_information`
--
ALTER TABLE `student_subject_information`
  ADD CONSTRAINT `student_subject_information_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  ADD CONSTRAINT `student_subject_information_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`),
  ADD CONSTRAINT `subject_ibfk_2` FOREIGN KEY (`admin_id2`) REFERENCES `teatcher` (`admin_id2`);

--
-- Constraints for table `supervision`
--
ALTER TABLE `supervision`
  ADD CONSTRAINT `supervision_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `supervision_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`);

--
-- Constraints for table `time_table`
--
ALTER TABLE `time_table`
  ADD CONSTRAINT `time_table_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
