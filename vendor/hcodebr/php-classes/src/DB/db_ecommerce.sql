-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 19-Maio-2018 às 19:29
-- Versão do servidor: 5.7.19
-- PHP Version: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ecommerce`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_addresses_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addresses_save` (`pidaddress` INT(11), `pidperson` INT(11), `pdesaddress` VARCHAR(128), `pdesnumber` VARCHAR(16), `pdescomplement` VARCHAR(32), `pdescity` VARCHAR(32), `pdesstate` VARCHAR(32), `pdescountry` VARCHAR(32), `pdeszipcode` CHAR(8), `pdesdistrict` VARCHAR(32))  BEGIN

	IF pidaddress > 0 THEN
		
		UPDATE tb_addresses
        SET
			idperson = pidperson,
            desaddress = pdesaddress,
            desnumber = pdesnumber,
            descomplement = pdescomplement,
            descity = pdescity,
            desstate = pdesstate,
            descountry = pdescountry,
            deszipcode = pdeszipcode, 
            desdistrict = pdesdistrict
		WHERE idaddress = pidaddress;
        
    ELSE
		
		INSERT INTO tb_addresses (idperson, desaddress, desnumber, descomplement, descity, desstate, descountry, deszipcode, desdistrict)
        VALUES(pidperson, pdesaddress, pdesnumber, pdescomplement, pdescity, pdesstate, pdescountry, pdeszipcode, pdesdistrict);
        
        SET pidaddress = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_addresses WHERE idaddress = pidaddress;

END$$

DROP PROCEDURE IF EXISTS `sp_carts_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_carts_save` (`pidcart` INT, `pdessessionid` VARCHAR(64), `piduser` INT, `pdeszipcode` CHAR(8), `pvlfreight` DECIMAL(10,2), `pnrdays` INT)  BEGIN

    IF pidcart > 0 THEN
        
        UPDATE tb_carts
        SET
            dessessionid = pdessessionid,
            iduser = piduser,
            deszipcode = pdeszipcode,
            vlfreight = pvlfreight,
            nrdays = pnrdays
        WHERE idcart = pidcart;
        
    ELSE
        
        INSERT INTO tb_carts (dessessionid, iduser, deszipcode, vlfreight, nrdays)
        VALUES(pdessessionid, piduser, pdeszipcode, pvlfreight, pnrdays);
        
        SET pidcart = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_carts WHERE idcart = pidcart;

END$$

DROP PROCEDURE IF EXISTS `sp_categories_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categories_save` (`pidcategory` INT, `pdescategory` VARCHAR(64))  BEGIN
	
	IF pidcategory > 0 THEN
		
		UPDATE tb_categories
        SET descategory = pdescategory
        WHERE idcategory = pidcategory;
        
    ELSE
		
		INSERT INTO tb_categories (descategory) VALUES(pdescategory);
        
        SET pidcategory = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_categories WHERE idcategory = pidcategory;
    
END$$

DROP PROCEDURE IF EXISTS `sp_orders_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_orders_save` (`pidorder` INT, `pidcart` INT(11), `piduser` INT(11), `pidstatus` INT(11), `pidaddress` INT(11), `pvltotal` DECIMAL(10,2))  BEGIN
	
	IF pidorder > 0 THEN
		
		UPDATE tb_orders
        SET
			idcart = pidcart,
            iduser = piduser,
            idstatus = pidstatus,
            idaddress = pidaddress,
            vltotal = pvltotal
		WHERE idorder = pidorder;
        
    ELSE
    
		INSERT INTO tb_orders (idcart, iduser, idstatus, idaddress, vltotal)
        VALUES(pidcart, piduser, pidstatus, pidaddress, pvltotal);
		
		SET pidorder = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * 
    FROM tb_orders a
    INNER JOIN tb_ordersstatus b USING(idstatus)
    INNER JOIN tb_carts c USING(idcart)
    INNER JOIN tb_users d ON d.iduser = a.iduser
    INNER JOIN tb_addresses e USING(idaddress)
    WHERE idorder = pidorder;
    
