### Tárolt eljárások

- `GetStoragePrice` - Tárhely ár kiszámítása
- `AreLimitsReached` - Limitek ellenőrzése
  - van-e befizetetlen számla
  - felhasználói limit nem telt-e be

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
