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
- `GetNextBillId` - A jelenlrg tárolt adatok alapján meghatározza a jelenlegi év következő számla azonosítóját

### Triggerek

- `CheckLimitsStorage` - Új tárhely létrehozás limitek ellenőrzése
  - `Storage` tábla - Beszúrás előtt
  - `AreLimitsReached`
  - Meghatározza a tárhelyhez tartozó költséget
- `CheckLimitsDomain` - Új domain regisztráció limitek ellenőrzése
  - `Domain` tábla - Beszúrás előtt
  - `AreLimitsReached`
- `CanEditUserProperties` - Felhasználó szerkesztés esetén, adott mezők szerkesztésének tiltása
  - `User` tábla - Frissítés előtt
  - A _UserName_, _Email_, _Registration_ mezők nem szerkeszthetők
- `AddBillId` - A számla létrehozásakor felülirja a számla azonosítót a következő helyes azonosítóval a tárolt adatok alapján
- `EditBillId` - Blokkolja a számla azonosító átírását módosítás közben
- `EditStorage` - Meghatározza a tárhelyhez tartozó költséget módosítás után

<div class="page-break"></div>
