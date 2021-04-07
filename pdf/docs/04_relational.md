## Relációs séma

| Adatbázis       | Webtárhely (WebStorage)                                                                                                                                                                                  |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Felhasználók    | **User** (Id, FullName, UserName, Email, Password, Registration, Blocked, MaximumStorage)                                                                                                                |
| Tárhely típus   | **StorageType** (Id, SSHEnabled, PHPEnabled, MaximumEmailAccounts, MaximumFTPAccounts, MaximumDatabaseNumber, PHPMemoryLimit, MaximumPHPExecutionTime, CPanelIsEnabled, BaseCost, DataTrafficMultiplier) |
| Szerver központ | **DataCenter** (Id, Name, City, Number, Area, StorageCapacity)                                                                                                                                           |
| Tárhely         | **Storage** (Id, UserId, Creation, Expiration, TypeId, Size, MaximumDataTraffic, EmailStorageSize, DatabaseSize, DataCenterId, Cost, Name)                                                               |
| Domain név      | **Domain** (Id, UserId, DomainAddress, StorageId, TLD, Registration, Expiration, NameServer1, NameServer2, NameServer3, NameServer4)                                                                     |
| Költségek       | **Bill** (Id, UserId, StorageId, DomainId, Date, Deadline, Cost, BillId)                                                                                                                                 |
| Kifizetések     | **Payment** (Id, UserId, Date, TransactionId, BillId)                                                                                                                                                    |
| Statisztika     | **Statistic** (Id, DomainId, Month, Views, UniqueViewers)                                                                                                                                                |
| Értesítések     | **Notification** (Id, UserId, StorageId, DomainId, Creation, TimeFrameStart, TimeFrameEnd, Title, Message, IsActive)                                                                                               |

<div class="page-break"></div>
