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
| MaximumStorage | int      |       |            | `5`                   |

### StorageType

| Mező                    | Típus   | Hossz | Opcionális | Alapértelmezett érték |
| ----------------------- | ------- | ----: | :--------: | --------------------- |
| Id                      | int     |       |            |                       |
| SSHEnabled              | boolean |       |            | `false`               |
| PHPEnabled              | boolean |       |            | `false`               |
| MaximumEmailAccounts    | int     |       |     X      |                       |
| MaximumFTPAccounts      | int     |       |     X      |                       |
| MaximumDatabaseNumber   | int     |       |     X      |                       |
| PHPMemoryLimit          | int     |       |     X      |                       |
| MaximumPHPExecutionTime | int     |       |     X      |                       |
| CPaneldIsEnabled        | boolean |       |            | `false`               |
| BaseCost                | decimal |       |            |                       |
| DataTrafficMultiplier   | int     |       |            | `1`                   |
| Name                    | varchar |   120 |            |                       |

<div class="page-break"></div>

### DataCenter

| Mező            | Típus   | Hossz | Opcionális | Alapértelmezett érték |
| --------------- | ------- | ----: | :--------: | --------------------- |
| Id              | int     |       |            |                       |
| Name            | varchar |    30 |            |                       |
| City            | varchar |    80 |            |                       |
| Number          | int     |       |            |                       |
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
| Size               | int      |       |            |                                    |
| MaximumDataTraffic | int      |       |            |                                    |
| EmailStorageSize   | int      |       |     X      |                                    |
| DatabaseSize       | int      |       |     X      |                                    |
| Cost               | decimal  |       |            |                                    |
| Name               | varchar  |    80 |            |                                    |

<div class="page-break"></div>

### Domain

| Mező          | Típus    | Hossz | Opcionális | Alapértelmezett érték              |
| ------------- | -------- | ----: | :--------: | ---------------------------------- |
| Id            | int      |       |            |                                    |
| UserId        | int      |       |            |                                    |
| DomainAddress | varchar  |   100 |            |                                    |
| StorageId     | int      |       |     X      |                                    |
| TLD           | varchar  |     5 |            |                                    |
| Registration  | datetime |       |            | `NOW()`                            |
| Expiration    | datetime |       |            | `DATE_ADD(NOW(), INTERVAL 1 YEAR)` |
| NameServer1   | varchar  |   100 |            |                                    |
| NameServer2   | varchar  |   100 |     X      |                                    |
| NameServer3   | varchar  |   100 |     X      |                                    |
| NameServer4   | varchar  |   100 |     X      |                                    |

### Bill

| Mező      | Típus    | Hossz | Opcionális | Alapértelmezett érték               |
| --------- | -------- | ----: | :--------: | ----------------------------------- |
| Id        | int      |       |            |                                     |
| UserId    | int      |       |            |                                     |
| StorageId | int      |       |     X      |                                     |
| DomainId  | int      |       |     X      |                                     |
| Date      | datetime |       |            | `NOW()`                             |
| Deadline  | datetime |       |            | `DATE_ADD(NOW(), INTERVAL 1 MONTH)` |
| Cost      | decimal  |       |            |                                     |
| BillId    | varchar  |   100 |            |                                     |

### Payment

| Mező           | Típus    | Hossz | Opcionális | Alapértelmezett érték |
| -------------- | -------- | ----: | :--------: | --------------------- |
| Id             | int      |       |            |                       |
| UserId         | int      |       |            |                       |
| Date           | datetime |       |            | `NOW()`               |
| TranscactionId | varchar  |   100 |            |                       |
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
| UserId         | int      |       |            |                       |
| StorageId      | int      |       |     X      |                       |
| DomainId       | int      |       |     X      |                       |
| Creation       | datetime |       |            | `NOW()`               |
| TimeFrameStart | datetime |       |     X      |                       |
| TimeFrameEnd   | datetime |       |     X      |                       |
| Title          | varchar  |   100 |            |                       |
| Message        | longtext |       |            |                       |
