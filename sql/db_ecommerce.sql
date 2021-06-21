-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 21-Jun-2021 às 21:28
-- Versão do servidor: 8.0.20
-- versão do PHP: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `db_ecommerce`
--

DELIMITER $$
--
-- Procedimentos
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

DROP PROCEDURE IF EXISTS `sp_orderspagseguro_save`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_orderspagseguro_save` (`pidorder` INT, `pdescode` VARCHAR(36), `pvlgrossamount` DECIMAL(10,2), `pvldiscountamount` DECIMAL(10,2), `pvlfeeamount` DECIMAL(10,2), `pvlnetamount` DECIMAL(10,2), `pvlextraamount` DECIMAL(10,2), `pdespaymentlink` VARCHAR(256))  BEGIN
	
    DELETE FROM tb_orderspagseguro WHERE idorder = pidorder;
    
    INSERT INTO tb_orderspagseguro (idorder, descode, vlgrossamount, vldiscountamount, vlfeeamount, vlnetamount, vlextraamount, despaymentlink)
	VALUES(pidorder, pdescode, pvlgrossamount, pvldiscountamount, pvlfeeamount, pvlnetamount, pvlextraamount, pdespaymentlink);
    
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
  `idaddress` int NOT NULL AUTO_INCREMENT,
  `idperson` int NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_addresses`
--

