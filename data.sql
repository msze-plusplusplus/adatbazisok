INSERT INTO DataCenter(Name, City, Number, Area, StorageCapacity)
VALUES ('Europe Main', 'Frankfurt', 1, NULL, 1000),
       ('Europe Backup', 'Frankfurt', 2, NULL, 400),
       ('USA', 'New York', 1, NULL, 700),
       ('Asia', 'Tokyo', 1, NULL, 860),
       ('South America', 'Rio', 1, NULL, 1200);

INSERT INTO StorageType(SSHEnabled, PHPEnabled, MaximumEmailAccounts, MaximumFTPAccounts, MaximumDatabaseNumber, PHPMemoryLimit, MaximumPHPExecutionTime, CPanelIsEnabled, BaseCost, DataTrafficMultiplier, Name)
VALUES (true, true, 100, 100, 100, 1000, 1, true, 200000, 2, 'High End'),
       (false, false, 0, 0, 0, 0, 0, true, 100, 1.2, 'Low budget'),
       (true, false, 10, 0, 2, 0, 0, true, 100000, 1, 'Low'),
       (true, true, 10, 0, 2, 100, 1, true, 100000, 1, 'Low');

INSERT INTO User (FullName, UserName, Email, Password)
VALUES ('Nagy János', 'jani', 'janos@citromail.hu', 'hash'),
       ('Kis Pista', 'pityu', 'pista@gmail.com', 'hash');

INSERT INTO Storage (UserId, TypeId, Size, MaximumDataTraffic, EmailStorageSize, DatabaseSize, DataCenterId, Cost, Name)
VALUES (1, 1, 1000, 100, 1000, 1000, 1, 1000, 'MyIzé');

INSERT INTO Domain (UserId, DomainAddress, StorageId, TLD, NameServer1)
VALUES (1, 'nemtest', 1, 'hu', '8.8.8.8'),
       (1, 'test', 1, 'com', '8.8.8.8');