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
  `id` INT NOT NULL,
  `country_name` VARCHAR(255) NOT NULL,
  `country_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `country_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `country_name_UNIQUE` (`country_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`city` (
  `id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `city_name` VARCHAR(100) NOT NULL,
  `postal_code` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `city_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_city_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `LittleLemonDB`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
  `id` INT NOT NULL,
  `city_id` INT NULL,
  `customer_name` VARCHAR(255) NULL,
  `contact_number` BIGINT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_customers_city_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `LittleLemonDB`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_items` (
  `id` INT NOT NULL,
  `course_name` VARCHAR(45) NULL,
  `starter_name` VARCHAR(45) NULL,
  `side_name` VARCHAR(45) NULL,
  `desert_name` VARCHAR(45) NULL,
  `drink_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `menu_items_id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menus` (
  `id` INT NOT NULL,
  `menu_items_id` INT NOT NULL,
  `cuisine` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menus_menu_items1_idx` (`menu_items_id` ASC) VISIBLE,
  CONSTRAINT `fk_menus_menu_items1`
    FOREIGN KEY (`menu_items_id`)
    REFERENCES `LittleLemonDB`.`menu_items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `id` INT NOT NULL,
  `customer_id` INT NULL,
  `menu_id` INT NULL,
  `order_date` DATE NULL,
  `delivery_date` DATE NULL,
  `sales` DECIMAL(3) NULL,
  `cost` DECIMAL(2) NULL,
  `delivery_cost` DECIMAL(2) NULL,
  `quantity` INT NULL,
  `discount` DECIMAL(2) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `order_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_menus1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_menus1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staffs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_name` VARCHAR(45) NULL,
  `staff_role` VARCHAR(45) NULL,
  `contact_number` INT NULL,
  `annual_salary` INT NULL,
  `staffscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `staff_id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL,
  `staff_id` INT NULL,
  `booking_date` DATE NULL,
  `table_number` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `booking_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_bookings_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_bookings_staffs1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `LittleLemonDB`.`staffs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