INSERT INTO `tb_addresses` (`idaddress`, `idperson`, `desaddress`, `desnumber`, `descomplement`, `descity`, `desstate`, `descountry`, `deszipcode`, `desdistrict`, `dtregister`) VALUES
(1, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2018-05-19 22:03:07'),
(2, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-11 19:56:46'),
(3, 10, 'Rua S', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-19 13:04:23'),
(4, 10, 'Rua S', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-19 13:19:05'),
(5, 10, 'Rua S', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-19 13:41:12'),
(6, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-26 19:46:57'),
(7, 10, 'Rua S', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-26 19:50:57'),
(8, 10, 'Rua São Roque', '4', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-09-26 19:53:10'),
(9, 10, 'Rua São Roque', '1', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-10-12 11:16:39'),
(10, 10, 'Rua São Roque', '1', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2020-10-12 11:32:01'),
(11, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-17 22:25:25'),
(12, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-17 22:31:41'),
(13, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-18 15:48:55'),
(14, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-18 15:54:11'),
(15, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-18 16:52:22'),
(16, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-18 19:20:30'),
(17, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-18 19:47:51'),
(18, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 03:25:17'),
(19, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 03:34:16'),
(20, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 04:49:55'),
(21, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 05:10:34'),
(22, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 05:18:32'),
(23, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 05:37:35'),
(24, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 05:45:27'),
(25, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 19:57:16'),
(26, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 20:01:46'),
(27, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 20:06:40'),
(28, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 20:41:02'),
(29, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 20:59:58'),
(30, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 21:22:06'),
(31, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 21:22:42'),
(32, 10, 'Rua São Roque', '74', '', 'Salvador', 'BA', 'Brasil', '41207210', 'Tancredo Neves', '2021-06-21 21:23:35');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_carts`
--

DROP TABLE IF EXISTS `tb_carts`;
CREATE TABLE IF NOT EXISTS `tb_carts` (
  `idcart` int NOT NULL AUTO_INCREMENT,
  `dessessionid` varchar(64) NOT NULL,
  `iduser` int DEFAULT NULL,
  `deszipcode` char(8) DEFAULT NULL,
  `vlfreight` decimal(10,2) DEFAULT NULL,
  `nrdays` int DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcart`),
  KEY `FK_carts_users_idx` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

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
(19, 'gno52fidpk66takf13b4mjd8s0', 1, '41207210', '79.54', 3, '2018-05-19 22:01:27'),
(20, 'u92vq29vepa5ifqc0lno8ruh2t', NULL, '41207210', '0.00', 0, '2020-09-11 19:52:40'),
(21, '5mnvhm7hos9s8tmnjrnj3ldipd', NULL, '41207210', '176.54', 9, '2020-09-11 19:54:54'),
(22, 'criiepedlmm77vh79pj0heti3t', NULL, '41207210', '176.54', 9, '2020-09-19 11:36:59'),
(23, '2aas31gbu4abadntn4nn7mrf18', NULL, '41207210', '176.54', 9, '2020-09-19 13:17:57'),
(24, 'tt6oooha9tvreoasut6gkj78oj', NULL, '41207210', '176.54', 9, '2020-09-26 19:43:28'),
(25, 'g4rp8fglf8fogdtrsosgohms1o', NULL, '41207210', '176.54', 9, '2020-09-26 19:50:17'),
(26, '7ehke0ihnetbp56195vhek55hl', NULL, '41207210', '176.54', 9, '2020-09-26 19:52:39'),
(27, 'qa2q44crqe063il76oke34iddu', NULL, '41207210', '176.54', 8, '2020-10-12 11:15:55'),
(28, 'q9btosidch5uqii8psohg5fddf', NULL, '41207210', '176.54', 8, '2020-10-12 11:30:29'),
(29, '5shds3ph7aui209tln30a5upfd', NULL, NULL, NULL, NULL, '2020-11-20 22:11:52'),
(30, 'qt9ogpgjdmjmld7fn2bhgtmkio', NULL, NULL, NULL, NULL, '2020-11-22 01:14:56'),
(31, 'svhjvsd0jmapq3rj9sk0g4e3uv', NULL, NULL, NULL, NULL, '2021-02-09 01:58:51'),
(32, 'k0t4lm85mjt6tm7duvs9iof61r', NULL, NULL, NULL, NULL, '2021-04-09 16:23:55'),
(33, 'gpqso5j86fnahhla4o48dd8kpu', NULL, '41207210', '176.53', 2, '2021-06-17 22:24:41'),
(34, 'n2dtcbc8u0ccnnuaol28r2uhpr', NULL, '41207210', '176.53', 2, '2021-06-18 15:46:30'),
(35, 'o7vk0mjhkvaq6vqp7k9mrvh8if', NULL, '41207210', '176.53', 2, '2021-06-18 19:19:07'),
(36, 'vk8vnt6p8o0s8hd1jvtjtgt72i', NULL, NULL, NULL, NULL, '2021-06-20 21:54:39'),
(37, '7d9l9p7965hgji9mh9lrssnnfh', NULL, '41207210', '232.43', 2, '2021-06-21 03:08:26'),
(38, 'k4puhk069fce4kb4db1a14lfuh', NULL, '41207210', '232.43', 2, '2021-06-21 05:09:51'),
(39, 'as7qt255ga6cp5ih51kv7bth2o', NULL, NULL, NULL, NULL, '2021-06-21 05:10:55'),
(40, 'ep9v4d82k4fi020pv8keog43cm', NULL, '41207210', '273.23', 2, '2021-06-21 05:37:07'),
(41, 'bremnlgvjdesdfegre66am3lql', NULL, '41207210', '176.53', 2, '2021-06-21 19:43:25'),
(42, 'vo7bm0kudf8bffr3k5sbini28a', NULL, '41207210', '176.53', 2, '2021-06-21 20:01:25'),
(43, 'ns25c7v5lfver0ooooaiupm7q1', NULL, '41207210', '100.29', 2, '2021-06-21 21:23:10');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cartsproducts`
--

DROP TABLE IF EXISTS `tb_cartsproducts`;
CREATE TABLE IF NOT EXISTS `tb_cartsproducts` (
  `idcartproduct` int NOT NULL AUTO_INCREMENT,
  `idcart` int NOT NULL,
  `idproduct` int NOT NULL,
  `dtremoved` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcartproduct`),
  KEY `FK_cartsproducts_carts_idx` (`idcart`),
  KEY `FK_cartsproducts_products_idx` (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

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
(55, 19, 6, NULL, '2018-05-19 22:01:32'),
(56, 20, 1, NULL, '2020-09-11 19:52:43'),
(57, 21, 1, '2020-09-11 16:56:27', '2020-09-11 19:54:57'),
(58, 21, 3, NULL, '2020-09-11 19:56:19'),
(59, 22, 1, '2020-09-19 10:04:03', '2020-09-19 13:03:00'),
(60, 22, 3, NULL, '2020-09-19 13:04:10'),
(61, 23, 3, NULL, '2020-09-19 13:18:51'),
(62, 22, 1, '2020-09-19 10:41:02', '2020-09-19 13:40:53'),
(63, 24, 1, '2020-09-26 16:46:45', '2020-09-26 19:46:30'),
(64, 24, 3, NULL, '2020-09-26 19:46:42'),
(65, 25, 3, NULL, '2020-09-26 19:50:21'),
(66, 26, 3, NULL, '2020-09-26 19:52:55'),
(67, 27, 3, NULL, '2020-10-12 11:16:26'),
(68, 28, 3, NULL, '2020-10-12 11:30:40'),
(69, 33, 3, NULL, '2021-06-17 22:25:06'),
(70, 34, 1, '2021-06-18 12:47:51', '2021-06-18 15:47:40'),
(71, 34, 3, NULL, '2021-06-18 15:47:55'),
(72, 35, 3, NULL, '2021-06-18 19:20:20'),
(73, 37, 3, '2021-06-21 02:36:54', '2021-06-21 03:24:53'),
(74, 38, 3, NULL, '2021-06-21 05:10:08'),
(75, 38, 3, NULL, '2021-06-21 05:10:24'),
(76, 40, 3, NULL, '2021-06-21 05:37:22'),
(77, 40, 3, NULL, '2021-06-21 05:37:24'),
(78, 40, 3, NULL, '2021-06-21 05:37:25'),
(79, 37, 3, '2021-06-21 02:45:13', '2021-06-21 05:44:25'),
(80, 37, 3, NULL, '2021-06-21 05:44:40'),
(81, 37, 3, NULL, '2021-06-21 05:44:56'),
(82, 41, 0, '2021-06-21 16:57:03', '2021-06-21 19:56:44'),
(83, 41, 3, '2021-06-21 17:26:57', '2021-06-21 19:56:59'),
(84, 42, 3, NULL, '2021-06-21 20:01:36'),
(85, 41, 3, '2021-06-21 18:21:52', '2021-06-21 20:59:37'),
(86, 41, 6, '2021-06-21 18:22:29', '2021-06-21 21:21:56'),
(87, 41, 3, NULL, '2021-06-21 21:22:33'),
(88, 43, 6, NULL, '2021-06-21 21:23:24');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_categories`
--

DROP TABLE IF EXISTS `tb_categories`;
CREATE TABLE IF NOT EXISTS `tb_categories` (
  `idcategory` int NOT NULL AUTO_INCREMENT,
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
  `idorder` int NOT NULL AUTO_INCREMENT,
  `idcart` int NOT NULL,
  `iduser` int NOT NULL,
  `idstatus` int NOT NULL,
  `idaddress` int NOT NULL,
  `vltotal` decimal(10,2) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idorder`),
  KEY `FK_orders_users_idx` (`iduser`),
  KEY `fk_orders_ordersstatus_idx` (`idstatus`),
  KEY `fk_orders_carts_idx` (`idcart`),
  KEY `fk_orders_addresses_idx` (`idaddress`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_orders`
--

INSERT INTO `tb_orders` (`idorder`, `idcart`, `iduser`, `idstatus`, `idaddress`, `vltotal`, `dtregister`) VALUES
(32, 40, 1, 1, 23, '3273.23', '2021-06-21 05:37:37'),
(33, 37, 1, 1, 24, '2232.43', '2021-06-21 05:45:29'),
(34, 41, 1, 1, 25, '1176.53', '2021-06-21 19:57:16'),
(35, 42, 1, 1, 26, '1176.53', '2021-06-21 20:01:47'),
(36, 41, 1, 1, 27, '1176.53', '2021-06-21 20:06:41'),
(37, 41, 1, 1, 28, '176.53', '2021-06-21 20:41:02'),
(38, 41, 1, 1, 29, '1176.53', '2021-06-21 21:00:00'),
(39, 41, 1, 1, 30, '1988.07', '2021-06-21 21:22:07'),
(40, 41, 1, 1, 31, '1176.53', '2021-06-21 21:22:43'),
(41, 43, 1, 1, 32, '1988.07', '2021-06-21 21:23:35');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_orderspagseguro`
--

DROP TABLE IF EXISTS `tb_orderspagseguro`;
CREATE TABLE IF NOT EXISTS `tb_orderspagseguro` (
  `idorder` int NOT NULL,
  `descode` varchar(36) NOT NULL,
  `vlgrossamount` decimal(10,2) NOT NULL,
  `vldiscountamount` decimal(10,2) NOT NULL,
  `vlfeeamount` decimal(10,2) NOT NULL,
  `vlnetamount` decimal(10,2) NOT NULL,
  `vlextraamount` decimal(10,2) NOT NULL,
  `despaymentlink` varchar(256) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_orderspagseguro`
--

INSERT INTO `tb_orderspagseguro` (`idorder`, `descode`, `vlgrossamount`, `vldiscountamount`, `vlfeeamount`, `vlnetamount`, `vlextraamount`, `despaymentlink`, `dtregister`) VALUES
(33, 'DA3650F6-EBA0-4858-822F-C476961E34E2', '2232.43', '0.00', '218.51', '2013.92', '0.00', '', '2021-06-21 05:46:09'),
(36, '9FA71070-7FAB-4B1D-9923-806551372AA6', '1176.53', '0.00', '101.58', '1074.95', '0.00', '', '2021-06-21 20:13:47'),
(38, '21F5BAAF-8070-46DF-8B25-0F00D0083856', '1176.53', '0.00', '59.11', '1117.42', '0.00', 'https://sandbox.pagseguro.uol.com.br/checkout/payment/booklet/print.jhtml?c=e74ee1a6c315b3f07c9b488712d32e35c28e6fec57e4c3eb784cd9df524ea61bff62a1ba20ed1cfd', '2021-06-21 21:00:18');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_ordersstatus`
--

DROP TABLE IF EXISTS `tb_ordersstatus`;
CREATE TABLE IF NOT EXISTS `tb_ordersstatus` (
  `idstatus` int NOT NULL AUTO_INCREMENT,
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
  `idperson` int NOT NULL AUTO_INCREMENT,
  `desperson` varchar(64) NOT NULL,
  `desemail` varchar(128) DEFAULT NULL,
  `nrphone` bigint DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_persons`
--

INSERT INTO `tb_persons` (`idperson`, `desperson`, `desemail`, `nrphone`, `dtregister`) VALUES
(1, 'João Rangel', 'admin@hcode.com.br', 2147483647, '2017-03-01 03:00:00'),
(7, 'Suporte', 'suporte@hcode.com.br', 1112345678, '2017-03-15 16:10:27'),
(10, 'Bruno Moreira', 'c73338594994864818535@sandbox.pagseguro.com.br', 71, '2018-01-19 22:03:30');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_products`
--

DROP TABLE IF EXISTS `tb_products`;
CREATE TABLE IF NOT EXISTS `tb_products` (
  `idproduct` int NOT NULL,
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
(0, 'nat', '5555.00', '1.00', '1.00', '1.00', '1.00', '', '2021-02-09 02:01:37'),
(1, 'Smartphone Android 7.0', '1500.85', '5.00', '3.00', '1.00', '2.00', 'smartphone-android-7.0', '2017-03-13 03:00:00'),
(2, 'SmartTV LED 4K', '20000.00', '917.00', '596.00', '0.00', '0.99', 'smarttv-led-4k', '2017-03-13 03:00:00'),
(3, 'Notebook 14\" 4GB 1TB', '1000.00', '100.00', '10.00', '0.00', '1.50', 'notebook-14-4gb-1tb', '2017-03-13 03:00:00'),
(5, 'Smartphone Motorola Moto G5 Plus', '1135.23', '15.20', '7.40', '0.00', '0.16', 'smartphone-motorola-moto-g5-plus', '2018-02-05 21:15:25'),
(6, 'Smartphone Moto Z Play', '1887.78', '14.10', '0.90', '0.00', '0.13', 'smartphone-moto-z-play', '2018-02-05 21:15:25'),
(7, 'Smartphone Samsung Galaxy J5 Pro', '1299.00', '14.60', '7.10', '0.00', '0.16', 'smartphone-samsung-galaxy-j5', '2018-02-05 21:15:25'),
(8, 'Smartphone Samsung Galaxy J7 Prime', '1149.00', '15.10', '7.50', '0.00', '0.16', 'smartphone-samsung-galaxy-j7', '2018-02-05 21:15:25'),
(9, 'Smartphone Samsung Galaxy J3 Dual', '679.90', '14.20', '7.10', '0.00', '0.14', 'smartphone-samsung-galaxy-j3', '2018-02-05 21:15:25');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE IF NOT EXISTS `tb_users` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `idperson` int NOT NULL,
  `deslogin` varchar(64) NOT NULL,
  `despassword` varchar(256) NOT NULL,
  `inadmin` tinyint NOT NULL DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iduser`),
  KEY `FK_users_persons_idx` (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_users`
--

INSERT INTO `tb_users` (`iduser`, `idperson`, `deslogin`, `despassword`, `inadmin`, `dtregister`) VALUES
(1, 10, 'admin', '$2y$12$1FweHxxO1Md4wcPamtQiJuEPtIF3wfnfRkmbAoeZw82RITIfbDTKy', 1, '2017-03-13 03:00:00'),
(7, 7, 'suporte', '$2y$12$HFjgUm/mk1RzTy4ZkJaZBe0Mc/BA2hQyoUckvm.lFa6TesjtNpiMe', 1, '2017-03-15 16:10:27');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userslogs`
--

DROP TABLE IF EXISTS `tb_userslogs`;
CREATE TABLE IF NOT EXISTS `tb_userslogs` (
  `idlog` int NOT NULL AUTO_INCREMENT,
  `iduser` int NOT NULL,
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
  `idrecovery` int NOT NULL AUTO_INCREMENT,
  `iduser` int NOT NULL,
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
