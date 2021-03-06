/* Questions */

/* 1. A `.com` domainek száma */
SELECT COUNT(d.TLD) as AddressCount
    FROM `Domain` d
    GROUP BY d.TLD
    HAVING d.TLD LIKE 'com';

/* 2. Data centers listája név alapján ASC rendezve és város szám füzött kóddal */
SELECT dc.City, CenterName(dc.City, dc.Number) as Keyword
    FROM `DataCenter` dc
    ORDER BY Keyword;

/* 3. A top 3 legtöbb központtal rendelkező város neve (Csökkenő sorrendben, darabszámmal) */
SELECT dc.City, COUNT(dc.Id) as Count
    FROM `DataCenter` dc
    GROUP BY dc.City
    ORDER BY Count DESC, dc.City
    LIMIT 3;

/* 4. Tárhely típusok neveinek listája ahol van php */
SELECT st.Name
    FROM `StorageType` st
    WHERE st.PHPEnabled;

/* 5. Az összes webtárhely neve és létrehozási dátuma, ahol SSH engedélyezve van és a maximum adatforgalom nagyobb mint vagy egyenlő 100 GB */
SELECT s.Name, s.Creation
    FROM `Storage` s
    INNER JOIN `StorageType` st ON st.Id = s.TypeId
    WHERE st.SSHEnabled AND s.MaximumDataTraffic >= 100;

/* 6. Az összes olyan tárhely, aminek nincsen egy domain címe sem */
SELECT s.Name
    FROM `Storage` s
    LEFT JOIN `Domain` d ON d.StorageId = s.Id
    WHERE d.Id IS NULL
    GROUP BY s.Name;

/* 7. Van-e az adott (1-es Id) felhasználónak közvetlen nem befizetett tartozása */
SELECT b.BillId
    FROM `Bill` b
    LEFT JOIN `Payment` p ON p.BillId = b.Id
    WHERE b.UserId = 1 && p.Id IS NULL AND b.Deadline >= NOW();

/* 8. Azok a domain címek, amikhez a kapcsolt tárhely lejárt és mikor */
SELECT DomainAddress(d.DomainAddress, d.TLD) as Address,
        s.Expiration
    FROM `Domain` d
    INNER JOIN `Storage` s ON s.Id = d.StorageId
    WHERE s.Expiration < NOW();

/* 9. _2019-09-12_ - _2020-02-23_ között regisztrált felhasználók, által végzett befezetési tranzakciók */
SELECT u.UserName, p.TransactionId
    FROM `User` u
    INNER JOIN `Payment` p ON u.Id = p.UserId
    WHERE p.Date BETWEEN '2019-09-12' AND '2020-02-23';

/* 10. Évi statisztika az egyes domainekhez */
SELECT DomainAddress(d.DomainAddress, d.TLD) as `Address`,
        COALESCE(YEAR(s.Month), YEAR(NOW())) AS Year,
        COALESCE(SUM(s.Views), 0) AS ViewSum,
        COALESCE(SUM(s.UniqueViewers), 0) as UViewSum
    FROM `Domain` d
    LEFT JOIN `Statistic` s ON s.DomainId = d.Id
    GROUP BY DomainAddress, Year
    ORDER BY `Address` ASC, Year DESC;

/* 11. Melyek azok az adatközpontok, ahol legalább a webtárhelyek fele rendelkezik adatbázissal, PHP-val és e-mail fiókkal is? */
SELECT CenterName(dc.City, dc.Number) AS Center
    FROM `DataCenter` dc
    INNER JOIN `Storage` s on dc.Id = s.DataCenterId
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    WHERE st.PHPEnabled && st.MaximumEmailAccounts > 0
    GROUP BY dc.Id
    HAVING COUNT(s.Id) >= GetStorageNumber(dc.Id) / 2;

/* 12. Mely PHP futtatással rendelkező domainen lesz karbantartás a következő hónapban (30 nap), a _BUD1_ adatközpontban */
SELECT DomainAddress(d.DomainAddress, d.TLD) AS Address
    FROM `Domain` d
    INNER JOIN `Storage` s on d.StorageId = s.Id
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    INNER JOIN `DataCenter` dc on s.DataCenterId = dc.Id
    INNER JOIN `Notification` n on d.Id = n.DomainId
    WHERE dc.Name = 'BUD1' AND st.PHPEnabled AND n.Title = 'maintenance'
        AND n.TimeFrameEnd <= DATE_ADD(NOW(), INTERVAL 30 DAY)
    GROUP BY Address;

/* 13. Mely _.hu_ domain nevek voltak az utóbbi _2 hónapban_ befizetve? */
SELECT DomainAddress(d.DomainAddress, d.TLD) as Domain
    FROM `Domain` d
    INNER JOIN `Bill` b on d.Id = b.DomainId
    INNER JOIN `Payment` p on b.Id = p.BillId
    WHERE d.TLD = 'hu'
        AND p.Date >= DATE_SUB(NOW(), INTERVAL 2 MONTH);

/* 14. Az egyes felhasználók mennyi aktív értesítéssel rendelkeznek? */
SELECT u.UserName, GetActiveUserNotifications(u.Id) Notifications
    FROM `User` u;

/* 15. Melyek azok a domain nevek, amelyek _Maxi_ csomaggal rendelkeznek? */
SELECT DomainAddress(d.DomainAddress, d.TLD) as Address
    FROM `Domain` d
    INNER JOIN `Storage` s on d.StorageId = s.Id
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    WHERE st.Name = 'Maxi';

/* 16. Melyik a legterheltebb adatközpontok? (Foglalt GB / Látogatottság) */
SELECT CenterName(dc.City, dc.Number) AS Center
    FROM `DataCenter` dc
    INNER JOIN `Storage` s on dc.Id = s.DataCenterId
    LEFT JOIN `Domain` d on s.Id = d.StorageId
    LEFT JOIN `Statistic` stat on d.Id = stat.DomainId
    GROUP BY dc.Id
    ORDER BY SUM(
            (s.Size + s.EmailStorageSize + s.DatabaseSize)
            * (COALESCE(stat.Views, 1) / 100)
        ) DESC;

/* 17. Kik azok a felhasználók, akik a határidő előtti napon fizették be a számlát? (és melyek ezek a számlák?) */
SELECT b.BillId, u.FullName
    FROM `User` u
    INNER JOIN `Bill` b on u.Id = b.UserId
    INNER JOIN `Payment` p on b.Id = p.BillId
    WHERE p.Date < b.Deadline
        AND p.Date > SUBDATE(b.Deadline, INTERVAL 1 DAY);

/* 18. PHP futtatás nélkül, mely weboldalak látogatottsága a legmagasabb? */
SELECT DomainAddress(d.DomainAddress, d.TLD) AS DomainAdd,
        u.FullName
    FROM `Domain` d
    INNER JOIN `Storage` s on d.StorageId = s.Id
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    INNER JOIN `User` u on d.UserId = u.Id
    LEFT JOIN `Statistic` stat on d.Id = stat.DomainId
    WHERE NOT st.PHPEnabled
    GROUP BY DomainAdd
    ORDER BY SUM(stat.Views) DESC
    LIMIT 5;
