## Megszorítások

### Idegen kulcsok

<center>

| Tábla        | Mezők                        |
| ------------ | ---------------------------- |
| Storage      | UserId, TypeId, DataCenterId |
| Domain       | UserId, StorageId            |
| Bill         | UserId, StorageId, DomainId  |
| Payment      | UserId, BillId               |
| Statistic    | DomainId                     |
| Notification | UserId, StorageId, DomainId  |

</center>

### Egyedi kulcsok

<center>

| Tábla      | Mezők              |
| ---------- | ------------------ |
| User       | UserName, Email    |
| DataCenter | Name               |
| Storage    | UserId, Name       |
| Domain     | DomainAddress, TLD |
| Bill       | BillId             |
| Payment    | Transactionid      |
| Statistic  | DomainId, Month    |

</center>

### Egyéb megszorítások

(Transaction Id, BillId, stb.)

Procedures ?
Triggers ?
