DROP DATABASE IF EXISTS WebStorage;

CREATE DATABASE WebStorage
    CHARACTER SET utf8
    COLLATE utf8_general_ci;

USE WebStorage;

DROP TABLE IF EXISTS User;
CREATE TABLE User (
    Id int NOT NULL AUTO_INCREMENT,
    FullName varchar(60) NOT NULL,
    UserName varchar(30) NOT NULL,
    Email varchar(120) NOT NULL,
    Password varchar(120) NOT NULL,
    Registration datetime NOT NULL DEFAULT NOW(),
    Blocked boolean NOT NULL DEFAULT false,
    MaximumStorage int(4) NOT NULL DEFAULT 5,
    PRIMARY KEY (Id),
    UNIQUE KEY (UserName, Email)
);

DROP TABLE IF EXISTS StorageType;
CREATE TABLE StorageType(
    Id int NOT NULL AUTO_INCREMENT,
    SSHEnabled boolean NOT NULL DEFAULT false,
    PHPEnabled boolean NOT NULL DEFAULT false,
    MaximumEmailAccounts int(5) NULL,
    MaximumFTPAccounts int(5) NULL,
    MaximumDatabaseNumber int(5) NULL,
    PHPMemoryLimit int(6) NULL,
    MaximumPHPExecutionTime int(3) NULL,
    CPanelIsEnabled boolean NOT NULL DEFAULT false,
    BaseCost decimal NOT NULL,
    DataTrafficMultiplier int(3) NOT NULL DEFAULT 1,
    Name varchar(120) NOT NULL,
    PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS DataCenter;
CREATE TABLE DataCenter(
    Id int NOT NULL AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
    City varchar(80) NOT NULL,
    Number int(2) NOT NULL,
    Area decimal NULL,
    StorageCapacity int NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY (Name)
);

DROP TABLE IF EXISTS Storage;
CREATE TABLE Storage(
    Id int NOT NULL AUTO_INCREMENT,
    UserId int NOT NULL,
    Creation datetime NOT NULL DEFAULT NOW(),
    Expiration datetime NOT NULL DEFAULT DATE_ADD(NOW(), INTERVAL 1 YEAR),
    TypeId int NOT NULL,
    Size int(6) NOT NULL,
    MaximumDataTraffic int(6) NOT NULL,
    EmailStorageSize int(6) NULL,
    DatabaseSize int(6) null,
    DataCenterId int NOT NULL,
    Cost decimal NOT NULL,
    Name varchar(80) NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY (UserId, Name),
    FOREIGN KEY (UserId) REFERENCES User(Id),
    FOREIGN KEY (TypeId) REFERENCES StorageType(Id),
    FOREIGN KEY (DataCenterId) REFERENCES DataCenter(Id)
);


DROP TABLE IF EXISTS Domain;
CREATE TABLE Domain(
    Id int NOT NULL AUTO_INCREMENT,
    UserId int NOT NULL,
    DomainAddress varchar(253) NOT NULL,
    StorageId int NULL,
    TLD varchar(63) NOT NULL,
    Registration datetime NOT NULL DEFAULT NOW(),
    Expiration datetime NOT NULL DEFAULT DATE_ADD(NOW(), INTERVAL 1 YEAR),
    NameServer1 varchar(253) NOT NULL,
    NameServer2 varchar(253) NULL,
    NameServer3 varchar(253) NULL,
    NameServer4 varchar(253) NULL,
    PRIMARY KEY (Id),
    UNIQUE (DomainAddress, TLD),
    FOREIGN KEY (UserId) REFERENCES User(Id),
    FOREIGN KEY (StorageId) REFERENCES Storage(Id)
);


DROP TABLE IF EXISTS Bill;
CREATE TABLE Bill(
    Id int NOT NULL AUTO_INCREMENT,
    UserId int NULL,
    StorageId int NULL,
    DomainId int NULL,
    Date datetime NOT NULL DEFAULT NOW(),
    Deadline datetime NOT NULL DEFAULT DATE_ADD(NOW(), INTERVAL 1 MONTH),
    Cost decimal NOT NULL,
    BillId varchar(18) NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY (BillId),
    FOREIGN KEY (UserId) REFERENCES User(Id),
    FOREIGN KEY (StorageId) REFERENCES Storage(Id),
    FOREIGN KEY (DomainId) REFERENCES Domain(Id)
);

DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment(
    Id int NOT NULL AUTO_INCREMENT,
    UserId int NOT NULL,
    Date datetime NOT NULL DEFAULT NOW(),
    TransactionId varchar(30) NOT NULL,
    BillId int NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY (TransactionId),
    FOREIGN KEY (UserId) REFERENCES User(Id),
    FOREIGN KEY (BillId) REFERENCES Bill(Id)
);

DROP TABLE IF EXISTS Statistic;
CREATE TABLE Statistic(
    Id int NOT NULL AUTO_INCREMENT,
    DomainId int NOT NULL,
    Month DATE NOT NULL,
    Views int NOT NULL DEFAULT 0,
    UniqueViewers int NOT NULL DEFAULT 0,
    PRIMARY KEY (Id),
    UNIQUE KEY (DomainId, Month),
    FOREIGN KEY (DomainId) REFERENCES Domain(Id)
);

DROP TABLE IF EXISTS Notification;
CREATE TABLE Notification(
    Id int NOT NULL AUTO_INCREMENT,
    UserId int NULL,
    StorageId int NULL,
    DomainId int NULL,
    Creation datetime NOT NULL DEFAULT NOW(),
    TimeFrameStart datetime NULL,
    TimeFrameEnd datetime NULL,
    Title varchar(100) NOT NULL,
    Message longtext NOT NULL,
    IsActive boolean NOT NULL DEFAULT TRUE,
    PRIMARY KEY (Id),
    FOREIGN KEY (UserId) REFERENCES User(Id),
    FOREIGN KEY (StorageId) REFERENCES Storage(Id),
    FOREIGN KEY (DomainId) REFERENCES Domain(Id)
);

/**
    FUNCTIONS
**/
DELIMITER ;;

CREATE FUNCTION `GetStoragePrice` (`_type` int, `_size` int, `_traffic` int, `_email_storage` int, `_database_size` int) RETURNS decimal(10,0) unsigned
BEGIN
DECLARE _base decimal;
DECLARE _price decimal;

SET _base = (SELECT BaseCost FROM StorageType WHERE Id=_type);
SET _price = _base;

SET _price = _price + ((_size + _email_storage + _database_size) * 0.01 * _base / 500);
SET _price = _price + ((SELECT DataTrafficMultiplier FROM StorageType WHERE Id=_type) * _traffic * 0.1);

RETURN _price;
END;;

CREATE FUNCTION `AreLimitsReached` (`_user` int) RETURNS bool
BEGIN
DECLARE _limited bool;
DECLARE _has_invoice bool;

SET _limited = (SELECT (Blocked OR MaximumStorage <= COUNT(s.Id)) AS limited FROM User LEFT JOIN Storage s ON User.Id=s.UserId WHERE User.Id=_user GROUP BY User.Id);
SET _has_invoice = (SELECT COUNT(Id) FROM Bill WHERE UserId=_user) <> (SELECT COUNT(Id) FROM Payment WHERE UserId=_user);

RETURN _limited OR _has_invoice;
END;;

CREATE FUNCTION `CenterName` (`_city` varchar(80), `_number` int(2)) RETURNS varchar(82)
BEGIN
   RETURN CONCAT(_city, ' - ', _number);
END ;;

CREATE FUNCTION `GetStorageNumber` (`_center` int) RETURNS int
BEGIN
    DECLARE _num int DEFAULT 0;
    SET _num = (SELECT COUNT(ss.Id) FROM Storage ss
                        WHERE ss.DataCenterId = _center);
    RETURN _num;
END ;;

CREATE FUNCTION `DomainAddress` (`_address` varchar(253), `_tld` varchar(63)) RETURNS varchar(316)
BEGIN
    RETURN CONCAT(_address, '.', _tld);
END ;;

CREATE FUNCTION `GetActiveUserNotifications` (`_user` int) RETURNS int
BEGIN
    DECLARE _num int;

    SET _num = (SELECT COUNT(n.Id) FROM User u
        INNER JOIN Notification n on u.Id = n.UserId
        WHERE n.IsActive AND u.Id = _user);

    RETURN _num + GetActiveStorageNotificationsByUser(_user) + GetActiveDomainNotificationsByUser(_user);
END ;;

CREATE FUNCTION `GetActiveStorageNotificationsByUser` (`_user` int) RETURNS int
BEGIN
    DECLARE _num int;

    SET _num = (SELECT COUNT(n.Id) FROM Storage s
        INNER JOIN Notification n on s.Id = n.StorageId
        WHERE n.IsActive AND s.UserId = _user);

    RETURN _num;
END ;;

CREATE FUNCTION `GetActiveDomainNotificationsByUser` (`_user` int) RETURNS int
BEGIN
    DECLARE _num int;

    SET _num = (SELECT COUNT(n.Id) FROM Domain d
        INNER JOIN Notification n on d.Id = n.DomainId
        WHERE n.IsActive AND d.UserId = _user);

    RETURN _num;
END ;;

CREATE FUNCTION `GetNextBillId` () RETURNS varchar(18)
BEGIN
    DECLARE _currYear int DEFAULT YEAR(NOW());

    DECLARE _bill varchar(18);
    DECLARE _number int DEFAULT 0;

    SET _bill = (SELECT b.BillId FROM Bill b
                    WHERE b.BillId LIKE CONCAT('%', _currYear, '%')
                    ORDER BY b.BillId DESC
                    LIMIT 1);

    IF _bill IS NULL OR _bill = '' THEN
        SET _number = 0;
    ELSE
        SET _number = CONVERT(SUBSTRING_INDEX(_bill, '-', -1), UNSIGNED INTEGER);
    END IF ;

    return CONCAT('BBKT-', _currYear, '-', LPAD(_number + 1, 8, '0'));
END ;;


/**
    TRIGGERS
**/

CREATE TRIGGER `CanEditUserProperties` BEFORE UPDATE ON `User` FOR EACH ROW
BEGIN

IF OLD.UserName <> NEW.UserName OR OLD.Email <> NEW.Email OR OLD.Registration <> NEW.Registration
THEN
    SIGNAL SQLSTATE 'W7001' SET MESSAGE_TEXT = 'User properties (UserName, Email, Registration) cannot be updated!';
END IF;

END;;

CREATE TRIGGER `CheckLimitsStorage` BEFORE INSERT ON `Storage` FOR EACH ROW
BEGIN

IF AreLimitsReached(NEW.UserId)
THEN
    SIGNAL SQLSTATE 'W7002' SET MESSAGE_TEXT = 'User limits reached or has unpaid invoice!';
END IF;

SET NEW.Cost = GetStoragePrice(NEW.TypeId, NEW.Size, NEW.MaximumDataTraffic, NEW.EmailStorageSize, NEW.DatabaseSize);

END;;

CREATE TRIGGER `EditStorage` BEFORE UPDATE ON `Storage` FOR EACH ROW
BEGIN

SET NEW.Cost = GetStoragePrice(NEW.TypeId, NEW.Size, NEW.MaximumDataTraffic, NEW.EmailStorageSize, NEW.DatabaseSize);

END;;

CREATE TRIGGER `CheckLimitsDomain` BEFORE INSERT ON `Domain` FOR EACH ROW
BEGIN

IF AreLimitsReached(NEW.UserId)
THEN
    SIGNAL SQLSTATE 'W7003' SET MESSAGE_TEXT = 'User limits reached or has unpaid invoice!';
END IF;

END;;

CREATE TRIGGER `AddBillId` BEFORE INSERT ON `Bill` FOR EACH ROW
BEGIN
    SET NEW.BillId = GetNextBillId();
END;;

CREATE TRIGGER `EditBillId` BEFORE UPDATE ON `Bill` FOR EACH ROW
BEGIN
    SET NEW.BillId = OLD.BillId;
END;;

DELIMITER ;

/**
    CHECK CONSTRAINTS
**/

ALTER TABLE User
    ADD CONSTRAINT chk_user_email
    CHECK (Email REGEXP '[A-Za-z0-9\+\-\=\_]{1,64}@[A-Za-z0-9\-\.]{1,253}\.[A-Za-z]{2,}');

ALTER TABLE Domain
    ADD CONSTRAINT chk_domain_domain
    CHECK (DomainAddress REGEXP '[A-Za-z0-9\-\.]{1,253}'),
    ADD CONSTRAINT chk_domain_expiration
    CHECK (Expiration > Registration);

ALTER TABLE Storage
    ADD CONSTRAINT chk_storage_expiration
    CHECK (Expiration > Creation);

ALTER TABLE StorageType
    ADD CONSTRAINT chk_storage_type_php
    CHECK ((PHPEnabled=0 AND PHPMemoryLimit IS NULL AND MaximumPHPExecutionTime IS NULL AND MaximumDatabaseNumber IS NULL) OR PHPEnabled=1);

ALTER TABLE Bill
    ADD CONSTRAINT chk_bill_bill_id
    CHECK (BillId REGEXP 'BBKT-[0-9]{4}-[0-9]{8}'),
    ADD CONSTRAINT chk_bill_user_storage_domain_id
    CHECK (UserId IS NOT NULL OR StorageId IS NOT NULL OR DomainId IS NOT NULL);

ALTER TABLE Payment
    ADD CONSTRAINT chk_payment_transaction_id
    CHECK (TransactionId REGEXP '[0-9]+');

ALTER TABLE Notification
    ADD CONSTRAINT chk_notification_dates
    CHECK (TimeFrameEnd > TimeFrameStart),
    ADD CONSTRAINT chk_notification_user_storage_domain_id
    CHECK (UserId IS NOT NULL OR StorageId IS NOT NULL OR DomainId IS NOT NULL);