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

/* Évi statisztika az egyes domainekhez */
SELECT d.DomainAddress, d.TLD, YEAR(s.Month) AS Year, SUM(s.Views) AS ViewSum, SUM(s.UniqueViewers) as UViewSum FROM Domain d
INNER JOIN Statistic s ON s.DomainId = d.Id
GROUP BY Year;

/* Az összes webtárhely neve és létrehozási dátuma, ahol SSH engedélyezve van és a maximum sávszélesség nagyobb mint vagy egyenlő 1 */
SELECT s.Name FROM Storage s
INNER JOIN StorageType st ON st.Id = s.TypeId
WHERE st.SSHEnabled AND s.MaximumDataTraffic >= 1;

/* Az összes olyan tárhely, aminek nincsen egy domain címe sem */
SELECT s.Name FROM Storage s
LEFT JOIN Domain d ON d.StorageId = s.Id
GROUP BY s.Name
HAVING COUNT(d.Id) = 0;