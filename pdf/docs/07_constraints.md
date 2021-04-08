## Megszorítások

### Idegen kulcsok

| Tábla        | Mezők                        |
| ------------ | ---------------------------- |
| Storage      | UserId, TypeId, DataCenterId |
| Domain       | UserId, StorageId            |
| Bill         | UserId, StorageId, DomainId  |
| Payment      | UserId, BillId               |
| Statistic    | DomainId                     |
| Notification | UserId, StorageId, DomainId  |

### Egyedi kulcsok

| Tábla      | Mezők              |
| ---------- | ------------------ |
| User       | UserName, Email    |
| DataCenter | Name               |
| Storage    | UserId, Name       |
| Domain     | DomainAddress, TLD |
| Bill       | BillId             |
| Payment    | Transactionid      |
| Statistic  | DomainId, Month    |

<div class="page-break"></div>

### Egyéb megszorítások

- User tábla
  - E-mail cím
    - Név: A-Za-z0-9 + - = \_ (1-64 karakter)
    - @
    - Domain: A-Za-z0-9 - . (1-253 karakter)
    - TLD: A-Za-z (2+ karakter)
    - Regex: `[A-Za-z0-9\+\-\=\_]{1,64}@[A-Za-z0-9\-\.]{1,253}\.[A-Za-z]{2,}`

```sql
ALTER TABLE User
    ADD CONSTRAINT chk_user_email
    CHECK (Email REGEXP '[A-Za-z0-9\+\-\=\_]{1,64}@[A-Za-z0-9\-\.]{1,253}\.[A-Za-z]{2,}');
```

- Domain tábla
  - Domain név
    - A-Za-z0-9 - . (1-253 karakter)
    - Regex: `[A-Za-z0-9\-\.]{1,253}`
  - Lejárati dátum
    - Regisztrációs dátum után

```sql
ALTER TABLE Domain
    ADD CONSTRAINT chk_domain_domain
    CHECK (DomainAddress REGEXP '[A-Za-z0-9\-\.]{1,253}'),
    ADD CONSTRAINT chk_domain_expiration
    CHECK (Expiration > Registration);
```

- Storage tábla
  - Lejárat
    - Létrehozva után

```sql
ALTER TABLE Storage
    ADD CONSTRAINT chk_storage_expiration
    CHECK (Expiration > Creation);
```

- StorageTypes tábla
  - Adatbázisok száma, PHP memória limit, PHP max. végrehajtási idő
    - Csak engedélyezett PHP mellett kitölthető

```sql
ALTER TABLE StorageType
    ADD CONSTRAINT chk_storage_type_php
    CHECK ((PHPEnabled=0 AND PHPMemoryLimit IS NULL AND MaximumPHPExecutionTime IS NULL AND MaximumDatabaseNumber IS NULL) OR PHPEnabled=1);
```

- Bill tábla
  - Számla azonosító
    - Regex: `BBKT-[0-9]{4}-[0-9]{8}`
  - Számla kötődés
    - Legalább az egyiknek szerepelnie a három közül: `UserId`, `StorageId`, `DomainId`

```sql
ALTER TABLE Bill
    ADD CONSTRAINT chk_bill_bill_id
    CHECK (BillId REGEXP 'BBKT-[0-9]{4}-[0-9]{8}'),
    ADD CONSTRAINT chk_bill_user_storage_domain_id
    CHECK (UserId IS NOT NULL OR StorageId IS NOT NULL OR DomainId IS NOT NULL);
```

- Payment tábla
  - Tranzakció azonosító
    - Regex: `[0-9]+`

```sql
ALTER TABLE Payment
    ADD CONSTRAINT chk_payment_transaction_id
    CHECK (TransactionId REGEXP '[0-9]+');
```

- Notification tábla
  - Időkeret kezdet
    - kisebb mint Időkeret vége
  - Tulajdonosi kapcsolat
    - Legalább az egyiknek szerepelnie a három közül: `UserId`, `StorageId`, `DomainId`

```sql
ALTER TABLE Notification
    ADD CONSTRAINT chk_notification_dates
    CHECK (TimeFrameEnd > TimeFrameStart),
    ADD CONSTRAINT chk_notification_user_storage_domain_id
    CHECK (UserId IS NOT NULL OR StorageId IS NOT NULL OR DomainId IS NOT NULL);
```

<div class="page-break"></div>
