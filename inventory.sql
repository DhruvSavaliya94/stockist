-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 26, 2020 at 02:56 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatesellstock` (IN `tcid` INT, IN `tpid` INT, IN `tquantity` INT, IN `trate` INT, IN `tdate` INT, IN `tamount` INT)  MODIFIES SQL DATA
BEGIN 
  INSERT INTO `selling`(`cid`, `pid`, `quantity`, `rate`, `date`, `amount`) VALUES (tcid,tpid,tquantity,trate,tdate,tamount);
  UPDATE products SET quantity=quantity-tquantity WHERE pid=tpid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatestock` (IN `tpid` INT, IN `tsid` INT, IN `tquantity` INT, IN `trate` INT, IN `tdate` INT, IN `tamount` INT)  MODIFIES SQL DATA
BEGIN 
  INSERT INTO `supplying`(`pid`, `sid`, `quantity`, `rate`, `date`, `amount`) VALUES (tpid,tsid,tquantity,trate,tdate,tamount);
  UPDATE products SET quantity=quantity+tquantity WHERE pid=tpid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cid` int(11) NOT NULL,
  `cname` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `gender` int(11) NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cid`, `cname`, `address`, `contact`, `gender`, `balance`) VALUES
(1, 'Dip', 'Surat', '98', 1, 0),
(2, 'Hardik', 'Utavad', '98', 1, 0),
(3, 'Ankit', 'Surat', '98', 1, 0),
(4, 'Kato', 'Kuch', '98', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `productcategory`
--

CREATE TABLE `productcategory` (
  `cpid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `desc` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `productcategory`
--

INSERT INTO `productcategory` (`cpid`, `name`, `desc`) VALUES
(1, 'Oil', 'Food Oil'),
(2, 'Nasta', 'Snack'),
(3, 'FastFood', 'Evening Snacks');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `pid` int(11) NOT NULL,
  `pname` varchar(50) NOT NULL,
  `cpid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `costprice` int(11) NOT NULL,
  `sellingprice` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `image` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`pid`, `pname`, `cpid`, `quantity`, `costprice`, `sellingprice`, `status`, `image`) VALUES
(1, 'Vimal', 1, 10, 1000, 1200, 1, ''),
(2, 'Tea', 2, 10, 160, 300, 1, ''),
(3, 'Maggi', 3, 100, 40, 45, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `selling`
--

CREATE TABLE `selling` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `selling`
--

INSERT INTO `selling` (`id`, `cid`, `pid`, `quantity`, `rate`, `date`, `amount`) VALUES
(1, 1, 1, 10, 1200, '2020-07-20', 1200),
(2, 1, 1, 5, 1000, '0000-00-00', 5000);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `sid` int(11) NOT NULL,
  `sname` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `gender` int(11) NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`sid`, `sname`, `address`, `contact`, `gender`, `balance`) VALUES
(1, 'Kabo', 'SK', '98', 1, 0),
(2, 'Prince', 'SK', '98', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `supplying`
--

CREATE TABLE `supplying` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplying`
--

INSERT INTO `supplying` (`id`, `pid`, `sid`, `quantity`, `rate`, `date`, `amount`) VALUES
(1, 1, 1, 100, 1000, '2020-07-20', 100000),
(2, 2, 2, 100, 40, '2020-07-20', 1200),
(3, 1, 1, 4, 5000, '0000-00-00', 10000),
(4, 1, 1, 4, 1000, '0000-00-00', 4000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `productcategory`
--
ALTER TABLE `productcategory`
  ADD PRIMARY KEY (`cpid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `cpid` (`cpid`);

--
-- Indexes for table `selling`
--
ALTER TABLE `selling`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cid` (`cid`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `supplying`
--
ALTER TABLE `supplying`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `sid` (`sid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `productcategory`
--
ALTER TABLE `productcategory`
  MODIFY `cpid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `selling`
--
ALTER TABLE `selling`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplying`
--
ALTER TABLE `supplying`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`cpid`) REFERENCES `productcategory` (`cpid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `selling`
--
ALTER TABLE `selling`
  ADD CONSTRAINT `selling_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `selling_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `products` (`pid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `supplying`
--
ALTER TABLE `supplying`
  ADD CONSTRAINT `supplying_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `products` (`pid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `supplying_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `supplier` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