END$$

DROP PROCEDURE IF EXISTS `sp_products_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_products_save` (`pidproduct` INT(11), `pdesproduct` VARCHAR(64), `pvlprice` DECIMAL(10,2), `pvlwidth` DECIMAL(10,2), `pvlheight` DECIMAL(10,2), `pvllength` DECIMAL(10,2), `pvlweight` DECIMAL(10,2), `pdesurl` VARCHAR(128))  BEGIN
	
	IF pidproduct > 0 THEN
		
		UPDATE tb_products
        SET 
			desproduct = pdesproduct,
            vlprice = pvlprice,
            vlwidth = pvlwidth,
            vlheight = pvlheight,
            vllength = pvllength,
            vlweight = pvlweight,
            desurl = pdesurl
        WHERE idproduct = pidproduct;
        
    ELSE
		
		INSERT INTO tb_products (desproduct, vlprice, vlwidth, vlheight, vllength, vlweight, desurl) 
        VALUES(pdesproduct, pvlprice, pvlwidth, pvlheight, pvllength, pvlweight, pdesurl);
        
        SET pidproduct = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_products WHERE idproduct = pidproduct;
    
END$$

DROP PROCEDURE IF EXISTS `sp_userspasswordsrecoveries_create`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_userspasswordsrecoveries_create` (`piduser` INT, `pdesip` VARCHAR(45))  BEGIN
	
	INSERT INTO tb_userspasswordsrecoveries (iduser, desip)
    VALUES(piduser, pdesip);
    
    SELECT * FROM tb_userspasswordsrecoveries
    WHERE idrecovery = LAST_INSERT_ID();
    
END$$

DROP PROCEDURE IF EXISTS `sp_usersupdate_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usersupdate_save` (`piduser` INT, `pdesperson` VARCHAR(64), `pdeslogin` VARCHAR(64), `pdespassword` VARCHAR(256), `pdesemail` VARCHAR(128), `pnrphone` BIGINT, `pinadmin` TINYINT)  BEGIN
	
    DECLARE vidperson INT;
    
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
    
    UPDATE tb_persons
    SET 
		desperson = pdesperson,
        desemail = pdesemail,
        nrphone = pnrphone
	WHERE idperson = vidperson;
    
    UPDATE tb_users
    SET
		deslogin = pdeslogin,
        despassword = pdespassword,
        inadmin = pinadmin
	WHERE iduser = piduser;
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = piduser;
    
END$$

DROP PROCEDURE IF EXISTS `sp_users_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_delete` (`piduser` INT)  BEGIN
    
    DECLARE vidperson INT;
    
    SET FOREIGN_KEY_CHECKS = 0;
	
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
	
    DELETE FROM tb_addresses WHERE idperson = vidperson;
    DELETE FROM tb_addresses WHERE idaddress IN(SELECT idaddress FROM tb_orders WHERE iduser = piduser);
	DELETE FROM tb_persons WHERE idperson = vidperson;
    
    DELETE FROM tb_userslogs WHERE iduser = piduser;
    DELETE FROM tb_userspasswordsrecoveries WHERE iduser = piduser;
    DELETE FROM tb_orders WHERE iduser = piduser;
    DELETE FROM tb_cartsproducts WHERE idcart IN(SELECT idcart FROM tb_carts WHERE iduser = piduser);
    DELETE FROM tb_carts WHERE iduser = piduser;
    DELETE FROM tb_users WHERE iduser = piduser;
    
    SET FOREIGN_KEY_CHECKS = 1;
    
END$$

DROP PROCEDURE IF EXISTS `sp_users_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_save` (`pdesperson` VARCHAR(64), `pdeslogin` VARCHAR(64), `pdespassword` VARCHAR(256), `pdesemail` VARCHAR(128), `pnrphone` BIGINT, `pinadmin` TINYINT)  BEGIN
	
    DECLARE vidperson INT;
    
	INSERT INTO tb_persons (desperson, desemail, nrphone)
    VALUES(pdesperson, pdesemail, pnrphone);
    
    SET vidperson = LAST_INSERT_ID();
    
    INSERT INTO tb_users (idperson, deslogin, despassword, inadmin)
    VALUES(vidperson, pdeslogin, pdespassword, pinadmin);
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = LAST_INSERT_ID();
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_addresses`
--

