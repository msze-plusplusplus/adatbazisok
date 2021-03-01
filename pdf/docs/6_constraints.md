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

### Uniqe kulcsok

### Indexek

### Egyéb megszorítások

(Transaction Id, BillId, stb.)
