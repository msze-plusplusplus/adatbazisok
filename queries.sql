/* Questions */

/* Data centers listája név alapján ASC rendezve és város szám füzött kódda */
SELECT dc.Name, CONCAT(dc.City, '-', dc.Number) as Keyword FROM DataCenter dc
ORDER BY Name;

/* A top 3 legtöbb központtal rendelkező városok nevei (Csökkenő sorrendben, darabszámmal) */
SELECT dc.City, COUNT(dc.Id) as Count FROM DataCenter dc
GROUP BY dc.City
ORDER BY Count DESC, dc.City
LIMIT 3;

/* Tárhely típusok neveinek listája ahol van php */
SELECT st.Name FROM StorageType st
WHERE st.PHPEnabled;

/* A `.com` domainek száma */
SELECT COUNT(d.TLD) as C FROM Domain d
GROUP BY d.TLD
HAVING d.TLD LIKE 'com';
