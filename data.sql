INSERT INTO User (FullName, UserName, Email, Password)
VALUES ('Kő Pál', 'kpali', 'kpali@citromail.hu', '$2y$12$zA/X1Y42ltkHlKxznTZBpOwZcEiUgamg6DZWEic.O5FtnjWHfXlne'),
       ('Körte Alma', 'kortalm', 'korte.alma@gmail.com', '$2y$12$g/B8ur16SsoOGv.fNQZ7fOouhJ7jQzc/alPqFPBHSUflbS2T4D81u');

INSERT INTO StorageType(SSHEnabled, PHPEnabled, MaximumEmailAccounts, MaximumFTPAccounts, MaximumDatabaseNumber, PHPMemoryLimit, MaximumPHPExecutionTime, CPanelIsEnabled, BaseCost, DataTrafficMultiplier, Name)
VALUES (true, true, 100, 100, 100, 1024, 1, true, 2000, 2, 'High End'),
       (false, false, 0, 0, NULL, NULL, NULL, false, 100, 1.2, 'Low budget'),
       (true, false, 1, 0, NULL, NULL, NULL, false, 1, 0, 'Null value'),
       (true, true, 40, 0, 2, 128, 30, true, 1500, 1.7, 'Maxi'),
       (true, true, 100, 3, 7, 256, 20, true, 2800, 2.2, 'Pro'),
       (true, true, 200, 7, 20, 1024, 10, false, 750, 0.9, 'Mini');

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

INSERT INTO Storage (UserId, TypeId, Size, MaximumDataTraffic, EmailStorageSize, DatabaseSize, DataCenterId, Cost, Name)
VALUES (1, 1, 100, 10, 10, 10, 1, 100, 'MyIzé'),
       (1, 2, 10, 100, 120, 20, 2, 100, 'BestAppEver'),
       (2, 3, 270, 120, 100, 75, 3, 1000, 'Test'),
       (2, 4, 800, 140, 1000, 980, 4, 2000, 'Google'),
       (1, 5, 20, 200, 70, 100, 5, 3000, 'NemTest');

INSERT INTO Domain (UserId, DomainAddress, StorageId, TLD, NameServer1, NameServer2)
VALUES (1, 'nemtest', 1, 'hu', 'ns1.example.com', 'ns2.example.com'),
       (1, 'test', 2, 'com', 'ns3.example.com', 'ns4.example.com'),
       (2, 'facebook', 3, 'com', 'ns1.example.com', 'ns3.example.com'),
       (2, 'google', 3, 'at', 'ns2.example.com', 'ns4.example.com'),
       (1, 'iwiw', 4, 'hu', 'ns.common.com', 'ns.ns.com');

INSERT INTO Bill (UserId, StorageId, DomainId, Date, Deadline, Cost, BillId)
VALUES (1, NULL, NULL, '2018-07-12 12:00:00', '2018-08-12 12:00:00', 1000, 'BBKT-2018-00000001'),
       (1, NULL, NULL, '2019-09-17 12:00:00', '2019-10-17 12:00:00', 100, 'BBKT-2019-00000001'),
       (1, NULL, NULL, '2021-04-06 12:00:00', '2021-05-06 12:00:00', 3000, 'BBKT-2021-00000001'),
       (2, NULL, NULL, '2018-07-15 12:00:00', '2018-08-15 12:00:00', 210, 'BBKT-2018-00000002'),
       (2, NULL, NULL, '2021-04-12 12:00:00', '2021-05-12 12:00:00', 2100, 'BBKT-2021-00000002'),
       (NULL, 1, NULL, '2018-07-23 12:00:00', '2018-08-23 12:00:00', 100, 'BBKT-2018-00000003'),
       (NULL, 2, NULL, '2018-11-03 12:00:00', '2018-12-03 12:00:00', 300, 'BBKT-2018-00000004'),
       (NULL, 3, NULL, '2019-10-28 12:00:00', '2019-11-28 12:00:00', 215, 'BBKT-2019-00000002'),
       (NULL, 4, NULL, '2019-12-27 12:00:00', '2020-01-27 12:00:00', 100, 'BBKT-2019-00000003'),
       (NULL, 5, NULL, '2020-03-16 12:00:00', '2020-04-16 12:00:00', 50, 'BBKT-2020-00000001'),
       (NULL, NULL, 1, '2021-04-19 12:00:00', '2021-05-19 12:00:00', 20, 'BBKT-2021-00000003'),
       (NULL, NULL, 2, '2021-04-22 12:00:00', '2021-05-22 12:00:00', 100, 'BBKT-2021-00000004'),
       (NULL, NULL, 3, '2021-05-02 12:00:00', '2018-06-02 12:00:00', 1000, 'BBKT-2021-00000005');

INSERT INTO Payment (UserId, Date, TransactionId, BillId)
VALUES (1, '2018-07-22', '0000000000000001', 1),
       (1, '2019-09-27', '0000000000000002', 2),
       (2, '2018-07-23', '0000000000000003', 4),
       (1, '2018-07-29', '0000000000000004', 6),
       (1, '2021-04-21', '0000000000000005', 11);