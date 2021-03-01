## Input/Output adatok adattípusba rendezve

### User

<center>

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

</center>

### StorageType

<center>

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

</center>

### DataCenter

<center>

| Mező            | Típus   | Hossz | Opcionális | Alapértelmezett érték |
| --------------- | ------- | ----: | :--------: | --------------------- |
| Id              | int     |       |            |                       |
| Name            | varchar |    30 |            |                       |
| City            | varchar |    80 |            |                       |
| Number          | int     |       |            |                       |
| Area            | decimal |     X |            |                       |
| StorageCapacity | int     |       |            |                       |

</center>

### Storage

<center>

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

</center>

### Domain

<center>

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

</center>

### Bill

<center>

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

</center>

### Payment

<center>

| Mező           | Típus    | Hossz | Opcionális | Alapértelmezett érték |
| -------------- | -------- | ----: | :--------: | --------------------- |
| Id             | int      |       |            |                       |
| UserId         | int      |       |            |                       |
| Date           | datetime |       |            | `NOW()`               |
| TranscactionId | varchar  |   100 |            |                       |
| BillId         | int      |       |            |                       |

</center>

### Statistic

<center>

| Mező          | Típus | Hossz | Opcionális | Alapértelmezett érték |
| ------------- | ----- | ----: | :--------: | --------------------- |
| Id            | int   |       |            |                       |
| DomainId      | int   |       |            |                       |
| Month         | date  |       |            |                       |
| Views         | int   |       |            | `0`                   |
| UniqueViewers | int   |       |            | `0`                   |

</center>

### Notification

<center>

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

</center>
