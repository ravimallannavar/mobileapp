-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2020 at 03:25 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbcom`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteAddressProofMaster` (IN `AddressProofId_` BIGINT)  UPDATE tbladdressproofmaster SET AddRemove='D' WHERE AddressProofId=AddressProofId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteAssetUsageTypeMaster` (IN `AssetsUsageTypeMasterId_` BIGINT)  UPDATE tblassetsusagetypemaster SET AddRemove='D' WHERE AssetsUsageTypeMasterId=AssetsUsageTypeMasterId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteDepMaster` (IN `DeptMasterId_` BIGINT)  UPDATE tbldepartmentmaster SET AddRemove='D' WHERE DeptMasterId=DeptMasterId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteMakeMaster` (IN `MakeId_` BIGINT)  UPDATE tblmakemaster SET AddRemove='D' WHERE MakeId=MakeId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeletePlantMaster` (IN `PlantId_` BIGINT)  UPDATE tblplantmaster SET AddRemove='D' WHERE PlantId=PlantId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAddressProofMasterDetails` ()  SELECT * FROM tbladdressproofmaster$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAllMastersDetailsUsingName` (IN `Id_` BIGINT)  BEGIN
    IF Id_ = 1 THEN
      SELECT * FROM tbladdressproofmaster;
	ELSEIF Id_ = 2 THEN
		SELECT * FROM tblassetsusagetypemaster;
	ELSEIF Id_ = 3 THEN
		SELECT * FROM tbldepartmentmaster;
	ELSEIF Id_ = 4 THEN
		SELECT * FROM tblplantmaster;
	ELSEIF Id_ = 5 THEN
		SELECT * FROM tblmakemaster;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAllMastersName` ()  SELECT * FROM tblallmasters$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetAssetsUsageMasterDetails` ()  SELECT * FROM tblassetsusagetypemaster$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetDeptMasterDetails` ()  SELECT * FROM tbldepartmentmaster$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetFilterDetails` ()  SELECT *FROM filterdata$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetLoginDetails` (IN `UserId_` VARCHAR(130), IN `Pwd_` VARCHAR(20))  BEGIN
    DECLARE LoginStatus int;
 
    SET LoginStatus = (
SELECT COUNT(EmailId) FROM tblloginmaster WHERE (EmailId = UserId_ or ContactNo = UserId_ ) AND Pwd = Pwd_
);
 
    IF LoginStatus > 0 THEN
    	SELECT * FROM tblloginmaster WHERE (EmailId = UserId_ or ContactNo = UserId_ ) AND Pwd = Pwd_;
    ELSE
    SELECT 'User not Exist' as Result;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetMake` ()  SELECT * FROM tblmakemaster$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetMfgPhyBalId` (IN `Id_` VARCHAR(5))  BEGIN
    IF Id_ ='Mfg' THEN
      SELECT MM.MfgMasterId, MM.SerialNo as SerialNoInShort,
(CASE
    WHEN MM.SerialNo = 'Y' THEN "Ok" 
    WHEN MM.SerialNo = 'N' THEN "Not OK" 
END) AS SerialNoInLong
FROM tblmfgmaster as MM;
ELSEIF Id_ ='Phy' THEN
SELECT PM.PhyAssetMasterId, PM.SerialNo as SerialNoInShort,
(CASE
    WHEN PM.SerialNo = 'Y' THEN "Ok" 
    WHEN PM.SerialNo = 'N' THEN "Not OK" 
END) AS SerialNoInLong
FROM tblphyassetmaster as PM;
ELSEIF Id_ ='Bal' THEN
SELECT BM.BalMisAssetMasterId, BM.SerialNo as SerialNoInShort,
(CASE
    WHEN BM.SerialNo = 'Y' THEN "Ok" 
    WHEN BM.SerialNo = 'N' THEN "Not OK" 
END) AS SerialNoInLong
FROM tblbalmisassetmaster as BM;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetPlantDeptNameList` ()  SELECT AM.AssetsMasterId, AM.PlantId, AM.DeptMasterId, PM.PlantName, DM.DeptName 
from tblassetsmaster as AM
LEFT OUTER JOIN tblplantmaster as PM
ON PM.PlantId = AM.PlantId
Left OUTER JOIN tbldepartmentmaster as DM
ON DM.DeptMasterId = AM.DeptMasterId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetPlantMasterDetails` ()  SELECT *FROM tblplantmaster$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAddressProofMaster` (IN `Title_` VARCHAR(15))  INSERT INTO tbladdressproofmaster (Title) VALUES (Title_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAssetsDetails` (IN `MakeId_` BIGINT, IN `AssetsMasterId_` BIGINT, IN `PhysicalAssetsId_` CHAR(1), IN `AssetId_` CHAR(1), IN `ModelNo_` VARCHAR(15), IN `MfgSerialNo_` VARCHAR(15), IN `MfgSerialNoInWord_` VARCHAR(120), IN `BALMisId_` VARCHAR(100), IN `BALMisIdChar_` CHAR(1), IN `MonitorSerialNo_` VARCHAR(15), IN `MonitorSerialNoInWord_` VARCHAR(120), IN `FloorNo_` VARCHAR(3), IN `RoomName_` VARCHAR(15), IN `ShopName_` VARCHAR(120), IN `Landmark_` VARCHAR(120))  BEGIN
/*DECLARE AssetsMasterId_ int;

SET AssetsMasterId_ = (SELECT AssetsMasterId FROM tblassetsmaster AS AM WHERE AM.PlantId = PlantId_ AND AM.DeptMasterId = DeptMasterId_);

SELECT AssetsMasterId_;*/

INSERT INTO tblassetsdetails (MakeId , AssetsMasterId , PhysicalAssetsId , AssetId , ModelNo , MfgSerialNo , MfgSerialNoInWord , BALMisId , BALMisIdChar , MonitorSerialNo , MonitorSerialNoInWord,FloorNo,RoomName,ShopName,Landmark)
VALUES
(
    MakeId_ , AssetsMasterId_ , PhysicalAssetsId_ , AssetId_ , ModelNo_ , MfgSerialNo_ , MfgSerialNoInWord_ , BALMisId_ , BALMisIdChar_ , MonitorSerialNo_ , MonitorSerialNoInWord_,FloorNo_,RoomName_,ShopName_,Landmark_);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAssetsMaster` (IN `PlantId_` BIGINT, IN `DeptMasterId_` BIGINT)  BEGIN
    DECLARE AssetCount int;
 
    SET AssetCount = (SELECT COUNT(PlantId) FROM tblassetsmaster WHERE PlantId=PlantId_ AND DeptMasterId=DeptMasterId_);
 
    IF AssetCount > 0 THEN
    	SELECT 'Already Exist' as Result;
    ELSE
    	INSERT INTO tblassetsmaster (PlantId, DeptMasterId)VALUES(PlantId_ ,DeptMasterId_);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAssetsPhysical` (IN `PhysicalId_` BIGINT, IN `AssetsId_` BIGINT, IN `FloorNo_` VARCHAR(120), IN `RoomName_` VARCHAR(130))  INSERT INTO tblassetsphysical (PhysicalId , AssetsId , FloorNo , RoomName)
VALUES (PhysicalId_ , AssetsId_ , FloorNo_ , RoomName_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAssetsPhysicalMaster` (IN `AssetsId_` BIGINT, IN `AssetsPlant_` VARCHAR(130), IN `AssetsDepartment_` VARCHAR(120), IN `ShopName_` VARCHAR(120), IN `Landmark_` VARCHAR(120))  INSERT INTO tblassetsphysicalmaster (AssetsId , AssetsPlant , AssetsDepartment , ShopName , Landmark) VALUES (AssetsId_ , AssetsPlant_ , AssetsDepartment_ , ShopName_ , Landmark_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAssetsUsageType` (IN `MakeId_` BIGINT, IN `VendorPersonName_` VARCHAR(130), IN `VendorCompanyName_` VARCHAR(130), IN `AssetsUsageTypeMasterId_` BIGINT, IN `VendorTeamPurpose_` VARCHAR(140))  NO SQL
INSERT INTO tblvendormaster(MakeId,VendorPersonName,VendorCompanyName,AssetsUsageTypeMasterId,VendorTeamPurpose)VALUES(MakeId_,VendorPersonName_,VendorCompanyName_,AssetsUsageTypeMasterId_,VendorTeamPurpose_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertAssetUsageTypeMaster` (IN `Title_` VARCHAR(20))  INSERT into tblassetsusagetypemaster  (Title) VALUES (Title_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertBalUserDetailsMaster` (IN `AssetsMasterId_` BIGINT, IN `OwnerName_` VARCHAR(130), IN `OwnerTicketNo_` VARCHAR(120), IN `BalUserName_` VARCHAR(120), IN `BalTicketNo_` VARCHAR(120))  INSERT INTO tblbaluserdetailsmaster(AssetsMasterId,OwnerName,OwnerTicketNo,BalUserName,BalTicketNo)
VALUES(AssetsMasterId_,OwnerName_,OwnerTicketNo_,BalUserName_,BalTicketNo_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertDepMaster` (IN `DeptName_` VARCHAR(13))  INSERT INTO tbldepartmentmaster(DeptName) VALUES(DeptName_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertDept` (IN `AssetsPlantId_` BIGINT, IN `DeptMasterId_` BIGINT)  BEGIN
DECLARE DeptCount int;
 
    SET DeptCount = (SELECT COUNT(AM.AssetsMasterId) as DeptCount FROM tblassetsmaster as AM WHERE AM.AssetsPlantId = AssetsPlantId_ and AM.DeptMasterId = DeptMasterId_);
 
    IF DeptCount > 0 THEN
        SELECT 'Already Exist' as Result;
    ELSE
    	INSERT INTO tblassetsmaster(AssetsPlantId, DeptMasterId) VALUES (AssetsPlantId_, DeptMasterId_);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertEmpDetails` (IN `LoginId_` BIGINT(20), IN `EmpSignature_` TEXT, IN `EmpDate_` DATE, IN `EmpRemark_` VARCHAR(120), IN `EmpName_` VARCHAR(130))  insert into tblempdetails (LoginId,EmpSignature,EmpDate,EmpRemark,EmpName) VALUES(LoginId_,EmpSignature_,EmpDate_,EmpRemark_,EmpName_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertEngineerDetails` (IN `EngName_` VARCHAR(130), IN `EngSignature_` TEXT, IN `EngDate_` DATE, IN `EngRemark_` VARCHAR(120), IN `LoginId_` BIGINT)  INSERT INTO tblengineerdetails (EngName,EngSignature,EngDate,EngRemark, LoginId) VALUES (EngName_,EngSignature_,EngDate_,EngRemark_, LoginId_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertLoginMaster` (IN `AddressProofId_` BIGINT, IN `FullName_` VARCHAR(120), IN `EmailId_` VARCHAR(130), IN `ContactNo_` VARCHAR(10), IN `Address_` VARCHAR(200), IN `Pincode_` VARCHAR(8), IN `Pwd_` VARCHAR(20))  INSERT INTO tblloginmaster 
( AddressProofId , EmailId ,FullName , ContactNo  , Address , PinCode , Pwd)
VALUES
(AddressProofId_ , EmailId_ , FullName_ , ContactNo_  , Address_ , Pincode_ , Pwd_ )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertMakeMaster` (IN `ModelName_` VARCHAR(30), IN `ModelNumber_` VARCHAR(40))  INSERT INTO tblmakemaster(ModelName , ModelNumber) VALUES(ModelName_ , ModelNumber_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertPlantMaster` (IN `PlantName_` VARCHAR(12))  INSERT INTO tblplantmaster(PlantName) VALUES (PlantName_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertVendorMaster` (IN `MakeId_` BIGINT, IN `VendorPersonName_` VARCHAR(130), IN `VendorCompanyName_` VARCHAR(130), IN `AssetsUsageTypeMasterId_` VARCHAR(120), IN `VendorTeamPurpose_` VARCHAR(140))  INSERT INTO tblvendormaster(MakeId,VendorPersonName,VendorCompanyName,AssetsUsageTypeMasterId,VendorTeamPurpose)VALUES(MakeId_,VendorPersonName_,VendorCompanyName_,AssetsUsageTypeMasterId_,VendorTeamPurpose_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateAddressProofMaster` (IN `AddressProofId_` BIGINT(20), IN `Title_` VARCHAR(15))  update tbladdressproofmaster SET Title=Title_ where AddressProofId=AddressProofId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateAssetUsageTypeMaster` (IN `AssetsUsageTypeMasterId_` BIGINT, IN `Title_` VARCHAR(20))  update tblassetsusagetypemaster SET Title=Title_ where AssetsUsageTypeMasterId=AssetsUsageTypeMasterId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateDepMaster` (IN `DeptMasterId_` BIGINT, IN `DeptName_` VARCHAR(13))  update tbldepartmentmaster SET DeptName=DeptName_ where DeptMasterId=DeptMasterId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateMakeMaster` (IN `MakeId_` BIGINT, IN `ModelName_` VARCHAR(30), IN `ModelNumber_` VARCHAR(20))  UPDATE tblmakemaster SET ModelName = ModelName_ , ModelNumber = ModelNumber_ 
WHERE MakeId = MakeId_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdatePlantMaster` (IN `PlantId_` BIGINT, IN `PlantName_` VARCHAR(30))  UPDATE tblplantmaster SET PlantName = PlantName_ WHERE PlantId = PlantId_$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `filterdata`
--

CREATE TABLE `filterdata` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `place` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `filterdata`
--

INSERT INTO `filterdata` (`id`, `name`, `start_date`, `end_date`, `place`) VALUES
(1, 'ravi', '2020-04-01', '2020-04-04', 'belagavi'),
(2, 'vhgch', '2020-04-09', '2020-04-17', 'jhghgfhg'),
(3, 'abc', '2019-12-03', '2020-04-09', 'kjhj'),
(4, 'demo', '2010-04-01', '2020-05-08', 'yuytuyt');

-- --------------------------------------------------------

--
-- Table structure for table `tbladdressproofmaster`
--

CREATE TABLE `tbladdressproofmaster` (
  `AddressProofId` bigint(20) NOT NULL,
  `Title` varchar(15) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbladdressproofmaster`
--

INSERT INTO `tbladdressproofmaster` (`AddressProofId`, `Title`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Pancard', '2020-02-21 14:06:18', 'A'),
(2, 'Adharcard', '2020-02-21 14:06:59', 'A'),
(3, 'Licence', '2020-02-21 14:09:45', 'A'),
(4, 'lkjjk', '2020-03-06 10:07:06', 'A'),
(5, '109', '2020-03-06 10:09:39', 'A'),
(6, '109', '2020-03-06 10:10:14', 'A'),
(7, '', '2020-03-06 10:10:34', 'A'),
(8, '', '2020-03-06 10:10:34', 'A'),
(9, '', '2020-03-06 10:11:03', 'A'),
(10, '', '2020-03-06 10:12:06', 'A'),
(11, '', '2020-03-06 10:12:20', 'A'),
(12, '', '2020-03-06 10:13:13', 'A'),
(13, '', '2020-03-06 10:15:48', 'A'),
(14, 'demo', '2020-03-06 10:17:44', 'A'),
(15, 'demo', '2020-03-06 10:18:46', 'A'),
(16, '123', '2020-03-06 10:19:45', 'A'),
(17, '123', '2020-03-06 10:20:08', 'A'),
(18, 'abc', '2020-03-06 10:21:53', 'A'),
(19, '', '2020-03-06 10:53:07', 'A'),
(20, 'ravi', '2020-03-06 10:53:07', 'A'),
(21, 'ravi', '2020-03-06 10:53:20', 'A'),
(22, '', '2020-03-06 11:14:17', 'A'),
(23, 'demo100', '2020-03-06 11:14:17', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblallmasters`
--

CREATE TABLE `tblallmasters` (
  `MasterId` bigint(20) NOT NULL,
  `MasterTitle` varchar(22) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblallmasters`
--

INSERT INTO `tblallmasters` (`MasterId`, `MasterTitle`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Address Proof', '2020-03-04 15:16:34', 'A'),
(2, 'Assets Usage Type', '2020-03-04 15:17:11', 'A'),
(3, 'Department', '2020-03-04 15:17:11', 'A'),
(4, 'Plant', '2020-03-04 15:17:25', 'A'),
(5, 'Make', '2020-03-04 15:17:25', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblassetsdetails`
--

CREATE TABLE `tblassetsdetails` (
  `AssetDetailsId` bigint(20) NOT NULL,
  `MakeId` bigint(20) NOT NULL,
  `AssetsMasterId` bigint(20) NOT NULL,
  `PhysicalAssetsId` char(1) NOT NULL DEFAULT 'Y',
  `AssetId` char(1) NOT NULL DEFAULT 'Y',
  `ModelNo` varchar(15) NOT NULL,
  `MfgSerialNo` varchar(15) NOT NULL,
  `MfgSerialNoInWord` varchar(120) NOT NULL,
  `BALMisId` varchar(100) NOT NULL,
  `BALMisIdChar` char(1) NOT NULL DEFAULT 'A',
  `MonitorSerialNo` varchar(15) NOT NULL,
  `MonitorSerialNoInWord` varchar(120) NOT NULL,
  `FloorNo` varchar(3) NOT NULL,
  `RoomName` varchar(15) NOT NULL,
  `ShopName` varchar(120) NOT NULL,
  `Landmark` varchar(120) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblassetsdetails`
--

INSERT INTO `tblassetsdetails` (`AssetDetailsId`, `MakeId`, `AssetsMasterId`, `PhysicalAssetsId`, `AssetId`, `ModelNo`, `MfgSerialNo`, `MfgSerialNoInWord`, `BALMisId`, `BALMisIdChar`, `MonitorSerialNo`, `MonitorSerialNoInWord`, `FloorNo`, `RoomName`, `ShopName`, `Landmark`, `CurrentDate`, `AddRemove`) VALUES
(29, 5, 113, '1', '1', 'fdsfsd', 'dsfsdfsdf', 'gfdgdfgd', 'fghfghfg', '2', 'hgfhfghfgh', 'fghfghfg', '', '', '', '', '2020-03-02 13:24:14', 'A'),
(30, 1, 113, '2', '2', 'fgfgdf', 'jghhjh', 'hlkljhk', '998089tuyt', '1', 'gfdgdfgdf', 'hfghfghfg', '', '', '', '', '2020-03-02 16:14:42', 'A'),
(31, 2, 126, '2', '1', 'sf', 'ghfghg', 'jhgjghjhg', 'hgfgghdfg', '1', 'gdfgdsf', 'ghjghjgh', '', '', '', '', '2020-03-02 16:28:55', 'A'),
(33, 5, 117, '1', '1', 'A', 'B', 'C', 'D', '2', 'E', 'F', '', '', '', '', '2020-03-02 16:36:37', 'A'),
(34, 4, 126, '2', '1', 'a', 'B', 'C', 'D', '2', 'E', 'F', 'G', 'H', 'I', 'J', '2020-03-02 16:44:00', 'A'),
(35, 1, 117, '1', '1', '', 'sdf', 'df', 'dfdf', '2', 'gfhfghfg', 'jhgjgfh', 'ghd', 'ghjghjggh', 'dfgdfgd', 'dfgdfgfd', '2020-03-02 16:47:14', 'A'),
(36, 2, 116, '2', '2', 'sfds', 'sdfsdfse', 'gdfgdf', 'dfgdfgd', '1', 'gfdgdf', 'hfghfg', 'fgh', 'fghfg', 'hfghfg', 'fghfghgf', '2020-03-02 16:48:22', 'A'),
(37, 1, 115, '2', '2', 'fdsf', 'sdfsdfgsdfsd', 'gfdf', 'fdgdf', '1', 'gdfgdf', 'dfgdf', 'fdg', 'fdgdf', 'dfgdf', 'dfgdf', '2020-03-05 11:49:49', 'A'),
(38, 2, 116, '2', '1', 'd', 'h', 'fsdfsd', 'sdfdsf', '1', 'gfh', 'ghfghgf', '4', 'rrr', 'gg', 'fff', '2020-03-05 11:54:49', 'A'),
(39, 17, 113, 'Y', 'Y', '10', '10', '100', '10', 'A', '10000', '1000000', '1', 'nb', 'vnbvnb', 'bvnbvnbv', '2020-04-16 15:32:45', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblassetsmaster`
--

CREATE TABLE `tblassetsmaster` (
  `AssetsMasterId` bigint(20) NOT NULL,
  `PlantId` bigint(20) NOT NULL,
  `DeptMasterId` bigint(20) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblassetsmaster`
--

INSERT INTO `tblassetsmaster` (`AssetsMasterId`, `PlantId`, `DeptMasterId`, `CurrentDate`, `AddRemove`) VALUES
(113, 1, 1, '2020-02-24 16:43:18', 'A'),
(114, 2, 1, '2020-02-24 16:43:18', 'A'),
(115, 1, 3, '2020-02-24 17:26:00', 'A'),
(116, 2, 2, '2020-02-27 11:38:58', 'A'),
(117, 2, 2, '2020-02-27 11:39:17', 'A'),
(119, 2, 3, '2020-02-27 11:54:02', 'A'),
(120, 2, 5, '2020-02-27 11:54:32', 'A'),
(124, 3, 2, '2020-02-27 12:14:15', 'A'),
(125, 3, 4, '2020-02-27 12:16:41', 'A'),
(126, 3, 3, '2020-02-27 12:17:47', 'A'),
(129, 2, 4, '2020-03-05 11:22:49', 'A'),
(134, 1, 2, '2020-03-11 10:48:51', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblassetsusagetypemaster`
--

CREATE TABLE `tblassetsusagetypemaster` (
  `AssetsUsageTypeMasterId` bigint(20) NOT NULL,
  `Title` varchar(20) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblassetsusagetypemaster`
--

INSERT INTO `tblassetsusagetypemaster` (`AssetsUsageTypeMasterId`, `Title`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Common', '2020-02-27 13:39:09', 'A'),
(2, 'Vendor', '2020-02-27 13:39:09', 'A'),
(3, 'test', '2020-03-06 10:24:57', 'A'),
(4, 'test', '2020-03-06 10:25:42', 'A'),
(5, '', '2020-03-06 10:53:39', 'A'),
(6, 'ravi', '2020-03-06 10:53:39', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblbalmisassetmaster`
--

CREATE TABLE `tblbalmisassetmaster` (
  `BalMisAssetMasterId` bigint(20) NOT NULL,
  `SerialNo` char(1) NOT NULL DEFAULT 'Y',
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbalmisassetmaster`
--

INSERT INTO `tblbalmisassetmaster` (`BalMisAssetMasterId`, `SerialNo`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Y', '2020-02-28 17:40:50', 'A'),
(2, 'N', '2020-02-28 17:40:50', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblbaluserdetailsmaster`
--

CREATE TABLE `tblbaluserdetailsmaster` (
  `BalId` bigint(20) NOT NULL,
  `AssetsMasterId` bigint(20) NOT NULL,
  `OwnerName` varchar(130) NOT NULL,
  `OwnerTicketNo` varchar(120) NOT NULL,
  `BalUserName` varchar(120) NOT NULL,
  `BalTicketNo` varchar(120) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbaluserdetailsmaster`
--

INSERT INTO `tblbaluserdetailsmaster` (`BalId`, `AssetsMasterId`, `OwnerName`, `OwnerTicketNo`, `BalUserName`, `BalTicketNo`, `CurrentDate`, `AddRemove`) VALUES
(9, 113, 'fsdfsd', 'fdsfsd', 'sdfsdfsd', 'dsfsdfsdf', '2020-02-27 17:43:29', 'A'),
(10, 115, '1', '1', '1', '1', '2020-02-27 17:44:35', 'A'),
(17, 114, 'dsafdsfs', 'new', 'data', 'tt', '2020-02-27 18:06:38', 'A'),
(19, 115, 'kiik', '8585', 'uiu', '966', '2020-02-28 09:47:52', 'A'),
(21, 125, 'dggh', '789', 'gffg', '345', '2020-03-05 09:56:15', 'A'),
(25, 114, 'dsfsdf', 'fgsdfsd', 'gdgdf', 'gfdgdfgdf', '2020-03-05 11:38:13', 'A'),
(26, 114, 'vcxvcx', 'cxvxcv', 'cxvxcv', 'cxvcxcv', '2020-03-05 11:38:59', 'A'),
(27, 115, 'sfcsdfs', 'sdfsdf', 'gffsdgdf', 'fgdfgdf', '2020-03-05 11:39:41', 'A'),
(28, 115, 'sfcsdfs', 'sdfsdf', 'gffsdgdf', 'fgdfgdf', '2020-03-05 11:40:36', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartmentmaster`
--

CREATE TABLE `tbldepartmentmaster` (
  `DeptMasterId` bigint(20) NOT NULL,
  `DeptName` varchar(13) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbldepartmentmaster`
--

INSERT INTO `tbldepartmentmaster` (`DeptMasterId`, `DeptName`, `CurrentDate`, `AddRemove`) VALUES
(1, 'IT', '2020-02-24 16:40:29', 'A'),
(2, 'Testing', '2020-02-24 16:40:29', 'A'),
(3, 'Marketing', '2020-02-24 16:40:51', 'A'),
(4, 'Accountant', '2020-02-24 16:40:51', 'A'),
(5, 'HR', '2020-02-24 16:41:05', 'A'),
(6, '', '2020-03-06 10:29:53', 'A'),
(7, 'dept1', '2020-03-06 10:29:53', 'A'),
(8, 'dept1', '2020-03-06 10:30:52', 'A'),
(9, '', '2020-03-06 10:54:19', 'A'),
(10, 'ravi', '2020-03-06 10:54:19', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblempdetails`
--

CREATE TABLE `tblempdetails` (
  `EmpId` bigint(20) NOT NULL,
  `LoginId` bigint(20) NOT NULL,
  `EmpName` varchar(130) NOT NULL,
  `EmpSignature` text NOT NULL,
  `EmpDate` date NOT NULL,
  `EmpRemark` varchar(120) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblempdetails`
--

INSERT INTO `tblempdetails` (`EmpId`, `LoginId`, `EmpName`, `EmpSignature`, `EmpDate`, `EmpRemark`, `CurrentDate`, `AddRemove`) VALUES
(3, 1, 'fdsfsafda', 'C:fakepathindex.html', '2020-02-26', 'fdsfds', '2020-02-26 16:51:58', 'A'),
(5, 1, 'fsdsdfsd', 'C:fakepathdbcomputer.sql', '2020-02-27', 'dfssdfs', '2020-02-27 10:29:26', 'A'),
(25, 1, 'chandani', 'C:fakepathprofiles.info', '2020-03-05', 'good', '2020-03-05 09:52:26', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblengineerdetails`
--

CREATE TABLE `tblengineerdetails` (
  `EngId` bigint(20) NOT NULL,
  `LoginId` bigint(20) NOT NULL,
  `EngName` varchar(130) NOT NULL,
  `EngSignature` text NOT NULL,
  `EngDate` date NOT NULL,
  `EngRemark` varchar(120) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblengineerdetails`
--

INSERT INTO `tblengineerdetails` (`EngId`, `LoginId`, `EngName`, `EngSignature`, `EngDate`, `EngRemark`, `CurrentDate`, `AddRemove`) VALUES
(42, 1, 'pooja123', 'image.png', '2020-01-02', 'yes', '2020-02-21 16:45:15', 'A'),
(43, 0, '', '', '0000-00-00', '', '2020-02-21 16:46:45', 'A'),
(44, 1, 'pooja123', 'image.png', '2020-01-02', 'yes', '2020-02-21 16:47:24', 'A'),
(45, 0, 'ffdgdsfgdsf', 'C:fakepathwelcome.png', '2020-02-21', 'hfghfghf', '2020-02-21 16:50:12', 'A'),
(46, 0, '', '', '0000-00-00', '', '2020-02-26 18:26:12', 'A'),
(47, 0, '', '', '2020-02-26', '', '2020-02-26 18:26:12', 'A'),
(48, 0, '', '', '0000-00-00', '', '2020-02-27 10:29:48', 'A'),
(49, 1, 'fsdfsdaf', 'C:fakepathdbcomputer_old.sql', '2020-02-27', 'ghfghfg', '2020-02-27 10:29:48', 'A'),
(50, 0, '', '', '0000-00-00', '', '2020-03-05 09:53:05', 'A'),
(51, 1, 'pooja', 'C:fakepathprofiles.info', '2020-03-05', 'good', '2020-03-05 09:53:05', 'A'),
(53, 1, 'pooja', 'C:fakepathprofiles.info', '2020-03-05', 'good', '2020-03-05 10:08:29', 'A'),
(54, 0, '', '', '0000-00-00', '', '2020-03-05 10:46:24', 'A'),
(55, 1, 'hj', 'C:fakepathprofiles.info', '2020-03-05', 'gfhh', '2020-03-05 10:46:24', 'A'),
(56, 1, 'hj', 'C:fakepathprofiles.info', '2020-03-05', 'gfhh', '2020-03-05 10:46:25', 'A'),
(57, 1, 'gh', 'C:fakepathprofiles.info', '2020-03-05', 'hgjj', '2020-03-05 10:49:03', 'A'),
(58, 1, 'gh', 'C:fakepathprofiles.info', '2020-03-05', 'hgjj', '2020-03-05 10:49:04', 'A'),
(59, 1, 'gh', 'C:fakepathprofiles.info', '2020-03-05', 'hgjj', '2020-03-05 10:49:12', 'A'),
(60, 1, 'gvhh', 'C:fakepathprofiles.info', '2020-03-05', 'uijiji', '2020-03-05 10:49:34', 'A'),
(61, 1, 'hj', 'C:fakepathpools.info', '2020-03-05', 'hjh', '2020-03-05 10:50:12', 'A'),
(62, 0, '', '', '0000-00-00', '', '2020-03-05 11:10:53', 'A'),
(63, 1, 'sdfsdfs', 'C:fakepathprofiles.info', '2020-03-05', 'fsdfsdfs', '2020-03-05 11:10:53', 'A'),
(64, 0, 'dsfsd', 'sdfsdf', '2020-03-24', 'sdds', '2020-03-05 11:13:29', 'A'),
(65, 1, 'sdfsdfs', 'C:fakepathprofiles.info', '2020-03-05', 'fsdfsdfs', '2020-03-05 11:14:53', 'A'),
(66, 1, 'gfgsdfsd', 'C:fakepathprofiles.info', '2020-03-05', 'dfgdf', '2020-03-05 11:15:20', 'A'),
(67, 1, 'gfgsdfsd', 'C:fakepathprofiles.info', '2020-03-05', 'dfgdf', '2020-03-05 11:16:10', 'A'),
(68, 1, 'gfgsdfsd', 'C:fakepathprofiles.info', '2020-03-05', 'dfgdf', '2020-03-05 11:17:17', 'A'),
(69, 0, '4', 'A', '0000-00-00', 'B', '2020-03-05 11:18:28', 'A'),
(70, 1, 'gfgsdfsd', 'C:fakepathprofiles.info', '2020-03-05', 'dfgdf', '2020-03-05 11:18:44', 'A'),
(71, 1, 'gfgsdfsd', 'C:fakepathprofiles.info', '2020-03-05', 'dfgdf', '2020-03-05 11:20:07', 'A'),
(72, 1, 'gfgsdfsd', 'C:fakepathprofiles.info', '2020-03-05', 'dfgdf', '2020-03-05 11:21:03', 'A'),
(73, 0, '', '', '0000-00-00', '', '2020-03-11 10:28:06', 'A'),
(74, 0, 'hgtyf', 'C:fakepathIMG_20181219_090005.jpg', '2020-03-11', '10', '2020-03-11 10:28:06', 'A'),
(75, 5, 'demo', 'C:fakepathIMG_20181218_182102.jpg', '2020-03-11', '10', '2020-03-11 10:29:05', 'A'),
(76, 5, 'demo', 'C:fakepathIMG_20181219_091744.jpg', '2020-03-11', '10', '2020-03-11 10:32:28', 'A'),
(77, 0, '', '', '0000-00-00', '', '2020-03-11 10:57:29', 'A'),
(78, 5, 'demo1', 'C:fakepathIMG_20181219_084645.jpg', '0000-00-00', '100', '2020-03-11 10:57:29', 'A'),
(79, 5, 'test', 'C:fakepathIMG_20181218_175454.jpg', '2020-03-11', '100', '2020-03-11 10:58:01', 'A'),
(80, 5, 'demo101', 'C:fakepathIMG_20181219_091038.jpg', '2020-03-11', '10', '2020-03-11 11:07:21', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblloginmaster`
--

CREATE TABLE `tblloginmaster` (
  `LoginId` bigint(20) NOT NULL,
  `AddressProofId` bigint(20) NOT NULL,
  `FullName` varchar(120) NOT NULL,
  `EmailId` varchar(130) NOT NULL,
  `ContactNo` varchar(10) NOT NULL,
  `Address` varchar(200) NOT NULL,
  `Pincode` varchar(8) NOT NULL,
  `Pwd` varchar(20) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblloginmaster`
--

INSERT INTO `tblloginmaster` (`LoginId`, `AddressProofId`, `FullName`, `EmailId`, `ContactNo`, `Address`, `Pincode`, `Pwd`, `CurrentDate`, `AddRemove`) VALUES
(1, 2, 'Kiran Divate', 'divate26@gmail.com', '9309183674', 'FLT NO 1807, WING H, ASAWARI, NANDED CITY, SINHAGAD RD, PUNE 411041', '411041', 'balaji88', '2020-02-26 16:51:40', 'A'),
(6, 1, 'asd', 'cgn@gmail', '123', 'rttyuyggfgby', '', '123', '2020-03-05 09:58:43', 'A'),
(37, 1, 'demo', 'dddd@gmail.com', '7879464513', 'hghgfhgf', '591444', '123', '2020-04-09 17:08:13', 'A'),
(39, 5, 'abc', 'abc@gmail.com', '8978455610', 'abcd', '591000', '123', '2020-04-09 18:17:56', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblmakemaster`
--

CREATE TABLE `tblmakemaster` (
  `MakeId` bigint(20) NOT NULL,
  `ModelName` varchar(30) NOT NULL,
  `ModelNumber` varchar(40) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblmakemaster`
--

INSERT INTO `tblmakemaster` (`MakeId`, `ModelName`, `ModelNumber`, `CurrentDate`, `AddRemove`) VALUES
(1, 'HP', 'HP1234', '2020-02-26 15:47:02', 'A'),
(2, 'Dell', 'Dell1234', '2020-02-27 12:21:33', 'A'),
(3, 'Sony', 'Sony1234', '2020-02-27 12:21:33', 'A'),
(4, 'Asus', 'Asus1234', '2020-02-27 12:21:52', 'A'),
(5, 'Apple', 'Apple1234', '2020-02-27 12:21:52', 'A'),
(6, '', '', '2020-03-05 17:44:05', 'A'),
(7, 'demo', '100', '2020-03-05 17:44:07', 'A'),
(8, 'demo', '100', '2020-03-05 17:46:07', 'A'),
(9, 'abc', '100', '2020-03-05 17:47:34', 'A'),
(10, 'abc', '100', '2020-03-05 17:48:11', 'A'),
(11, '', '', '2020-03-05 17:48:43', 'A'),
(12, '', '', '2020-03-05 17:50:16', 'A'),
(13, 'abc', '100', '2020-03-05 17:50:23', 'A'),
(14, 'abc', '100', '2020-03-05 17:51:49', 'A'),
(15, 'abc', '100', '2020-03-05 17:53:27', 'A'),
(17, '', '', '2020-03-06 10:48:50', 'A'),
(18, '', '', '2020-03-06 10:49:37', 'A'),
(19, '', '', '2020-03-06 10:49:54', 'A'),
(20, 'xyz', '1000', '2020-04-16 15:26:45', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblmfgmaster`
--

CREATE TABLE `tblmfgmaster` (
  `MfgMasterId` bigint(20) NOT NULL,
  `SerialNo` char(1) NOT NULL DEFAULT 'Y',
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblmfgmaster`
--

INSERT INTO `tblmfgmaster` (`MfgMasterId`, `SerialNo`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Y', '2020-02-28 16:58:32', 'A'),
(2, 'N', '2020-02-28 16:58:32', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblphyassetmaster`
--

CREATE TABLE `tblphyassetmaster` (
  `PhyAssetMasterId` bigint(20) NOT NULL,
  `SerialNo` char(1) NOT NULL DEFAULT 'Y',
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblphyassetmaster`
--

INSERT INTO `tblphyassetmaster` (`PhyAssetMasterId`, `SerialNo`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Y', '2020-02-28 17:26:26', 'A'),
(2, 'N', '2020-02-28 17:26:26', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblplantmaster`
--

CREATE TABLE `tblplantmaster` (
  `PlantId` bigint(20) NOT NULL,
  `PlantName` varchar(12) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblplantmaster`
--

INSERT INTO `tblplantmaster` (`PlantId`, `PlantName`, `CurrentDate`, `AddRemove`) VALUES
(1, 'Kothrud', '2020-02-24 16:38:15', 'A'),
(2, 'Anand Nagar', '2020-02-24 16:38:15', 'A'),
(3, 'Swarget', '2020-02-27 12:13:39', 'A'),
(4, 'Katraj', '2020-02-27 12:13:39', 'A'),
(5, 'Hadapsar', '2020-02-27 12:13:59', 'A'),
(7, '', '2020-03-06 10:51:36', 'A'),
(8, '', '2020-03-06 10:51:36', 'A'),
(9, 'p1', '2020-03-06 10:52:22', 'A'),
(10, 'ravi', '2020-03-06 10:54:54', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `tblvendormaster`
--

CREATE TABLE `tblvendormaster` (
  `VendorId` bigint(20) NOT NULL,
  `MakeId` bigint(20) NOT NULL,
  `AssetsUsageTypeMasterId` bigint(20) NOT NULL,
  `VendorPersonName` varchar(130) NOT NULL,
  `VendorCompanyName` varchar(130) NOT NULL,
  `VendorTeamPurpose` varchar(140) NOT NULL,
  `CurrentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddRemove` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblvendormaster`
--

INSERT INTO `tblvendormaster` (`VendorId`, `MakeId`, `AssetsUsageTypeMasterId`, `VendorPersonName`, `VendorCompanyName`, `VendorTeamPurpose`, `CurrentDate`, `AddRemove`) VALUES
(3, 3, 2, 'sdf', 'sd', 'gf', '2020-02-27 14:58:48', 'A'),
(4, 3, 2, 'fsdfsdf', 'fdgdfgdf', 'gfdgdfgdfd', '2020-02-27 15:04:05', 'A'),
(5, 2, 1, 'sdfsdf', 'dgfdgdf', 'dfgdfgdf', '2020-02-27 15:04:41', 'A'),
(6, 2, 1, 'sdfsdf', 'dgfdgdf', 'dfgdfgdf', '2020-02-27 15:04:42', 'A'),
(7, 3, 2, 'dsfsdf', 'dgdfgfd', 'gddfgdf', '2020-02-27 15:06:19', 'A'),
(9, 2, 1, 'fdsfs', 'gfdgdf', 'gdfgfdgdfgg', '2020-03-05 11:10:06', 'A'),
(10, 2, 1, 'SDFDSFSD', 'GFDGDSF', 'FGHGDFHFDSGDFGD', '2020-03-05 11:23:53', 'A');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `filterdata`
--
ALTER TABLE `filterdata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbladdressproofmaster`
--
ALTER TABLE `tbladdressproofmaster`
  ADD PRIMARY KEY (`AddressProofId`);

--
-- Indexes for table `tblallmasters`
--
ALTER TABLE `tblallmasters`
  ADD PRIMARY KEY (`MasterId`);

--
-- Indexes for table `tblassetsdetails`
--
ALTER TABLE `tblassetsdetails`
  ADD PRIMARY KEY (`AssetDetailsId`),
  ADD KEY `MakeId` (`MakeId`),
  ADD KEY `AssetsMasterId_FK` (`AssetsMasterId`);

--
-- Indexes for table `tblassetsmaster`
--
ALTER TABLE `tblassetsmaster`
  ADD PRIMARY KEY (`AssetsMasterId`),
  ADD KEY `PlantId_fk` (`PlantId`),
  ADD KEY `DeptMasterId_FK` (`DeptMasterId`);

--
-- Indexes for table `tblassetsusagetypemaster`
--
ALTER TABLE `tblassetsusagetypemaster`
  ADD PRIMARY KEY (`AssetsUsageTypeMasterId`);

--
-- Indexes for table `tblbalmisassetmaster`
--
ALTER TABLE `tblbalmisassetmaster`
  ADD PRIMARY KEY (`BalMisAssetMasterId`);

--
-- Indexes for table `tblbaluserdetailsmaster`
--
ALTER TABLE `tblbaluserdetailsmaster`
  ADD PRIMARY KEY (`BalId`),
  ADD KEY `AssetMasterId1_FK` (`AssetsMasterId`);

--
-- Indexes for table `tbldepartmentmaster`
--
ALTER TABLE `tbldepartmentmaster`
  ADD PRIMARY KEY (`DeptMasterId`);

--
-- Indexes for table `tblempdetails`
--
ALTER TABLE `tblempdetails`
  ADD PRIMARY KEY (`EmpId`),
  ADD KEY `LoginId_FK` (`LoginId`);

--
-- Indexes for table `tblengineerdetails`
--
ALTER TABLE `tblengineerdetails`
  ADD PRIMARY KEY (`EngId`);

--
-- Indexes for table `tblloginmaster`
--
ALTER TABLE `tblloginmaster`
  ADD PRIMARY KEY (`LoginId`),
  ADD KEY `AddressProofId_FK` (`AddressProofId`);

--
-- Indexes for table `tblmakemaster`
--
ALTER TABLE `tblmakemaster`
  ADD PRIMARY KEY (`MakeId`);

--
-- Indexes for table `tblmfgmaster`
--
ALTER TABLE `tblmfgmaster`
  ADD PRIMARY KEY (`MfgMasterId`);

--
-- Indexes for table `tblphyassetmaster`
--
ALTER TABLE `tblphyassetmaster`
  ADD PRIMARY KEY (`PhyAssetMasterId`);

--
-- Indexes for table `tblplantmaster`
--
ALTER TABLE `tblplantmaster`
  ADD PRIMARY KEY (`PlantId`);

--
-- Indexes for table `tblvendormaster`
--
ALTER TABLE `tblvendormaster`
  ADD PRIMARY KEY (`VendorId`),
  ADD KEY `Make_id_FK` (`MakeId`),
  ADD KEY `AssetsUsageTypeMasterId_FK` (`AssetsUsageTypeMasterId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `filterdata`
--
ALTER TABLE `filterdata`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbladdressproofmaster`
--
ALTER TABLE `tbladdressproofmaster`
  MODIFY `AddressProofId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tblallmasters`
--
ALTER TABLE `tblallmasters`
  MODIFY `MasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblassetsdetails`
--
ALTER TABLE `tblassetsdetails`
  MODIFY `AssetDetailsId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tblassetsmaster`
--
ALTER TABLE `tblassetsmaster`
  MODIFY `AssetsMasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `tblassetsusagetypemaster`
--
ALTER TABLE `tblassetsusagetypemaster`
  MODIFY `AssetsUsageTypeMasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tblbalmisassetmaster`
--
ALTER TABLE `tblbalmisassetmaster`
  MODIFY `BalMisAssetMasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblbaluserdetailsmaster`
--
ALTER TABLE `tblbaluserdetailsmaster`
  MODIFY `BalId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `tbldepartmentmaster`
--
ALTER TABLE `tbldepartmentmaster`
  MODIFY `DeptMasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tblempdetails`
--
ALTER TABLE `tblempdetails`
  MODIFY `EmpId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `tblengineerdetails`
--
ALTER TABLE `tblengineerdetails`
  MODIFY `EngId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `tblloginmaster`
--
ALTER TABLE `tblloginmaster`
  MODIFY `LoginId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tblmakemaster`
--
ALTER TABLE `tblmakemaster`
  MODIFY `MakeId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tblmfgmaster`
--
ALTER TABLE `tblmfgmaster`
  MODIFY `MfgMasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblphyassetmaster`
--
ALTER TABLE `tblphyassetmaster`
  MODIFY `PhyAssetMasterId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblplantmaster`
--
ALTER TABLE `tblplantmaster`
  MODIFY `PlantId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tblvendormaster`
--
ALTER TABLE `tblvendormaster`
  MODIFY `VendorId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblassetsdetails`
--
ALTER TABLE `tblassetsdetails`
  ADD CONSTRAINT `AssetsMasterId_FK` FOREIGN KEY (`AssetsMasterId`) REFERENCES `tblassetsmaster` (`AssetsMasterId`),
  ADD CONSTRAINT `MakeId` FOREIGN KEY (`MakeId`) REFERENCES `tblmakemaster` (`MakeId`);

--
-- Constraints for table `tblassetsmaster`
--
ALTER TABLE `tblassetsmaster`
  ADD CONSTRAINT `DeptMasterId_FK` FOREIGN KEY (`DeptMasterId`) REFERENCES `tbldepartmentmaster` (`DeptMasterId`),
  ADD CONSTRAINT `PlantId_fk` FOREIGN KEY (`PlantId`) REFERENCES `tblplantmaster` (`PlantId`);

--
-- Constraints for table `tblbaluserdetailsmaster`
--
ALTER TABLE `tblbaluserdetailsmaster`
  ADD CONSTRAINT `AssetMasterId1_FK` FOREIGN KEY (`AssetsMasterId`) REFERENCES `tblassetsmaster` (`AssetsMasterId`),
  ADD CONSTRAINT `AssetsId_FK` FOREIGN KEY (`AssetsMasterId`) REFERENCES `tblassetsmaster` (`AssetsMasterId`);

--
-- Constraints for table `tblempdetails`
--
ALTER TABLE `tblempdetails`
  ADD CONSTRAINT `LoginId_FK` FOREIGN KEY (`LoginId`) REFERENCES `tblloginmaster` (`LoginId`);

--
-- Constraints for table `tblloginmaster`
--
ALTER TABLE `tblloginmaster`
  ADD CONSTRAINT `AddressProofId_FK` FOREIGN KEY (`AddressProofId`) REFERENCES `tbladdressproofmaster` (`AddressProofId`);

--
-- Constraints for table `tblvendormaster`
--
ALTER TABLE `tblvendormaster`
  ADD CONSTRAINT `AssetsUsageTypeMasterId_FK` FOREIGN KEY (`AssetsUsageTypeMasterId`) REFERENCES `tblassetsusagetypemaster` (`AssetsUsageTypeMasterId`),
  ADD CONSTRAINT `Make_id_FK` FOREIGN KEY (`MakeId`) REFERENCES `tblmakemaster` (`MakeId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
