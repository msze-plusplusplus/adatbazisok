# Webtárhely

## Leírás és funkcionális követelmények

Az általunk választott téma egy webtárhely séma alapszintű funkcióinak leképezése adatbázis szemszögből.

Az adatbázisban tárolhatóak az egyes webtárhelyek és azoknak adatai. Vannak webtárhely típusból jövő beállítási adatok, amik mint csomag beállítások foghatóak fel, illetve vannak a webtárhely a felhasználói által specializált konfigurációs beállítások. Ezek a beállítások együtt alkotják, majd a webtárhely költségeit. A webtárhelyek létrehozásánál, ki lehet választani, hogy melyik szerver központba jöjjön létre a mi tárhelyünk.

A adatbázisban tárolva vannak a felhasználók és adataik, akik a webtárhely létrehozáson kívül, képesek saját domaint is csatolni fiókjukhoz.

A fizetési kötelezettségek is tárolva vannak. El van tárolva, hogy mikör jött létre, meéyikfeéhasználó számára, milyen összeggel és hogy milyen határidővel. Ehhez az adat halmazhot tartozik egy másik tábla, ami a felhasználók által végrehajtott tranzakciókat hivatott tárolni.

Folyamatos statisztikát állítunk elő és tároljuk el, hogy a felhasználók visszajelzést kaphassanak a látogatottsági számokról és az új egyedi látogatásokról. Ezek az adatok, az egyes domain címekhez vannak csatolva.

Továbbá az adatbázis rendelkezik értesítésekkel, amik a felhasznélók figyelmét hivatottak felhívni. Például a havi statisztikáról, befizetési kötelezettségekről, kifezetett tranzakciókról, bérleti lejártakról és így tovább.