DROP TABLE IF EXISTS `tb_addresses`;
CREATE TABLE IF NOT EXISTS `tb_addresses` (
  `idaddress` int(11) NOT NULL AUTO_INCREMENT,
  `idperson` int(11) NOT NULL,
  `desaddress` varchar(128) NOT NULL,
  `desnumber` varchar(16) NOT NULL,
  `descomplement` varchar(32) DEFAULT NULL,
  `descity` varchar(32) NOT NULL,
  `desstate` varchar(32) NOT NULL,
  `descountry` varchar(32) NOT NULL,
  `deszipcode` char(8) NOT NULL,
  `desdistrict` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idaddress`),
  KEY `fk_addresses_persons_idx` (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_addresses`
--

INSERT INTO `tb_addresses` (`idaddress`, `idperson`, `desaddress`, `desnumber`, `descomplement`, `descity`, `desstate`, `descountry`, `deszipcode`, `desdistrict`, `dtregister`) VALUES
(1, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2018-05-19 22:03:07');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_carts`
--

DROP TABLE IF EXISTS `tb_carts`;
CREATE TABLE IF NOT EXISTS `tb_carts` (
  `idcart` int(11) NOT NULL AUTO_INCREMENT,
  `dessessionid` varchar(64) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  `deszipcode` char(8) DEFAULT NULL,
  `vlfreight` decimal(10,2) DEFAULT NULL,
  `nrdays` int(11) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcart`),
  KEY `FK_carts_users_idx` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_carts`
--

INSERT INTO `tb_carts` (`idcart`, `dessessionid`, `iduser`, `deszipcode`, `vlfreight`, `nrdays`, `dtregister`) VALUES
(1, 's1ncrhh2fqhpvv8fkprigrpn92', NULL, NULL, NULL, NULL, '2018-04-03 20:33:32'),
(2, '15smadfn9klcm5bguk4ae0bqb2', NULL, NULL, NULL, NULL, '2018-04-13 01:31:14'),
(3, '93m839rihql2tt56km65v825v2', NULL, '41207210', '79.54', 3, '2018-04-17 01:39:40'),
(4, 'cqrkgiina6rg1jco6lajpbuau1', NULL, '41207210', '70.71', 3, '2018-04-18 14:53:27'),
(5, '0ja0n7j8foopo1bnjhfs4t4421', NULL, NULL, NULL, NULL, '2018-04-24 17:11:58'),
(6, 'kt35o5v5uhvf7lgnni3d2uuck5', NULL, NULL, NULL, NULL, '2018-04-26 00:50:45'),
(7, 'smm65io04g9vhsfcu7joddmoi3', NULL, NULL, NULL, NULL, '2018-04-26 17:09:11'),
(8, 'aor2mc46m2amnv1bd5tq32sa04', 1, '40420190', '79.54', 3, '2018-04-27 20:01:55'),
(9, 'karss2u12ecibc65ikt1vg82f7', NULL, '41207210', '139.57', 3, '2018-04-28 21:05:35'),
(10, 'fd4dm67nuabioqckk0u3i86n51', NULL, '41207210', '79.54', 3, '2018-04-29 15:00:58'),
(11, 'edu2iinm0fh0glm0ofoh56i5c6', NULL, '41207210', '61.42', 3, '2018-05-02 15:10:16'),
(12, '1nfds3jm7eho6m97uc7p6nel21', NULL, NULL, NULL, NULL, '2018-05-03 14:46:49'),
(13, '83s8illsggc0ml342bin3uagv3', NULL, NULL, NULL, NULL, '2018-05-12 01:47:06'),
(14, 'lk59ebef8lek2taupjapfqokq1', 1, '40210750', '79.54', 3, '2018-05-14 03:44:42'),
(15, 'kiqs3h1c8lhp6bhu0o9knlnoe3', NULL, '40210750', '68.25', 3, '2018-05-14 08:01:16'),
(16, 'k69qilm9m0tn4d14h6tmivckf7', NULL, '41207210', '96.57', 3, '2018-05-15 14:21:14'),
(17, 'um191ag9a9do83akel340uec23', NULL, NULL, NULL, NULL, '2018-05-15 20:30:15'),
(18, '0641becpvs9f79o48huvi27do0', NULL, NULL, NULL, NULL, '2018-05-17 23:37:37'),
(19, 'gno52fidpk66takf13b4mjd8s0', 1, '41207210', '79.54', 3, '2018-05-19 22:01:27');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cartsproducts`
--

DROP TABLE IF EXISTS `tb_cartsproducts`;
CREATE TABLE IF NOT EXISTS `tb_cartsproducts` (
  `idcartproduct` int(11) NOT NULL AUTO_INCREMENT,
  `idcart` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  `dtremoved` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcartproduct`),
  KEY `FK_cartsproducts_carts_idx` (`idcart`),
  KEY `FK_cartsproducts_products_idx` (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_cartsproducts`
--

INSERT INTO `tb_cartsproducts` (`idcartproduct`, `idcart`, `idproduct`, `dtremoved`, `dtregister`) VALUES
(1, 1, 5, '2018-04-03 17:49:18', '2018-04-03 20:33:32'),
(2, 1, 5, '2018-04-03 17:49:18', '2018-04-03 20:43:14'),
(3, 1, 5, '2018-04-03 17:49:18', '2018-04-03 20:44:05'),
(4, 1, 8, '2018-04-03 17:49:22', '2018-04-03 20:44:22'),
(5, 1, 3, '2018-04-03 17:49:23', '2018-04-03 20:44:55'),
(6, 1, 7, '2018-04-03 17:49:20', '2018-04-03 20:45:22'),
(7, 2, 5, NULL, '2018-04-13 01:31:14'),
(8, 2, 5, NULL, '2018-04-13 01:31:20'),
(9, 2, 5, NULL, '2018-04-13 01:31:22'),
(10, 3, 6, '2018-04-16 23:02:16', '2018-04-17 01:39:40'),
(11, 3, 6, '2018-04-16 23:02:17', '2018-04-17 01:57:20'),
(12, 3, 6, '2018-04-16 23:02:18', '2018-04-17 01:57:23'),
(13, 3, 6, '2018-04-16 23:02:20', '2018-04-17 01:57:23'),
(14, 3, 6, '2018-04-16 23:02:30', '2018-04-17 01:57:24'),
(15, 3, 6, '2018-04-16 23:02:31', '2018-04-17 02:02:22'),
(16, 3, 6, '2018-04-16 23:02:33', '2018-04-17 02:02:23'),
(17, 3, 6, '2018-04-16 23:02:40', '2018-04-17 02:02:24'),
(18, 3, 6, '2018-04-16 23:02:52', '2018-04-17 02:02:25'),
(19, 3, 6, '2018-04-16 23:17:49', '2018-04-17 02:02:26'),
(20, 3, 6, '2018-04-16 23:17:49', '2018-04-17 02:02:26'),
(21, 3, 6, '2018-04-16 23:17:49', '2018-04-17 02:02:27'),
(22, 3, 6, '2018-04-16 23:17:49', '2018-04-17 02:02:37'),
(23, 3, 6, '2018-04-16 23:17:49', '2018-04-17 02:02:47'),
(24, 3, 6, '2018-04-16 23:30:26', '2018-04-17 02:18:14'),
(25, 3, 6, '2018-04-16 23:30:26', '2018-04-17 02:21:38'),
(26, 3, 6, '2018-04-16 23:30:26', '2018-04-17 02:21:44'),
(27, 3, 6, '2018-04-16 23:30:26', '2018-04-17 02:22:16'),
(28, 3, 6, '2018-04-16 23:30:56', '2018-04-17 02:30:51'),
(29, 3, 6, NULL, '2018-04-17 02:31:05'),
(30, 4, 5, '2018-04-18 11:54:16', '2018-04-18 14:53:27'),
(31, 4, 1, '2018-04-18 11:56:46', '2018-04-18 14:56:42'),
(32, 4, 5, '2018-04-18 12:08:26', '2018-04-18 15:06:27'),
(33, 4, 5, '2018-04-18 12:08:29', '2018-04-18 15:08:23'),
(34, 4, 5, '2018-04-18 12:09:29', '2018-04-18 15:08:59'),
(35, 4, 6, '2018-04-18 12:13:32', '2018-04-18 15:13:26'),
(36, 4, 1, '2018-04-18 14:13:16', '2018-04-18 17:11:42'),
(37, 4, 7, NULL, '2018-04-18 18:05:36'),
(38, 5, 3, NULL, '2018-04-24 20:47:14'),
(39, 8, 3, '2018-04-27 17:03:27', '2018-04-27 20:01:55'),
(40, 8, 1, '2018-04-27 17:03:37', '2018-04-27 20:03:31'),
(41, 8, 6, NULL, '2018-04-27 20:03:40'),
(42, 9, 1, '2018-04-28 18:06:03', '2018-04-28 21:05:45'),
(43, 9, 6, NULL, '2018-04-28 21:06:14'),
(44, 9, 6, NULL, '2018-04-28 21:08:15'),
(45, 9, 6, NULL, '2018-04-28 21:56:29'),
(46, 10, 6, NULL, '2018-04-29 15:00:58'),
(47, 11, 6, '2018-05-02 12:27:42', '2018-05-02 15:24:09'),
(48, 11, 6, '2018-05-02 14:15:43', '2018-05-02 15:27:30'),
(49, 11, 9, NULL, '2018-05-02 17:15:39'),
(50, 14, 6, '2018-05-14 00:46:31', '2018-05-14 03:44:45'),
(51, 14, 6, NULL, '2018-05-14 03:45:26'),
(52, 15, 5, NULL, '2018-05-14 08:01:19'),
(53, 16, 5, NULL, '2018-05-15 14:21:58'),
(54, 16, 6, NULL, '2018-05-15 14:56:28'),
(55, 19, 6, NULL, '2018-05-19 22:01:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_categories`
--

DROP TABLE IF EXISTS `tb_categories`;
CREATE TABLE IF NOT EXISTS `tb_categories` (
  `idcategory` int(11) NOT NULL AUTO_INCREMENT,
  `descategory` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcategory`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_categories`
--

INSERT INTO `tb_categories` (`idcategory`, `descategory`, `dtregister`) VALUES
(5, 'Apple', '2018-01-23 23:34:20'),
(6, 'Android', '2018-01-23 23:34:33'),
(7, 'Samsung', '2018-01-23 23:34:42'),
(8, 'Motorola', '2018-01-23 23:34:50');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_orders`
--

DROP TABLE IF EXISTS `tb_orders`;
CREATE TABLE IF NOT EXISTS `tb_orders` (
  `idorder` int(11) NOT NULL AUTO_INCREMENT,
  `idcart` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `idstatus` int(11) NOT NULL,
  `idaddress` int(11) NOT NULL,
  `vltotal` decimal(10,2) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idorder`),
  KEY `FK_orders_users_idx` (`iduser`),
  KEY `fk_orders_ordersstatus_idx` (`idstatus`),
  KEY `fk_orders_carts_idx` (`idcart`),
  KEY `fk_orders_addresses_idx` (`idaddress`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_orders`
--

INSERT INTO `tb_orders` (`idorder`, `idcart`, `iduser`, `idstatus`, `idaddress`, `vltotal`, `dtregister`) VALUES
(2, 10, 1, 2, 4, '79.54', '2018-04-29 15:02:55'),
(3, 11, 1, 1, 5, '741.32', '2018-05-02 17:16:05'),
(4, 14, 1, 1, 6, '1967.32', '2018-05-14 03:56:13'),
(5, 15, 1, 1, 7, '1203.48', '2018-05-14 08:01:54'),
(6, 15, 1, 1, 8, '1203.48', '2018-05-14 08:11:33'),
(7, 15, 1, 1, 9, '1203.48', '2018-05-14 08:13:25'),
(8, 15, 1, 1, 10, '1203.48', '2018-05-14 08:15:36'),
(9, 16, 1, 1, 11, '1203.48', '2018-05-15 14:22:10'),
(10, 19, 1, 1, 1, '1967.32', '2018-05-19 22:03:07');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_ordersstatus`
--

DROP TABLE IF EXISTS `tb_ordersstatus`;
CREATE TABLE IF NOT EXISTS `tb_ordersstatus` (
  `idstatus` int(11) NOT NULL AUTO_INCREMENT,
  `desstatus` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_ordersstatus`
--

INSERT INTO `tb_ordersstatus` (`idstatus`, `desstatus`, `dtregister`) VALUES
(1, 'Em Aberto', '2017-03-13 03:00:00'),
(2, 'Aguardando Pagamento', '2017-03-13 03:00:00'),
(3, 'Pago', '2017-03-13 03:00:00'),
(4, 'Entregue', '2017-03-13 03:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_persons`
--

DROP TABLE IF EXISTS `tb_persons`;
CREATE TABLE IF NOT EXISTS `tb_persons` (
  `idperson` int(11) NOT NULL AUTO_INCREMENT,
  `desperson` varchar(64) NOT NULL,
  `desemail` varchar(128) DEFAULT NULL,
  `nrphone` bigint(20) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_persons`
--

INSERT INTO `tb_persons` (`idperson`, `desperson`, `desemail`, `nrphone`, `dtregister`) VALUES
(1, 'João Rangel', 'admin@hcode.com.br', 2147483647, '2017-03-01 03:00:00'),
(7, 'Suporte', 'suporte@hcode.com.br', 1112345678, '2017-03-15 16:10:27'),
(10, 'bruno', 'brunogfvot@hotmail.com', 711211, '2018-01-19 22:03:30'),
(11, 'Rose', NULL, 123456, '2018-04-24 18:11:07'),
(12, 'Rose', NULL, 123456, '2018-04-24 18:13:09'),
(13, 'Rose', NULL, 123456, '2018-04-24 18:14:11'),
(14, 'Rose', NULL, 12132132, '2018-04-24 21:06:26'),
(15, 'asdasdas', NULL, 8798789, '2018-04-26 00:52:48'),
(16, 'Novo', NULL, 0, '2018-04-26 17:09:42'),
(17, 'Novo', NULL, 133, '2018-04-26 17:10:20'),
(18, 'novo', 'brunogfvot@hotmail.com', 711211, '2018-04-26 18:07:24');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_products`
--

DROP TABLE IF EXISTS `tb_products`;
CREATE TABLE IF NOT EXISTS `tb_products` (
  `idproduct` int(11) NOT NULL,
  `desproduct` varchar(64) NOT NULL,
  `vlprice` decimal(10,2) NOT NULL,
  `vlwidth` decimal(10,2) NOT NULL,
  `vlheight` decimal(10,2) NOT NULL,
  `vllength` decimal(10,2) NOT NULL,
  `vlweight` decimal(10,2) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_products`
--

INSERT INTO `tb_products` (`idproduct`, `desproduct`, `vlprice`, `vlwidth`, `vlheight`, `vllength`, `vlweight`, `desurl`, `dtregister`) VALUES
(1, 'Smartphone Android 7.0', '999.95', '75.00', '151.00', '80.00', '167.00', 'smartphone-android-7.0', '2017-03-13 03:00:00'),
(2, 'SmartTV LED 4K', '20000.00', '917.00', '596.00', '0.00', '0.99', 'smarttv-led-4k', '2017-03-13 03:00:00'),
(3, 'Notebook 14\" 4GB 1TB', '1000.00', '100.00', '10.00', '0.00', '1.50', 'notebook-14-4gb-1tb', '2017-03-13 03:00:00'),
(5, 'Smartphone Motorola Moto G5 Plus', '1135.23', '15.20', '7.40', '0.00', '0.16', 'smartphone-motorola-moto-g5-plus', '2018-02-05 21:15:25'),
(6, 'Smartphone Moto Z Play', '1887.78', '14.10', '0.90', '0.00', '0.13', 'smartphone-moto-z-play', '2018-02-05 21:15:25'),
(7, 'Smartphone Samsung Galaxy J5 Pro', '1299.00', '14.60', '7.10', '0.00', '0.16', 'smartphone-samsung-galaxy-j5', '2018-02-05 21:15:25'),
(8, 'Smartphone Samsung Galaxy J7 Prime', '1149.00', '15.10', '7.50', '0.00', '0.16', 'smartphone-samsung-galaxy-j7', '2018-02-05 21:15:25'),
(9, 'Smartphone Samsung Galaxy J3 Dual', '679.90', '14.20', '7.10', '0.00', '0.14', 'smartphone-samsung-galaxy-j3', '2018-02-05 21:15:25');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_productscategories`
--

DROP TABLE IF EXISTS `tb_productscategories`;
CREATE TABLE IF NOT EXISTS `tb_productscategories` (
  `idcategory` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  PRIMARY KEY (`idcategory`,`idproduct`),
  KEY `fk_productscategories_products_idx` (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_productscategories`
--

INSERT INTO `tb_productscategories` (`idcategory`, `idproduct`) VALUES
(6, 1),
(6, 5),
(8, 5),
(6, 6),
(6, 7),
(6, 8),
(6, 9);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE IF NOT EXISTS `tb_users` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `idperson` int(11) NOT NULL,
  `deslogin` varchar(64) NOT NULL,
  `despassword` varchar(256) NOT NULL,
  `inadmin` tinyint(4) NOT NULL DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iduser`),
  KEY `FK_users_persons_idx` (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_users`
--

INSERT INTO `tb_users` (`iduser`, `idperson`, `deslogin`, `despassword`, `inadmin`, `dtregister`) VALUES
(1, 10, 'admin', '$2y$12$1FweHxxO1Md4wcPamtQiJuEPtIF3wfnfRkmbAoeZw82RITIfbDTKy', 1, '2017-03-13 03:00:00'),
(7, 7, 'suporte', '$2y$12$HFjgUm/mk1RzTy4ZkJaZBe0Mc/BA2hQyoUckvm.lFa6TesjtNpiMe', 1, '2017-03-15 16:10:27'),
(10, 10, 'bruno', '$2y$12$hKaYkmysAUxuw4gYLdTL3eyB7eVzwt4.mK4gGCQUYMD0X/YNzINrG', 1, '2018-01-19 22:03:30'),
(11, 11, 'brunog@hotmail.com', '$2y$12$W1WFA91WjfCRbj59i32ynOKE8iKrBT9wIyOniKUrCwcBJO71KkSvK', 0, '2018-04-24 18:11:07'),
(12, 12, 'rose1@gmail.com', '$2y$12$E2DUTg5okd044QT0wgetwe98jEsqu7zLB5rOiCxoLygdO9gxLtei6', 0, '2018-04-24 18:13:09'),
(13, 13, 'rose1@gmail.com', '$2y$12$WyLpHdi9blV3ZorPXsQLJubRL8zkhVOAAR40N2LoKc2BParIPQhbW', 0, '2018-04-24 18:14:11'),
(14, 14, '8787@gmail.com', '$2y$12$NKyXNsyUiSl.TAnf3Li0zOUJEAq7YxLKMdvsT9eXcbqPMgrTIN37S', 0, '2018-04-24 21:06:26'),
(15, 15, 'rose1222@gmail.com', '$2y$12$qS9LuGnTKywv0zws2ljxnOhqEljkr/U3gCTci/1.wBhyEskpxx2eK', 0, '2018-04-26 00:52:48'),
(16, 16, 'novo@novo.com', '$2y$12$v.c5tJWMqDGhX2O3RSrY2ONB0MBKDNeMDLzQfja/u/sG4L/UQNs3m', 0, '2018-04-26 17:09:42'),
(17, 17, 'novo1@novo.com', '$2y$12$PC5BK.Kgk5VxEN8DK0.WxuIIqUJrSDj6/qIhrbq/3aBoaMrAkago2', 0, '2018-04-26 17:10:20'),
(18, 18, 'brunogfvot@hotmail.com', '$2y$12$BEYN.oOkdMI7ylCLtDxclu3556Yhv5iqUbCf3EKRVPYiymOQ2F9Y2', 1, '2018-04-26 18:07:24');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userslogs`
--

DROP TABLE IF EXISTS `tb_userslogs`;
CREATE TABLE IF NOT EXISTS `tb_userslogs` (
  `idlog` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `deslog` varchar(128) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `desuseragent` varchar(128) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlog`),
  KEY `fk_userslogs_users_idx` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userspasswordsrecoveries`
--

DROP TABLE IF EXISTS `tb_userspasswordsrecoveries`;
CREATE TABLE IF NOT EXISTS `tb_userspasswordsrecoveries` (
  `idrecovery` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `dtrecovery` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrecovery`),
  KEY `fk_userspasswordsrecoveries_users_idx` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_userspasswordsrecoveries`
--

INSERT INTO `tb_userspasswordsrecoveries` (`idrecovery`, `iduser`, `desip`, `dtrecovery`, `dtregister`) VALUES
(1, 7, '127.0.0.1', NULL, '2017-03-15 19:10:59'),
(2, 7, '127.0.0.1', '2017-03-15 13:33:45', '2017-03-15 19:11:18'),
(3, 7, '127.0.0.1', '2017-03-15 13:37:35', '2017-03-15 19:37:12'),
(4, 1, '::1', NULL, '2018-01-20 01:16:11'),
(5, 1, '::1', NULL, '2018-01-20 01:19:13'),
(6, 1, '::1', NULL, '2018-01-20 01:19:49'),
(7, 1, '::1', NULL, '2018-01-20 01:23:36'),
(8, 1, '::1', NULL, '2018-01-20 01:30:48'),
(9, 1, '::1', NULL, '2018-01-20 01:34:26'),
(10, 1, '::1', NULL, '2018-01-20 01:34:51'),
(11, 1, '::1', NULL, '2018-01-20 01:48:43'),
(12, 10, '::1', NULL, '2018-01-24 01:17:38'),
(13, 10, '::1', NULL, '2018-01-24 01:19:42'),
(14, 10, '::1', NULL, '2018-01-24 01:26:47'),
(15, 10, '::1', NULL, '2018-03-01 21:02:02'),
(16, 1, '::1', NULL, '2018-04-24 20:51:57'),
(17, 1, '::1', NULL, '2018-04-24 20:53:20');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD CONSTRAINT `fk_addresses_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_carts`
--
ALTER TABLE `tb_carts`
  ADD CONSTRAINT `fk_carts_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_orders`
--
ALTER TABLE `tb_orders`
  ADD CONSTRAINT `fk_orders_addresses` FOREIGN KEY (`idaddress`) REFERENCES `tb_addresses` (`idaddress`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_ordersstatus` FOREIGN KEY (`idstatus`) REFERENCES `tb_ordersstatus` (`idstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_productscategories`
--
ALTER TABLE `tb_productscategories`
  ADD CONSTRAINT `fk_productscategories_categories` FOREIGN KEY (`idcategory`) REFERENCES `tb_categories` (`idcategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_productscategories_products` FOREIGN KEY (`idproduct`) REFERENCES `tb_products` (`idproduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
