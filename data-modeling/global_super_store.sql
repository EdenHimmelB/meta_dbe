-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema global_super_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema global_super_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `global_super_store` DEFAULT CHARACTER SET utf8 ;
USE `global_super_store` ;

-- -----------------------------------------------------
-- Table `global_super_store`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Customers` (
  `CustomerID` VARCHAR(45) NOT NULL,
  `CustomerName` VARCHAR(255) NOT NULL,
  `Segment` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Shippings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Shippings` (
  `ShipID` INT NOT NULL,
  `ShipDate` DATE NOT NULL,
  `ShipMode` VARCHAR(45) NOT NULL,
  `ShippingCost` DECIMAL NOT NULL,
  PRIMARY KEY (`ShipID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Products` (
  `ProductID` VARCHAR(45) NOT NULL,
  `ProductName` VARCHAR(255) NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `SubCategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Address` (
  `AddressID` INT NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Market` VARCHAR(45) NOT NULL,
  `Region` VARCHAR(45) NOT NULL,
  `PostalCode` INT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Orders` (
  `OrderID` VARCHAR(45) NOT NULL,
  `Customers_CustomerID` VARCHAR(45) NOT NULL,
  `Address_AddressID` INT NOT NULL,
  `Shippings_ShipID` INT NOT NULL,
  `Products_ProductID` VARCHAR(45) NOT NULL,
  `Sales` DECIMAL(2) NOT NULL,
  `Quantity` INT NOT NULL,
  `Discount` DECIMAL(6) NOT NULL,
  `Profit` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Products_idx` (`Products_ProductID` ASC) VISIBLE,
  INDEX `fk_Orders_Customers1_idx` (`Customers_CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Address1_idx` (`Address_AddressID` ASC) VISIBLE,
  INDEX `fk_Orders_Shippings1_idx` (`Shippings_ShipID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Products`
    FOREIGN KEY (`Products_ProductID`)
    REFERENCES `global_super_store`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `global_super_store`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Address1`
    FOREIGN KEY (`Address_AddressID`)
    REFERENCES `global_super_store`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Shippings1`
    FOREIGN KEY (`Shippings_ShipID`)
    REFERENCES `global_super_store`.`Shippings` (`ShipID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
