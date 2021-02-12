DROP DATABASE IF EXISTS WebStorage;

CREATE DATABASE WebStorage
    CHARACTER SET utf8
    COLLATE utf8_general_ci;

USE WebStorage;

DROP TABLE IF EXISTS User;
CREATE TABLE User (
    Id int NOT NULL,
    FullName varchar(60) NOT NULL,
    UserName varchar(30) NOT NULL,
    Email varchar(120) NOT NULL,
    Password varchar(120) NOT NULL,
    Registration datetime NOT NULL DEFAULT NOW(),
    Blocked boolean NOT NULL DEFAULT false,
    MaximumStorage int NOT NULL DEFAULT 5,
    PRIMARY KEY (Id),
    UNIQUE KEY (UserName, Email)
);

DROP TABLE IF EXISTS StorageType;
CREATE TABLE StorageType(
    Id int NOT NULL,
    SSHEnabled boolean NOT NULL DEFAULT false,
    PHPEnabled boolean NOT NULL DEFAULT false,
    MaximumEmailAccounts int NULL,
    MaximumFTPAccounts int NULL,
    MaximumDatabaseNumber int NULL,
    PHPMemoryLimit int null,
    MaximumPHPExecutionTime int null,
    CPanelIsEnabled boolean NOT NULL DEFAULT false,
    BaseCost decimal NOT NULL,
    DataTrafficMultiplier int NOT NULL DEFAULT 1,
    Name varchar(120) NOT NULL,
    PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS DataCenter;
CREATE TABLE DataCenter(
    Id int NOT NULL,
    Name varchar(30) NOT NULL,
    City varchar(80) NOT NULL,
    Number int NOT NULL,
    Area decimal NULL,
    StorageCapacity int NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY (Name)
);

DROP TABLE IF EXISTS Storage;
CREATE TABLE Storage(
    Id int NOT NULL,
    UserId int NOT NULL,
    Creation datetime NOT NULL DEFAULT NOW(),
    Expiration datetime NOT NULL DEFAULT DATE_ADD(NOW(), INTERVAL 1 YEAR),
    TypeId int NOT NULL,
    Size int NOT NULL,
    MaximumDataTraffic int NOT NULL,
    EmailStorageSize int NULL,
    DatabaseSize int null,
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
    Id int NOT NULL,
    UserId int NOT NULL,
    DomainAddress varchar(100) NOT NULL,
    StorageId int NULL,
    TLD varchar(5) NOT NULL,
    Registration datetime NOT NULL DEFAULT NOW(),
    Expiration datetime NOT NULL DEFAULT DATE_ADD(NOW(), INTERVAL 1 YEAR),
    NameServer1 varchar(100) NOT NULL,
    NameServer2 varchar(100) NULL,
    NameServer3 varchar(100) NULL,
    NameServer4 varchar(100) NULL,
    PRIMARY KEY (Id),
    UNIQUE (DomainAddress, TLD),
    FOREIGN KEY (UserId) REFERENCES User(Id),
    FOREIGN KEY (StorageId) REFERENCES Storage(Id)
);


DROP TABLE IF EXISTS Bill;
CREATE TABLE Bill(
    ID INT NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment(
    ID INT NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS Statistic;
CREATE TABLE Statistic(
    ID INT NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS Notification;
CREATE TABLE Notification(
    ID INT NOT NULL,
    PRIMARY KEY (ID)
);