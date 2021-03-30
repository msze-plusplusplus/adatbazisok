### Tárolt eljárások

- `GetStoragePrice` - Tárhely ár kiszámítása
- `AreLimitsReached` - Limitek ellenőrzése
  - van-e befizetetlen számla
  - felhasználói limit nem telt-e be
- `CenterName` - Központ jeligéjének előállítása
- `GetStorageNumber` - Visszaadja a tárolók számát a paraméterben megadott köztpont Id alapaján
- `DomainAddress` - Domain cím előállítása a tagokból
- `GetActiveUserNotifications` - Lekéri a felhasználóhoz tartozó összes aktív értesítésnek a darabszámát
- `GetActiveDomainNotificationsByUser` - Lekéri a felhasználóhoz tartozó domain címekhez tartozó összes aktív értesítéseknek a darabszámát
- `GetActiveStorageNotificationsByUser` - Lekéri a felhasználóhoz tartozó web tárhyelhez tartozó összes aktív értesítéseknek a darabszámát

### Triggerek

- `CheckLimitsStorage` - Új tárhely létrehozás limitek ellenőrzése
  - `Storage` tábla - Beszúrás előtt
  - `AreLimitsReached`
- `CheckLimitsDomain` - Új domain regisztráció limitek ellenőrzése
  - `Domain` tábla - Beszúrás előtt
  - `AreLimitsReached`
- `CanEditUserProperties` - Felhasználó szerkesztés esetén, adott mezők szerkesztésének tiltása
  - `User` tábla - Frissítés előtt
  - A _UserName_, _Email_, _Registration_ mezők nem szerkeszthetők

<div class="page-break"></div>
