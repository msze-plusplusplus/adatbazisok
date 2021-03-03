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

- Felhasználók
  - E-mail cím
    - Név: A-Za-z0-9 + - = \_ (1-64 karakter)
    - @
    - Domain: A-Za-z0-9 - . (1-253 karakter)
    - TLD: A-Za-z (2+ karakter)
    - Regex: `[A-Za-z0-9\+\-\=\_]{1,64}@[A-Za-z0-9\-\.]{1,253}\.[A-Za-z]{2,}`
- Domain
  - Domain név
    - A-Za-z0-9 - . (1-253 karakter)
    - Regex: `[A-Za-z0-9\-\.]{1,253}`
  - Lejárati dátum
    - Regisztrációs dátum után
- Storage
  - Lejárat
    - Létrehozva után
- StorageTypes
  - Adatbázisok száma, PHP memória limit, PHP max. végrehajtási idő
    - Csak engedélyezett PHP mellett kitölthető
- Bill
  - Számla azonosító
    - Regex: `BBKT-[0-9]{4}-[0-9]{8}`
- Payment
  - Tranzakció azonosító
    - Regex: `[0-9]+`
- Notification
  - Időkeret kezdet
    - kisebb mint Időkeret vége

<div class="page-break"></div>
