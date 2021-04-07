# Webtárhely

## Leírás és funkcionális követelmények

Az általunk választott téma egy webtárhely séma alapszintű funkcióinak leképezése adatbázis szemszögből.

Az adatbázisban tárolhatóak az egyes webtárhelyek és azoknak adatai. Vannak webtárhely típusból jövő beállítási adatok, amik mint csomag beállítások foghatóak fel, illetve vannak a webtárhely a felhasználói által specializált konfigurációs beállítások. Ezek a beállítások együtt alkotják, majd a webtárhely költségeit. A webtárhelyek létrehozásánál, ki lehet választani, hogy melyik szerver központba jöjjön létre a mi tárhelyünk.

A adatbázisban tárolva vannak a felhasználók és adataik, akik a webtárhely létrehozáson kívül, képesek saját domaint is csatolni fiókjukhoz és az egyes webtárhelyekhez.

A fizetési kötelezettségek és befizetési elégtételeik is el vannak tárolva. Külön kerülnek ezek az adatok a két oldalhoz eltárolásra.

Folyamatos statisztikát állítunk elő és tároljuk el, hogy a felhasználók visszajelzést kaphassanak a látogatottsági számokról és az új egyedi látogatásokról, míg az "élő"/nap/heti adatokért más alrendszer felelős, a hosszútávú (havi) adatok az adatbázisban kerülnek letárolásra. Ezek az adatok, az egyes domain címekhez vannak csatolva.

Továbbá az adatbázis rendelkezik értesítésekkel, amik a felhasznélók figyelmét hivatottak felhívni és tájékoztatni esetleges hibákról vagy tervezett karbantartásokról. Például forgalomugrásról, befizetési kötelezettségekről, befizetett tranzakciókról, bérleti lejáratokról és így tovább.

> Az adatbázis MariaDB-hez készült, más adatbázis motorral nem volt tesztelve. (MariaDB 10.5)
