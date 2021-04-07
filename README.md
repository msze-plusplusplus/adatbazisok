# Adatbázisok

## GKNB_INTM010

## Csapattagok

- Baranyai Bence Bendegúz
- Karcag Tamas

## Dokumentáció írás / Fejlesztés

- a **README** egy vázlat, rövidített leírás
- [Fejlesztési adatbázis](README.devdb.md)
- [Dokumentáció szerkesztés és generálás](pdf/)

[![Generate and deploy](https://github.com/sze-plusplusplus/adatbazisok/actions/workflows/pages.yml/badge.svg)](https://github.com/sze-plusplusplus/adatbazisok/actions/workflows/pages.yml)

[Generált HTML dokumentáció](https://sze-plusplusplus.github.io/adatbazisok/)

[Generált PDF dokumentáció](https://sze-plusplusplus.github.io/adatbazisok/webtarhely_adatbazis_plusplusplus.pdf)

## Webtárhely/Domain kezelés

### Feladatok

- [x] Adatbázis létrehozás
- [x] Táblák létrehozása
- [x] Elsődleges/Idegen kulcsok
- [x] Check constraintek
- [x] Egyedi kulcsok
- [x] Tárolt függvények
- [x] Triggerek
- [x] Alap adatok
- [x] Lekérdezések
- [x] Adathozzáadó eljárások (Tomi szerint)
- [ ] További triggerek?
- [ ] Egyed-Kapcsolat diagram
- [ ] GUI tervek
- [ ] Prezentáció

## Kérdések (inkább feladat megfogalmazások)

- 1 tábla (min. 4 db)
  - A `.com` domainek száma `[done]`
  - Data centers listája név alapján ASC rendezve és város szám füzött kóddal `[done]`
  - A top 3 legtöbb központtal rendelkező városok nevei (Csökkenő sorrendben, darabszámmal) `[done]`
  - Tárhely típusok listája ahol van php `[done]`
- 2 tábla (min. 6 db)
  - Évi statisztika az egyes domainekhez (`*`) `[done]`
  - Az összes webtárhely neve és létrehozási dátuma, ahol SSH engedélyezve van és a maximum sávszélesség nagyobb mint vagy egyenlő 1 `[done]`
  - Az összes olyan tárhely, aminek nincsen egy domain címe sem `[done]`
  - Van-e az adott (1-es Id) felhasználónak nem kifizetett tartozása `[done]`
  - Azok a webtárhelyek, amiknek a domain címe már lejárt `[done]`
  - _2019-09-12_ - _2020-02-23_ között regisztrált felhasználók, által befizetett számlák és befizetése ha volt `[done]`
  - Azok az adat központok, ahol a webtárhelyek legalább fele rendelkezik adatbázissal, php-val és e-mail fiókokkal
- 3 vagy több tábla (min. 8 db, 3+ tábla min. 2 db)
  - Egy domainen, aminek a tárhelyén a PHP futtatás engedélyezve van, lesz-e karbantartás a következő 30 napban, _BUD1_ adatközpontban? (`Domain, Storage, StorageTypes, DataCenters, Notification`)
  - Az utóbbi 2 hónapban befizetett, _hu_ TLD domainek listázása, felhasználókkal (`User, Domain, Bill, Payment`).
  - A felhasználók, tárhelyein lévő értesítések száma, amik még nem jártak le (`User, Storage, Notification`)(`*`)
  - _Maxi_ csomagba tartozó domainek listázása (`Domain, Storage, StorageTypes`)
  - Az az adatközpont, ahol a legtöbb PHP-val és adatbázissal rendelkező webtárhely van (`DataCenter, Storage, StorageType`)
  - Adatközpontok terheltsége, foglalt GB-ok és látogatottság szerint (`DataCenters, Storage, Domain, Statistic`)(`*`)
  - Azok a felhasználók, akik a határidő előtti napon fizették be a számlát (`User, Bill, Payment`)
  - Leglátogatotabb domainek és tulajdonosuk, amelyeken nincs a PHP futtatás engedélyezve (`Domain, Statistic, Storage, StorageTypes, User`)
- min. 2 db számított értéket tartalmazó
  - `*`-al jelöltek

## Függvények

- Tárhely ár kiszámítás (képlettel)
- Tárhely adatforgalom kiszámítás (képlettel)

## Trigger

- Létrehozási jogosultság teszt (befizetetlen számla mellé nem lehetséges, db limit ellenőrzés)
