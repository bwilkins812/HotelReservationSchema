-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema HotelReservation
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HotelReservation
-- -----------------------------------------------------

DROP DATABASE IF EXISTS HotelReservation;

CREATE SCHEMA IF NOT EXISTS `HotelReservation` DEFAULT CHARACTER SET utf8mb4 ;
USE `HotelReservation` ;

-- -----------------------------------------------------
-- Table `HotelReservation`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`Customers` (
  `CustomerID` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(30) NOT NULL,
  `MiddleInitial` VARCHAR(2) NULL DEFAULT NULL,
  `LastName` VARCHAR(30) NOT NULL,
  `Suffix` VARCHAR(5) NULL DEFAULT NULL,
  `StreetAddress1` VARCHAR(30) NOT NULL,
  `StreetAddress2` VARCHAR(30) NULL DEFAULT NULL,
  `City` VARCHAR(30) NOT NULL,
  `State` VARCHAR(30) NOT NULL,
  `Zipcode` VARCHAR(10) NOT NULL,
  `Country` VARCHAR(15) NULL DEFAULT NULL,
  `Phone` VARCHAR(24) NULL DEFAULT NULL,
  `Email` VARCHAR(30) NULL DEFAULT NULL,
  `CompanyName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `HotelReservation`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`Reservations` (
  `ReservationID` INT(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` INT(11) NOT NULL,
  PRIMARY KEY (`ReservationID`),
  INDEX `fk_Reservations_Customers1_idx` (`CustomerID` ASC),
  CONSTRAINT `fk_Reservations_Customers1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `HotelReservation`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`DateRange`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`DateRange` (
  `DateRangeID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` INT NOT NULL,
  `CheckInDate` DATE NOT NULL,
  `CheckOutDate` DATE NOT NULL,
  `TotalNights` INT(5) NULL,
  PRIMARY KEY (`DateRangeID`),
  INDEX `fk_DateRange_Reservations1_idx` (`ReservationID` ASC),
  CONSTRAINT `fk_DateRange_Reservations1`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `HotelReservation`.`PromotionCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`PromotionCode` (
  `PromoCodeID` INT(11) NOT NULL AUTO_INCREMENT,
  `PromoName` VARCHAR(30) NULL DEFAULT NULL,
  `PromoCode` VARCHAR(10) NULL DEFAULT NULL,
  `DollarAmountOff` DECIMAL(7,2) NULL,
  `PercentageOff` DECIMAL(2,2) NULL,
  `StartDate` DATE NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`PromoCodeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `HotelReservation`.`ReservationsPromotionCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`ReservationsPromotionCode` (
  `ReservationsPromoCodeID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` INT(11) NOT NULL,
  `PromoCodeID` INT(11) NOT NULL,
  INDEX `fk_Reservations_has_PromotionCode_PromotionCode1_idx` (`PromoCodeID` ASC),
  INDEX `fk_Reservations_has_PromotionCode_Reservations1_idx` (`ReservationID` ASC),
  PRIMARY KEY (`ReservationsPromoCodeID`),
  CONSTRAINT `fk_ReservationsPromotionCode_Reservations1`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationsPromotionCode_PromotionCode1`
    FOREIGN KEY (`PromoCodeID`)
    REFERENCES `HotelReservation`.`PromotionCode` (`PromoCodeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`AddOns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`AddOns` (
  `AddOnID` INT(11) NOT NULL AUTO_INCREMENT,
  `AddOnName` VARCHAR(45) NOT NULL,
  `AddOnPrice` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`AddOnID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`ReservationsAddOns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`ReservationsAddOns` (
  `ReservationsAddOnsID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` INT(11) NOT NULL,
  `AddOnID` INT(11) NOT NULL,
  `AddOnDate` DATE NOT NULL,
  INDEX `fk_Reservations_has_AddOns_AddOns1_idx` (`AddOnID` ASC),
  INDEX `fk_Reservations_has_AddOns_Reservations1_idx` (`ReservationID` ASC),
  PRIMARY KEY (`ReservationsAddOnsID`),
  CONSTRAINT `fk_ReservationsAddOns_Reservations1`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationsAddOns_AddOns1`
    FOREIGN KEY (`AddOnID`)
    REFERENCES `HotelReservation`.`AddOns` (`AddOnID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomCharges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomCharges` (
  `RoomChargeID` INT NOT NULL AUTO_INCREMENT,
  `RoomChargeName` VARCHAR(45) NOT NULL,
  `RoomChargeItem` VARCHAR(45) NULL,
  `RoomChargePrice` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`RoomChargeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`ReservationsRoomCharges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`ReservationsRoomCharges` (
  `ReservationRoomChargesID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` INT(11) NOT NULL,
  `RoomChargeID` INT NOT NULL,
  `ChargeDate` DATE NOT NULL,
  INDEX `fk_Reservations_has_RoomCharges_RoomCharges1_idx` (`RoomChargeID` ASC),
  INDEX `fk_Reservations_has_RoomCharges_Reservations1_idx` (`ReservationID` ASC),
  PRIMARY KEY (`ReservationRoomChargesID`),
  CONSTRAINT `fk_ReservationsRoomCharges_Reservations1`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationsRoomCharges_RoomCharges1`
    FOREIGN KEY (`RoomChargeID`)
    REFERENCES `HotelReservation`.`RoomCharges` (`RoomChargeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`Invoice` (
  `ReservationID` INT(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` INT(11) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `ReservationsPromoCodeID` INT(11) NULL,
  `RoomRate` FLOAT(7,2) NOT NULL,
  `TotalNights` INT(5) NOT NULL,
  `TotalRoomRate` DECIMAL(7,2) NOT NULL,
  `ReservationsRoomChargesID` INT(11) NULL,
  `RoomChargeName` VARCHAR(45) NULL,
  `RoomChargePrice` DECIMAL(7,2) NULL,
  `ReservationsAddOnsID` INT(11) NULL,
  `AddOnName` VARCHAR(45) NULL,
  `AddOnPrice` DECIMAL(7,2) NULL,
  `Subtotal` FLOAT(7,2) NULL,
  `Taxes` FLOAT(7,2) NOT NULL,
  `Total` INT(11) NOT NULL,
  PRIMARY KEY (`ReservationID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC),
  INDEX `ReservationsPromoCodeID_idx` (`ReservationsPromoCodeID` ASC),
  INDEX `ReservationsAddOnsID_idx` (`ReservationsAddOnsID` ASC),
  INDEX `ReservationsRoomChargesID_idx` (`ReservationsRoomChargesID` ASC),
  CONSTRAINT `ReservationID`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `HotelReservation`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ReservationsPromoCodeID`
    FOREIGN KEY (`ReservationsPromoCodeID`)
    REFERENCES `HotelReservation`.`ReservationsPromotionCode` (`ReservationsPromoCodeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ReservationsAddOnsID`
    FOREIGN KEY (`ReservationsAddOnsID`)
    REFERENCES `HotelReservation`.`ReservationsAddOns` (`ReservationsAddOnsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ReservationsRoomChargesID`
    FOREIGN KEY (`ReservationsRoomChargesID`)
    REFERENCES `HotelReservation`.`ReservationsRoomCharges` (`ReservationRoomChargesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomAmenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomAmenities` (
  `AmenityID` INT(11) NOT NULL AUTO_INCREMENT,
  `AmenityName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`AmenityID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomInformation` (
  `RoomID` INT(11) NOT NULL AUTO_INCREMENT,
  `FloorNumber` VARCHAR(5) NOT NULL,
  `RoomNumber` VARCHAR(5) NOT NULL,
  `OccupancyLimit` INT(250) NOT NULL,
  `SmokingNonSmoking` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`RoomID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomOccupants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomOccupants` (
  `OccupantID` INT(11) NOT NULL AUTO_INCREMENT,
  `RoomID` INT(11) NOT NULL,
  `FirstName` VARCHAR(30) NOT NULL,
  `MiddleInitial` VARCHAR(2) NULL DEFAULT NULL,
  `LastName` VARCHAR(30) NOT NULL,
  `AgeIfUnder18` TINYINT(2) NULL DEFAULT NULL,
  PRIMARY KEY (`OccupantID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomType` (
  `RoomTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `RoomType` VARCHAR(30) NOT NULL,
  `StandardRate` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`RoomTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomInformationRoomAmenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomInformationRoomAmenities` (
  `RoomInformationRoomAmenitiesID` INT(11) NOT NULL AUTO_INCREMENT,
  `RoomID` INT(11) NOT NULL,
  `AmenityID` INT(11) NOT NULL,
  INDEX `fk_RoomInformation_has_RoomAmenities_RoomAmenities1_idx` (`AmenityID` ASC),
  INDEX `fk_RoomInformation_has_RoomAmenities_RoomInformation1_idx` (`RoomID` ASC),
  PRIMARY KEY (`RoomInformationRoomAmenitiesID`),
  CONSTRAINT `fk_RoomInformation_has_RoomAmenities_RoomInformation1`
    FOREIGN KEY (`RoomID`)
    REFERENCES `HotelReservation`.`RoomInformation` (`RoomID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoomInformation_has_RoomAmenities_RoomAmenities1`
    FOREIGN KEY (`AmenityID`)
    REFERENCES `HotelReservation`.`RoomAmenities` (`AmenityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`ReservationsRoomInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`ReservationsRoomInformation` (
  `ReservationRoomInfoID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` INT(11) NOT NULL,
  `RoomID` INT(11) NOT NULL,
  INDEX `fk_Reservations_has_RoomInformation_RoomInformation1_idx` (`RoomID` ASC),
  INDEX `fk_Reservations_has_RoomInformation_Reservations1_idx` (`ReservationID` ASC),
  PRIMARY KEY (`ReservationRoomInfoID`),
  CONSTRAINT `fk_ReservationsRoomInformation_Reservations1`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationsRoomInformation_RoomInformation1`
    FOREIGN KEY (`RoomID`)
    REFERENCES `HotelReservation`.`RoomInformation` (`RoomID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomInformationRoomType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomInformationRoomType` (
  `RoomInformationRoomTypeID` INT(10) NOT NULL AUTO_INCREMENT,
  `RoomID` INT(11) NOT NULL,
  `RoomTypeID` INT(11) NOT NULL,
  INDEX `fk_RoomInformation_has_RoomType_RoomType1_idx` (`RoomTypeID` ASC),
  INDEX `fk_RoomInformation_has_RoomType_RoomInformation1_idx` (`RoomID` ASC),
  PRIMARY KEY (`RoomInformationRoomTypeID`),
  CONSTRAINT `fk_RoomInformationRoomType_RoomInformation1`
    FOREIGN KEY (`RoomID`)
    REFERENCES `HotelReservation`.`RoomInformation` (`RoomID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoomInformationRoomType_RoomType1`
    FOREIGN KEY (`RoomTypeID`)
    REFERENCES `HotelReservation`.`RoomType` (`RoomTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`SeasonalAndEventRates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`SeasonalAndEventRates` (
  `SeasonalAndEventID` INT(11) NOT NULL AUTO_INCREMENT,
  `SeasonName` VARCHAR(45) NULL,
  `EventName` VARCHAR(45) NULL,
  `SeasonRate` DECIMAL(7,2) NULL,
  `EventRate` DECIMAL(7,2) NULL,
  `StartDate` DATE NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`SeasonalAndEventID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`ReservationsRoomOccupants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`ReservationsRoomOccupants` (
  `ReservationRoomOccupantsID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` INT(11) NOT NULL,
  `OccupantID` INT(11) NOT NULL,
  INDEX `fk_Reservations_has_RoomOccupants_RoomOccupants1_idx` (`OccupantID` ASC),
  INDEX `fk_Reservations_has_RoomOccupants_Reservations1_idx` (`ReservationID` ASC),
  PRIMARY KEY (`ReservationRoomOccupantsID`),
  CONSTRAINT `fk_ReservationsRoomOccupants_Reservations1`
    FOREIGN KEY (`ReservationID`)
    REFERENCES `HotelReservation`.`Reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationsRoomOccupants_RoomOccupants1`
    FOREIGN KEY (`OccupantID`)
    REFERENCES `HotelReservation`.`RoomOccupants` (`OccupantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HotelReservation`.`RoomTypeSeasonalAndEventRates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservation`.`RoomTypeSeasonalAndEventRates` (
  `RoomTypeSeasonalAndEventRatesID` INT(11) NOT NULL AUTO_INCREMENT,
  `RoomTypeID` INT(11) NOT NULL,
  `SeasonalAndEventID` INT(11) NOT NULL,
  INDEX `fk_RoomType_has_SeasonalAndEventRates_SeasonalAndEventRates_idx` (`SeasonalAndEventID` ASC),
  INDEX `fk_RoomType_has_SeasonalAndEventRates_RoomType1_idx` (`RoomTypeID` ASC),
  PRIMARY KEY (`RoomTypeSeasonalAndEventRatesID`),
  CONSTRAINT `fk_RoomTypeSeasonalAndEventRates_RoomType1`
    FOREIGN KEY (`RoomTypeID`)
    REFERENCES `HotelReservation`.`RoomType` (`RoomTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoomTypeSeasonalAndEventRates_SeasonalAndEventRates1`
    FOREIGN KEY (`SeasonalAndEventID`)
    REFERENCES `HotelReservation`.`SeasonalAndEventRates` (`SeasonalAndEventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO Customers(FirstName, MiddleInitial, LastName, Suffix, StreetAddress1, StreetAddress2, City, State, Zipcode, Country, Phone, Email, CompanyName)
VALUES ('Jason', 'M', 'Routledge', 'Jr.', '4563 Wardour St.', 'Apt. 21', 'Hexham', 'IN', '45332', 'USA', '812-456-3425', 'jroutledge@netmail.com', 'American Airlines'),
('Christopher', null, 'Ewing', null, '5722 Oxford St.', null, 'Leamington', 'KY', '34767', 'USA', '502-333-2211', 'cewing456@netmail.com', null),
('Mary', 'K', 'Perkins', null, '443 Tottenham Rd.', null, 'Reading', 'SD', '89765', 'USA', '453-436-7765', 'mkperkins@netmail.com', 'Apple'),
('Kim', null, 'Cassidy', null, '7832 Courtfield Ave.', null, 'Salisbury', 'ME', '14355', 'USA', '242-645-4766', 'kcassidy@netmail.com', null),
('Colton', null, 'Bray', 'III', '8976 Fleet St.', 'Apt. 4C', 'Hastings', 'TX', '56744', 'USA', '632-897-2387', null, null),
('Mackenzie', 'R', 'Hassan', null, '4325 Russell Ave', null, 'Montague', 'TN', '49837', 'USA', '647-379-2368', 'mrhassan@netmail.com', 'Oshkosh'),
('Allan', null, 'Woodcourt', null, '5723 Berners St.', null, 'London', 'IN', '24769', 'USA', '602-333-2211', 'awoodcourt456@netmail.com', null),
('Angela', 'J', 'Leath', 'Lady', '343 Wells Rd.', null, 'Chelmsford', 'KY', '89776', 'USA', '353-436-7765', 'ladyleath@netmail.com', 'Apple'),
('Stephen', null, 'Blackpool', null, '7912 Titchfield Ave.', null, 'Bletchley', 'NV', '14366', 'USA', '342-645-4766', 'sblackpool@netmail.com', 'Nike'),
('George', null, 'Sampson', null, '9973 Newman St.', 'Apt. 4C', 'Luton', 'WA', '56755', 'USA', '532-897-2387', null, null),
('Rosa', 'P.', 'Dartle', null, '5426 Rathbone Ave', null, 'Andover', 'OR', '49837', 'USA', '747-379-2368', 'rosadartle@netmail.com', 'Allstate'),
('Samuel', null, 'Wilkins', null, '6772 Windmill St.', null, 'Woking', 'Cheshire', '34778', 'UK', '402-333-2211', 'samwilkins98@netmail.com', null),
('Daniel', 'G.', 'Grummer', 'Jr.', '813 Howland Rd.', null, 'Basingstoke', 'MT', '89776', 'USA', '353-436-7765', 'dangrummer56@netmail.com', 'Apple'),
('Mary', null, 'Marshall', null, '9731 Whitfield Ave.', null, 'Powis', 'PA', '14355', 'USA', '142-645-4766', 'marymarshall65@netmail.com', null),
('Septimus', null, 'Crisparkle', 'Revd.', '7776 Huntley St.', 'Apt. 4C', 'Stirling', 'OH', '56746', 'USA', '532-897-2387', null, null),
('John', 'E.', 'Nandy', null, '1326 Percy Mews Ave', null, 'Aberfoyle', 'MI', '49837', 'USA', '547-379-2368', 'mrhassan@netmail.com', null),
('Adelina', null, 'Fareway', null, '8621 Hanway Pl.', null, 'Stevenage', 'Oxfordshire', '34768', 'UK', '602-333-2211', 'adelinaf77@netmail.com', 'Nike'),
('Bobtail', 'C.', 'Widger', null, '783 Beaumont Rd.', null, 'Banbury', 'AL', '89766', 'USA', '553-436-7765', 'bobcat88@netmail.com', 'Apple'),
('Phil', null, 'Parkes', null, '9842  Bickenhall Ave.', null, 'Lavenham', 'MS', '14356', 'USA', '242-645-4766', 'philparkes@netmail.com', null),
('Emma', null, 'Fielding', null, '8976 Chagford St.', 'Apt. 4C', 'Sudbury', 'TN', '56745', 'USA', '732-897-2387', null, 'Nike'),
('Thomas', 'B.', 'Spruggins', 'Jr.', '4425 Enford Ave', null, 'Dartford', 'Kassell', '49838', 'GER', '747-379-2368', 'jrspruggins@netmail.com', null),
('Samuel', null, 'Wilkins', null, '3721 Linhope St.', null, 'Tenterden', 'ND', '34768', 'USA', '502-333-2211', 'samwilkins84@netmail.com', null),
('Mary', 'A.', 'Perkinsop', null, '452 Wyndham Rd.', null, 'Seven Oaks', 'SD', '89766', 'USA', '453-436-7764', 'perkinsop22@netmail.com', 'Apple'),
('Alexander', null, 'Manette', 'Dr.', '3332  Radnor Ave.', null, 'Rye', 'WY', '24355', 'USA', '242-645-4765', 'drmanette@netmail.com', null),
('Horace', null, 'Crewler', 'Revd.', '4012 Molyneux St.', 'Apt. 4C', 'Battle', 'CO', '66744', 'USA', '632-897-2386', null, null),
('Bill', 'S.', 'Barley', null, '7725 Crawford Ave', null, 'Portsmouth', 'Offenbach', '59837', 'GER', '647-379-2369', 'billbarley@netmail.com', null),
('Elizabeth', null, 'Tippins', 'Lady', '6455 Norfolk Sq.', null, 'Whitchurch', 'NM', '44767', 'USA', '502-332-2211', 'ladybethtippins@netmail.com', 'Caterpillar'),
('Richard', 'M.', 'Evans', null, '421 Burton Rd.', null, 'Stirling', 'TX', '99765', 'USA', '453-336-7765', 'richevans54@netmail.com', 'Apple'),
('Olympia', null, 'Squires', null, '7112 Tonbridge Ave.', null, 'Powis', 'FL', '24355', 'USA', '242-445-4766', 'olympia11@netmail.com', null),
('George', null, 'Hayling', 'Sir', '4456 Thanet St.', 'Apt. 4C', 'Hastings', 'TX', '66744', 'USA', '632-797-2387', null, null),
('Lucy', 'H.', 'Green', null, '8825 Heathcote Ave', null, 'Luton', 'LA', '59837', 'USA', '647-389-2368', 'lucygreen49@netmail.com', 'Caterpillar'),
('Esther', null, 'Summerson', null, '7776 Huntley St.', 'Apt. 2B', 'Leamington', 'IN', '34768', 'USA', '502-334-2211', 'esther31@netmail.com', 'Allstate'),
('Nettie', 'Z.', 'Ashford', null, '443 Tottenham Rd.', null, 'Bletchley', 'KY', '89776', 'USA', '453-439-7765', 'ashford29@netmail.com', 'Apple'),
('Edmund', 'H.', 'Longford', 'Sir', '7832 Courtfield Ave.', null, 'Andover', 'GA', '14355', 'USA', '242-345-4766', 'marthamydear@netmail.com', 'Allstate'),
('Martha', null, 'Varden', null, '8976 Fleet St.', 'Apt. 3B', 'Haverhill', 'TX', '56746', 'USA', '632-891-2387', null, null),
('Anthony', 'I.', 'Jeddler', null, '4325 Russell Ave', null, 'Ipswich', 'TN', '49837', 'USA', '647-329-2368', 'tonyjeddler72@netmail.com', null);

INSERT INTO Reservations(CustomerID)
VALUES (12),
(24),
(36),
(10),
(22),
(34),
(8),
(20),
(32),
(6),
(18),
(30),
(4),
(16),
(28),
(2),
(14),
(26),
(1),
(13),
(25),
(3),
(11),
(23),
(5),
(21),
(7),
(5),
(19),
(3),
(21),
(35),
(25),
(27),
(29),
(31),
(33),
(35),
(8),
(10),
(30),
(28),
(2),
(26),
(11),
(9),
(9),
(21),
(4);

INSERT INTO RoomType (RoomType, StandardRate)
VALUES('Single', 129.99),
('Double', 159.99),
('King', 179.99),
('Suite', 229.99),
('Conference', 499.99),
('Accessible', 99.99);

INSERT INTO DateRange(ReservationID, CheckInDate, CheckOutDate, TotalNights)
VALUES(1, '2017/08/08', '2017/08/09', 1),
(2, '2017/12/09', '2017/12/16', 7),
(3, '2017/10/08', '2017/10/08', 1),
(4, '2017/09/08', '2017/09/12', 4),
(5, '2017/02/12', '2017/02/15', 3),
(6, '2018/12/28', '2019/01/04', 7),
(7, '2018/10/30', '2018/11/04', 4),
(8, '2018/08/22', '2018/08/28', 6),
(9, '2018/09/17', '2018/09/22', 5),
(10, '2019/01/02', '2019/01/08', 6),
(11, '2018/12/11', '2018/12/16', 5),
(12, '2018/10/18', '2018/10/20', 2),
(13, '2018/08/04', '2018/08/05', 1),
(14, '2018/09/08', '2018/09/08', 1),
(15, '2019/11/10', '2018/11/14', 4),
(16, '2018/12/22', '2018/12/29', 7),
(17, '2018/10/19', '2018/10/24', 5),
(18, '2018/08/14', '2018/08/18', 4),
(19, '2018/09/30', '2018/10/04', 4),
(20, '2019/11/28', '2018/12/03', 5),
(21, '2018/12/30', '2019/01/05', 6),
(22, '2018/10/31', '2018/11/06', 6),
(23, '2018/08/31', '2018/09/04', 4),
(24, '2018/11/29', '2018/12/06', 7),
(25, '2019/10/31', '2018/11/10', 10),
(26, '2018/12/31', '2018/01/13', 13),
(27, '2018/10/28', '2018/11/05', 8),
(28, '2018/09/30', '2018/10/02', 2),
(29, '2019/10/26', '2019/11/01', 6);

INSERT INTO PromotionCode(PromoName, PromoCode, DollarAmountOff, PercentageOff, StartDate, EndDate)
VALUES ('StandardPromo', 'Standard', null, .90, null, null),
('EmployeeDiscount', 'Employee', null, .85, null, null),
('SummerSavings', 'SumSave18', 20.00, null, '2018/05/20', '2018/09/10'),
('MegaBlast', 'Blast18', 50.00, null, '2018/08/01', '2018/08/31');

INSERT INTO RoomCharges(RoomChargeName, RoomChargeItem, RoomChargePrice)
VALUES('Dry Cleaning', 'Shirt', 29.33),
('Dry Cleaning', 'Dress', 43.22),
('Energy Use', null, 7.99),
('Extra Cleaning',null, 49.99),
('Room Service', 'Fries', 5.50),
('Room Service', 'Steak Dinner', 35.42),
('Room Service', 'Burger Meal', 17.88);

INSERT INTO RoomInformation (FloorNumber, RoomNumber, OccupancyLimit, SmokingNonSmoking)
VALUES ('1', '101', 2, 'N'),
('1', '102', 2, 'N'),
('1', '103', 2, 'N'),
('1', '104', 2, 'N'),
('1', '105', 4, 'N'),
('1', '106', 4, 'N'),
('1', '107', 4, 'N'),
('1', '108', 4, 'N'),
('1', '109', 4, 'N'),
('1', '110', 4, 'Y'),
('2', '201', 4, 'N'),
('2', '202', 4, 'N'),
('2', '203', 4, 'N'),
('2', '204', 4, 'N'),
('2', '205', 4, 'N'),
('2', '206', 4, 'N'),
('2', '207', 4, 'N'),
('2', '208', 4, 'N'),
('2', '209', 4, 'N'),
('2', '210', 4, 'Y'),
('3', '301', 4, 'N'),
('3', '302', 4, 'N'),
('3', '303', 4, 'N'),
('3', '304', 4, 'N'),
('3', '305', 4, 'N'),
('3', '306', 4, 'N'),
('3', '307', 6, 'N'),
('3', '308', 6, 'N'),
('3', '309', 8, 'N'),
('3', '310', 8, 'Y'),
('1', 'CRA', 200, 'N'),
('2', 'CRB', 100, 'N'),
('3', 'CRC', 50, 'N');

INSERT INTO ReservationsRoomInformation(ReservationID, RoomID)
VALUES (1, 15),
(2, 14),
(3, 13),
(4, 12),
(5, 11),
(6, 10),
(7, 9),
(8, 8),
(9, 7),
(10, 6),
(11, 5),
(12, 4),
(13, 3),
(14, 2),
(15, 1),
(16, 33),
(17, 32),
(18, 31),
(19, 30),
(20, 29),
(21, 28),
(22, 29),
(23, 28),
(24, 27),
(25, 25),
(26, 24),
(27, 23),
(28, 7),
(29, 9),
(7, 8),
(14, 22),
(23, 5),
(28, 16),
(12, 7),
(18, 7),
(20, 33);

INSERT INTO RoomInformationRoomType(RoomID, RoomTypeID)
VALUES(1,1),
(2,1),
(3,1),
(4,1),
(5,6),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2),
(13,2),
(14,2),
(15,6),
(16,2),
(17,2),
(18,2),
(19,2),
(20,2),
(21,2),
(22,2),
(23,2),
(24,2),
(25,6),
(26,2),
(27,3),
(28,3),
(29,4),
(30,4),
(31,5),
(32,5),
(33,5);

INSERT INTO RoomAmenities(AmenityName)
VALUES('Refrigerator'),
('Microwave'),
('Widescreen TV'),
('Sleep Number Bed'),
('Balcony'),
('Nespresso'),
('Jacuzzi'),
('Kitchenette');

INSERT INTO RoomInformationRoomAmenities(RoomID, AmenityID)
VALUES(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(11,2),
(12,2),
(13,2),
(14,2),
(15,2),
(16,2),
(17,2),
(18,2),
(19,2),
(20,2),
(31,6),
(32,6),
(33,6),
(21,1),
(21,2),
(22,1),
(22,2),
(23,1),
(23,2),
(24,5),
(25,5),
(26,5),
(24,8),
(25,8),
(26,8),
(27,1),
(28,1),
(27,2),
(28,2),
(27,3),
(28,3),
(27,4),
(28,4),
(29,3),
(29,4),
(29,5),
(29,6),
(29,7),
(29,8),
(30,3),
(30,4),
(30,5),
(30,6),
(30,7),
(30,8);

INSERT INTO AddOns(AddOnName, AddOnPrice)
VALUES('Airport Transfer', 35.00),
('Local Travel Guide (1 Day)', 199.00),
('Box of Chocolates', 39.99),
('Champagne upon Arrival', 129.99),
('Bouquet of Roses', 89.99);

INSERT INTO RoomOccupants(RoomID, FirstName, MiddleInitial, LastName, AgeIfUnder18)
VALUES (15, 'Jason', 'M', 'Routledge', null),
(15, 'Kylee', null, 'Routledge', null),
(14, 'Christopher', null, 'Ewing', null),
(14, 'Melody', 'R.', 'Ewing', null),
(13, 'Mary', 'K', 'Perkins', null),
(13, 'Theodore', 'J.', 'Perkins', null),
(12, 'Bobtail', 'C.', 'Widger', null),
(12, 'Catherine', null, 'Widger', null),
(11, 'Richard', 'M.', 'Evans', null),
(11, 'Adalynn', null, 'Evans', null),
(11, 'Jayla', 'M.', 'Evans', 12),
(11, 'Alexia', 'B.', 'Evans', 10),
(10, 'Rosa', 'P', 'Dartle', null),
(10, 'Emmett', null, 'Dartle', null),
(9, 'Mary', null, 'Marshall', null),
(9, 'Brady', 'T.', 'Marshall', null),
(9, 'Cayden', 'R.', 'Marshall', 8),
(8, 'Bill', 'S', 'Barley', null),
(8, 'Izabella', null, 'Barley', null),
(7, 'Rosa', 'P.', 'Dartle', null),
(7, 'Emmett', null, 'Dartle', null),
(6, 'Rosa', 'P.', 'Dartle', null),
(6, 'Emmett', null, 'Dartle', null),
(6, 'Norah', null, 'Dartle', 5),
(5, 'Samuel', null, 'Wilkins', null),
(4, 'Mackenzie', 'R', 'Hassan', null),
(3, 'Stephen', null, 'Blackpool', null),
(2, 'Emma', null, 'Fielding', null),
(1, 'Anthony', 'I.', 'Jeddler', null),
(33, 'Colton', null, 'Bray', null),
(33, 'Hayden', null, 'Bray', null),
(32, 'Phil', null, 'Parkes', null),
(31, 'Nettie', 'Z.', 'Ashford', null),
(30, 'Thomas', 'B.', 'Spruggins', null),
(30, 'Fiona', null, 'Spruggins', null),
(30, 'Bennett', null, 'Spruggins', 14),
(30, 'Calvin', null, 'Spruggins', 16),
(29, 'George', null, 'Hayling', null),
(29, 'Mark', null, 'Hayling', 17),
(28, 'Bobtail', 'C.', 'Widger', null),
(29, 'Olympia', null, 'Squires', null),
(28, 'Kim', null, 'Cassidy', null),
(28, 'Luna', null, 'Cassidy', 9),
(27, 'John', 'E.', 'Nandy', null),
(25, 'Elizabeth', null, 'Tippins', null),
(24, 'Allan', null, 'Woodcourt', null),
(23, 'Mary', 'A', 'Perkinsop', null),
(7, 'George', null, 'Sampson', null),
(9, 'Angela', 'J.', 'Leath', null),
(8, 'Mary', null, 'Marshall', null),
(22, 'Emma', null, 'Fielding', null),
(5, 'Kim', null, 'Cassidy', null),
(16, 'George', null, 'Sampson', null),
(7, 'Mackenzie', 'R.', 'Hassan', null),
(7, 'Nettie', 'Z.', 'Ashford', null),
(33, 'George', null, 'Hayling', null);

INSERT INTO ReservationsRoomOccupants(ReservationID, OccupantID)
VALUES (1,1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(5, 11),
(5, 12),
(6, 13),
(6, 14),
(7, 15),
(7, 16),
(7, 17),
(8, 18),
(8, 19),
(9, 20),
(9, 21),
(10, 22),
(10, 23),
(10, 24),
(11, 25),
(12, 26),
(13, 27),
(14, 28),
(15, 29),
(16, 30),
(16, 31),
(17, 32),
(18, 33),
(19, 34),
(19, 35),
(19, 36),
(19, 37),
(20, 38),
(20, 39),
(21, 40),
(22, 41),
(23, 42),
(23, 43),
(24, 44),
(25, 45),
(26, 46),
(27, 47),
(28, 48),
(29, 49),
(7, 50),
(14, 51),
(23, 52),
(28, 53),
(12, 54),
(18, 55),
(20, 56);

INSERT INTO ReservationsPromotionCode(ReservationID, PromoCodeID)
VALUES (4, 2),
(7, 1),
(14, 4),
(22, 3),
(25, 4),
(11, 3);

INSERT INTO SeasonalAndEventRates(SeasonName, EventName, SeasonRate, EventRate, StartDate, EndDate)
VALUES('Peak 2018', null, 1.00, null, '2018/05/20', '2018/09/10'),
('Shoulder Fall 2018', null, .80, null, '2018/09/11', '2019/01/05'),
('Off Winter 2018 to 2019', null, .70, null, '2019/01/06', '2019/03/01'),
('Shoulder Spring 2019', null, .80, null, '2019/03/02', '2019/05/19'),
('Peak Summer 2019', null, 1.00, null, '2019/05/20', '2019/09/10'),
(null, 'Tech Convention', null, 1.25, '2018/09/20', '2018/09/27'),
(null, 'Horror Convention', null, 1.25, '2018/10/27', '2018/11/01'),
(null, 'Mystery Writers Convention', null, 1.00, '2019/01/20', '2019/01/24'),
(null, 'Baseball Convention', 1.00, null, '2019/03/20', '2019/03/27');

INSERT INTO RoomTypeSeasonalAndEventRates(RoomTypeID, SeasonalAndEventID)
VALUES(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(6, 7),
(6, 8),
(6, 9);

INSERT INTO ReservationsRoomCharges(ReservationID, RoomChargeID, ChargeDate)
VALUES (12, 4, '2018/12/15'),
(7, 1, '2018/12/31'),
(25, 3, '2018/12/04'),
(18, 2, '2018/11/01'),
(4, 5, '2018/10/08'),
(10, 7, '2018/10/19'),
(27, 6, '2019/01/10'),
(29, 4, '2018/10/01');

INSERT INTO ReservationsAddOns(ReservationID, AddOnID, AddOnDate)
VALUES (12, 4, '2018/10/19'),
(3, 1, '2018/10/08'),
(22, 3, '2018/10/31'),
(17, 2, '2018/10/23'),
(8, 2, '2018/08/22'),
(25, 5, '2018/11/02'),
(23, 3, '2018/09/02'),
(4, 4, '2018/09/08'),
(9, 3, '2018/09/17');

INSERT INTO Invoice (ReservationID, CustomerID, FirstName, LastName, ReservationsPromoCodeID, RoomRate, TotalNights, TotalRoomRate, ReservationsRoomChargesID, RoomChargeName, RoomChargePrice, ReservationsAddOnsID, AddOnName, AddOnPrice, Subtotal, Taxes, Total)
VALUES(1, 1, 'Jason', 'Routledge', null, 99.99, 1, 99.99, null, null, null, null, null, null, 99.99, 7.00, 106.99),
(2, 2, 'Christopher', 'Ewing', null, 159.99, 7, 1119.93, null, null, null, null, null, null, 1119.93, 78.40, 1198.33),
(3, 3, 'Mary', 'Perkins', null, 159.99, 1, 159.99, null, null, null, 2, 'Airport Transfer', 35.00, 194.99, 13.65, 208.64),
(4, 18, 'Bobtail', 'Widger', 2, 135.99, 4, 543.96, 5, 'Room Service', 5.50, 8, 'Champagne Upon Arrival', 129.99, 679.45, 47.56, 727.01),
(5, 28, 'Richard', 'Evans', null, 159.99, 3, 479.97, null, null, null, null, null, null, 479.97, 33.60, 513.57);
