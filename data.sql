INSERT INTO DataCenter(Name, City, Number, Area, StorageCapacity)
VALUES ('Europe Main', 'Frankfurt', 1, NULL, 1000),
       ('Europe Backup', 'Frankfurt', 2, NULL, 400),
       ('USA', 'New York', 1, NULL, 700),
       ('Asia', 'Tokyo', 1, NULL, 860),
       ('South America', 'Rio', 1, NULL, 1200),
       ('BUD1', 'Budapest', 1, NULL, 100),
       ('BUD2', 'Budapest', 2, NULL, 200),
       ('BUD3', 'Budapest', 3, NULL, 300),
       ('BUD4', 'Budapest', 4, NULL, 400),
       ('BUD5', 'Budapest', 5, NULL, 500);

INSERT INTO StorageType(SSHEnabled, PHPEnabled, MaximumEmailAccounts, MaximumFTPAccounts, MaximumDatabaseNumber, PHPMemoryLimit, MaximumPHPExecutionTime, CPanelIsEnabled, BaseCost, DataTrafficMultiplier, Name)
VALUES (true, true, 100, 100, 100, 1024, 1, true, 200000, 2, 'High End'),
       (false, false, 0, 0, NULL, NULL, NULL, true, 100, 1.2, 'Low budget'),
       (true, false, 10, 0, NULL, NULL, NULL, true, 100000, 1, 'Low'),
       (true, true, 10, 0, 2, 128, 1, true, 100000, 1, 'Low');

INSERT INTO User (FullName, UserName, Email, Password)
VALUES ('Nagy János', 'jani', 'janos@citromail.hu', '$2y$12$zA/X1Y42ltkHlKxznTZBpOwZcEiUgamg6DZWEic.O5FtnjWHfXlne'),
       ('Kis Pista', 'pityu', 'pista@gmail.com', '$2y$12$g/B8ur16SsoOGv.fNQZ7fOouhJ7jQzc/alPqFPBHSUflbS2T4D81u');

INSERT INTO Storage (UserId, TypeId, Size, MaximumDataTraffic, EmailStorageSize, DatabaseSize, DataCenterId, Cost, Name)
VALUES (1, 1, 1000, 100, 1000, 1000, 1, 1000, 'MyIzé');

INSERT INTO Domain (UserId, DomainAddress, StorageId, TLD, NameServer1, NameServer2)
VALUES (1, 'nemtest', 1, 'hu', 'ns1.example.com', 'ns2.example.com'),
       (1, 'test', 1, 'com', 'ns3.example.com', 'ns4.example.com');