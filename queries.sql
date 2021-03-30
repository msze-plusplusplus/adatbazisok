/* Questions */

/* Data centers listája név alapján ASC rendezve és város szám füzött kóddal */
SELECT dc.City, CenterName(dc.City, dc.Number) as Keyword FROM DataCenter dc
ORDER BY Keyword;

/* A top 3 legtöbb központtal rendelkező központok nevei (Csökkenő sorrendben, darabszámmal) */
SELECT CenterName(dc.City, dc.Number) as Center, COUNT(dc.Id) as Count FROM DataCenter dc
GROUP BY dc.City
ORDER BY Count DESC, dc.City
LIMIT 3;

/* Tárhely típusok neveinek listája ahol van php */
SELECT st.Name FROM StorageType st
WHERE st.PHPEnabled;

/* A `.com` domainek száma */
SELECT COUNT(d.TLD) as Addresses FROM Domain d
GROUP BY d.TLD
HAVING d.TLD LIKE 'com';

/* Évi statisztika az egyes domainekhez */
SELECT d.DomainAddress, d.TLD, YEAR(s.Month) AS Year, SUM(s.Views) AS ViewSum, SUM(s.UniqueViewers) as UViewSum FROM Domain d
INNER JOIN Statistic s ON s.DomainId = d.Id
GROUP BY Year;

/* Az összes webtárhely neve és létrehozási dátuma, ahol SSH engedélyezve van és a maximum sávszélesség nagyobb mint vagy egyenlő 1 */
SELECT s.Name, s.Creation FROM Storage s
INNER JOIN StorageType st ON st.Id = s.TypeId
WHERE st.SSHEnabled AND s.MaximumDataTraffic >= 1;

/* Az összes olyan tárhely, aminek nincsen egy domain címe sem */
SELECT s.Name FROM Storage s
LEFT JOIN Domain d ON d.StorageId = s.Id
GROUP BY s.Name
HAVING COUNT(d.Id) = 0;

/* Van-e az adott (1-es Id) felhasználónak közvetlen nem kifizetett tartozása */
SELECT b.BillId FROM Bill b
LEFT JOIN Payment p ON p.BillId = b.Id
WHERE b.UserId = 1 && p.Id IS NULL && b.Deadline >= NOW();

/* Azok a webtárhelyek, amiknek a domain címe már lejárt */
SELECT s.Name, s.Expiration FROM Storage s
INNER JOIN Domain d ON s.Id = d.StorageId
WHERE s.Expiration <= NOW();

/* _2019-09-12_ - _2020-02-23_ között regisztrált felhasználók, által végzett kifezetési tranzakciók */
SELECT u.UserName, p.TransactionId FROM User u
INNER JOIN Payment p ON u.Id = p.UserId
WHERE p.Date BETWEEN '2019-09-12' AND '2020-02-23';

/* Melyek azok az adatközpontok, ahol legalább a webtárhelyek fele rendelkezik adatbázissal, PHP-val és e-mail fiókkal is? */
SELECT CenterName(dc.City, dc.Number) AS Center FROM DataCenter dc
INNER JOIN Storage s on dc.Id = s.DataCenterId
INNER JOIN StorageType st on s.TypeId = st.Id
WHERE st.PHPEnabled && st.MaximumEmailAccounts > 0
GROUP BY dc.Id
HAVING COUNT(s.Id) >= GetStorageNumber(dc.Id) / 2;

/* Mely PHP futtatással rendelkező domainen lesz karbantartás a következő hónapban (30 nap), a _BUD1_ adatközpontban? */
SELECT * FROM Domain d
INNER JOIN Storage s on d.StorageId = s.Id
INNER JOIN StorageType st on s.TypeId = st.Id
INNER JOIN DataCenter dc on s.DataCenterId = dc.Id
WHERE dc.Name = 'BUD1' AND st.PHPEnabled; /* IDK */

/* Mely _.hu_ domain nevek voltak az utóbbi _2 hónapban_ befizetve? */
SELECT DomainAddress(d.DomainAddress, d.TLD) as Domain FROM Domain d
INNER JOIN Bill b on d.Id = b.DomainId
INNER JOIN Payment p on b.Id = p.BillId
WHERE d.TLD = 'hu' AND p.Date >= DATE_SUB(NOW(), INTERVAL 2 MONTH);

/* Az egyes felhasználók mennyi aktív értesítéssel rendelkeznek? */
SELECT u.UserName, GetActiveUserNotifications(u.Id) Notifications FROM User u;