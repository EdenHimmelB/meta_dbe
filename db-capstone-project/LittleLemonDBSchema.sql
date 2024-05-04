-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`country` (
  `country_id` INT NOT NULL,
  `country_name` VARCHAR(255) NOT NULL,
  `country_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `country_id_UNIQUE` (`country_id` ASC) VISIBLE,
  UNIQUE INDEX `country_name_UNIQUE` (`country_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`city` (
  `city_id` INT NOT NULL,
  `country_country_id` INT NOT NULL,
  `city_name` VARCHAR(100) NOT NULL,
  `postal_code` INT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE INDEX `city_id_UNIQUE` (`city_id` ASC) VISIBLE,
  INDEX `fk_city_country1_idx` (`country_country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `LittleLemonDB`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
  `customer_id` INT NOT NULL,
  `city_city_id` INT NOT NULL,
  `customer_name` VARCHAR(255) NOT NULL,
  `contact_number` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  INDEX `fk_customers_city_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_city`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `LittleLemonDB`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_items` (
  `menu_items_id` INT NOT NULL,
  `course_name` VARCHAR(45) NOT NULL,
  `starter_name` VARCHAR(45) NOT NULL,
  `side_name` VARCHAR(45) NOT NULL,
  `desert_name` VARCHAR(45) NOT NULL,
  `drink_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menu_items_id`),
  UNIQUE INDEX `menu_items_id_UNIQUE` (`menu_items_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menus` (
  `menu_id` INT NOT NULL,
  `menu_items_menu_items_id` INT NOT NULL,
  `cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menu_id`),
  INDEX `fk_menus_menu_items1_idx` (`menu_items_menu_items_id` ASC) VISIBLE,
  CONSTRAINT `fk_menus_menu_items1`
    FOREIGN KEY (`menu_items_menu_items_id`)
    REFERENCES `LittleLemonDB`.`menu_items` (`menu_items_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `order_id` INT NOT NULL,
  `customers_customer_id` INT NOT NULL,
  `menus_menu_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `delivery_date` DATE NOT NULL,
  `sales` DECIMAL(3) NOT NULL,
  `cost` DECIMAL(2) NOT NULL,
  `delivery_cost` DECIMAL(2) NOT NULL,
  `quantity` INT NOT NULL,
  `discount` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`customers_customer_id` ASC) VISIBLE,
  INDEX `fk_orders_menus1_idx` (`menus_menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_menus1`
    FOREIGN KEY (`menus_menu_id`)
    REFERENCES `LittleLemonDB`.`menus` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staffs` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `staff_name` VARCHAR(45) NOT NULL,
  `staff_role` VARCHAR(45) NOT NULL,
  `contact_number` INT NOT NULL,
  `annual_salary` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `customers_customer_id` INT NOT NULL,
  `staffs_staff_id` INT NOT NULL,
  `booking_date` DATE NOT NULL,
  `table` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE INDEX `booking_id_UNIQUE` (`booking_id` ASC) VISIBLE,
  INDEX `fk_bookings_customers1_idx` (`customers_customer_id` ASC) VISIBLE,
  INDEX `fk_bookings_staffs1_idx` (`staffs_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_customers1`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_staffs1`
    FOREIGN KEY (`staffs_staff_id`)
    REFERENCES `LittleLemonDB`.`staffs` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
