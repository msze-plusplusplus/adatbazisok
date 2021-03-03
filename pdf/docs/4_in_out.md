## Input/Output adatok adattípusba rendezve

### User

| Mező           | Típus    | Hossz | Opcionális | Alapértelmezett érték |
| -------------- | -------- | ----: | :--------: | --------------------- |
| Id             | int      |       |            |                       |
| FullName       | varchar  |    60 |            |                       |
| UserName       | varchar  |    30 |            |                       |
| Email          | varchar  |   120 |            |                       |
| Password       | varchar  |   120 |            |                       |
| Registration   | datetime |       |            | `NOW()`               |
| Blocked        | boolean  |       |            | `false`               |
| MaximumStorage | int      |     4 |            | `5`                   |

### StorageType

| Mező                    | Típus   | Hossz | Opcionális | Alapértelmezett érték |
| ----------------------- | ------- | ----: | :--------: | --------------------- |
| Id                      | int     |       |            |                       |
| SSHEnabled              | boolean |       |            | `false`               |
| PHPEnabled              | boolean |       |            | `false`               |
| MaximumEmailAccounts    | int     |     5 |     X      |                       |
| MaximumFTPAccounts      | int     |     5 |     X      |                       |
| MaximumDatabaseNumber   | int     |     5 |     X      |                       |
| PHPMemoryLimit          | int     |     6 |     X      |                       |
| MaximumPHPExecutionTime | int     |     3 |     X      |                       |
| CPaneldIsEnabled        | boolean |       |            | `false`               |
| BaseCost                | decimal |       |            |                       |
| DataTrafficMultiplier   | int     |     3 |            | `1`                   |
| Name                    | varchar |   120 |            |                       |

<div class="page-break"></div>

### DataCenter

| Mező            | Típus   | Hossz | Opcionális | Alapértelmezett érték |
| --------------- | ------- | ----: | :--------: | --------------------- |
| Id              | int     |       |            |                       |
| Name            | varchar |    30 |            |                       |
| City            | varchar |    80 |            |                       |
| Number          | int     |     2 |            |                       |
| Area            | decimal |     X |            |                       |
| StorageCapacity | int     |       |            |                       |

### Storage

| Mező               | Típus    | Hossz | Opcionális | Alapértelmezett érték              |
| ------------------ | -------- | ----: | :--------: | ---------------------------------- |
| Id                 | int      |       |            |                                    |
| UserId             | int      |       |            |                                    |
| Creation           | datetime |       |            | `NOW()`                            |
| Expiration         | datetime |       |            | `DATE_ADD(NOW(), INTERVAL 1 YEAR)` |
| TypeId             | int      |       |            |                                    |
| Size               | int      |     6 |            |                                    |
| MaximumDataTraffic | int      |     6 |            |                                    |
| EmailStorageSize   | int      |     6 |     X      |                                    |
| DatabaseSize       | int      |     6 |     X      |                                    |
| Cost               | decimal  |       |            |                                    |
| Name               | varchar  |    80 |            |                                    |

<div class="page-break"></div>

### Domain

| Mező          | Típus    | Hossz | Opcionális | Alapértelmezett érték              |
| ------------- | -------- | ----: | :--------: | ---------------------------------- |
| Id            | int      |       |            |                                    |
| UserId        | int      |       |            |                                    |
| DomainAddress | varchar  |   253 |            |                                    |
| StorageId     | int      |       |     X      |                                    |
| TLD           | varchar  |    63 |            |                                    |
| Registration  | datetime |       |            | `NOW()`                            |
| Expiration    | datetime |       |            | `DATE_ADD(NOW(), INTERVAL 1 YEAR)` |
| NameServer1   | varchar  |   253 |            |                                    |
| NameServer2   | varchar  |   253 |     X      |                                    |
| NameServer3   | varchar  |   253 |     X      |                                    |
| NameServer4   | varchar  |   253 |     X      |                                    |

### Bill

| Mező      | Típus    | Hossz | Opcionális | Alapértelmezett érték               |
| --------- | -------- | ----: | :--------: | ----------------------------------- |
| Id        | int      |       |            |                                     |
| UserId    | int      |       |     X      |                                     |
| StorageId | int      |       |     X      |                                     |
| DomainId  | int      |       |     X      |                                     |
| Date      | datetime |       |            | `NOW()`                             |
| Deadline  | datetime |       |            | `DATE_ADD(NOW(), INTERVAL 1 MONTH)` |
| Cost      | decimal  |       |            |                                     |
| BillId    | varchar  |    18 |            |                                     |

### Payment

| Mező           | Típus    | Hossz | Opcionális | Alapértelmezett érték |
| -------------- | -------- | ----: | :--------: | --------------------- |
| Id             | int      |       |            |                       |
| UserId         | int      |       |            |                       |
| Date           | datetime |       |            | `NOW()`               |
| TranscactionId | varchar  |    30 |            |                       |
| BillId         | int      |       |            |                       |

### Statistic

| Mező          | Típus | Hossz | Opcionális | Alapértelmezett érték |
| ------------- | ----- | ----: | :--------: | --------------------- |
| Id            | int   |       |            |                       |
| DomainId      | int   |       |            |                       |
| Month         | date  |       |            |                       |
| Views         | int   |       |            | `0`                   |
| UniqueViewers | int   |       |            | `0`                   |

### Notification

| Mező           | Típus    | Hossz | Opcionális | Alapértelmezett érték |
| -------------- | -------- | ----: | :--------: | --------------------- |
| Id             | int      |       |            |                       |
| UserId         | int      |       |     X      |                       |
| StorageId      | int      |       |     X      |                       |
| DomainId       | int      |       |     X      |                       |
| Creation       | datetime |       |            | `NOW()`               |
| TimeFrameStart | datetime |       |     X      |                       |
| TimeFrameEnd   | datetime |       |     X      |                       |
| Title          | varchar  |   100 |            |                       |
| Message        | longtext |       |            |                       |
