## Kérdések és a hozzájuk tartozó SQL kódok

1. Hány _.com_ TLD-jű domain van beregisztrálva a rendszerbe?

```sql
SELECT COUNT(d.TLD) as AddressCount
    FROM `Domain` d
    GROUP BY d.TLD
    HAVING d.TLD LIKE 'com';
```

![Query 1](./queries/query1.png "Query 1")

2. Hol találhatók Adatközpontok és mi a jeligéjük?

```sql
SELECT dc.City, CenterName(dc.City, dc.Number) as Keyword
    FROM `DataCenter` dc
    ORDER BY Keyword;
```

![Query 2](./queries/query2.png "Query 2")

3. Mi a 3 legtöbb szerverteremmel rendelkező város neve? (Csökkenő sorrendben és a darabszámok is jelenjenek meg)

```sql
SELECT dc.City, COUNT(dc.Id) as Count
    FROM `DataCenter` dc
    GROUP BY dc.City
    ORDER BY Count DESC, dc.City
    LIMIT 3;
```

![Query 3](./queries/query3.png "Query 3")

4. Mely csomagok tartalmaznak PHP futtatási lehetőséget?

```sql
SELECT st.Name
    FROM `StorageType` st
    WHERE st.PHPEnabled;
```

![Query 4](./queries/query4.png "Query 4")

5. Mely webtárhelyek rendelkeznek SSH eléréssel és engedélyezett adatforgalmuk több, mint 100 GB, illetve mikor lettek ezek létrehozva?

```sql
SELECT s.Name, s.Creation
    FROM `Storage` s
    INNER JOIN `StorageType` st ON st.Id = s.TypeId
    WHERE st.SSHEnabled AND s.MaximumDataTraffic >= 100;
```

![Query 5](./queries/query5.png "Query 5")

6. Mely webtárhelyek nem rendelkeznek egy Domain címmel sem?

```sql
SELECT s.Name
    FROM `Storage` s
    LEFT JOIN `Domain` d ON d.StorageId = s.Id
    WHERE d.Id IS NULL
    GROUP BY s.Name;
```

![Query 6](./queries/query6.png "Query 6")

7. Van-e az _1_-es Id-val rendelkező felhasználónak közvetlen nem befizetett számlája és mi annak az azonosítója?

```sql
SELECT b.BillId
    FROM `Bill` b
    LEFT JOIN `Payment` p ON p.BillId = b.Id
    WHERE b.UserId = 1 && p.Id IS NULL AND b.Deadline >= NOW();
```

![Query 7](./queries/query7.png "Query 7")

<div class="page-break"></div>

8. Melyek azok a domain címek, amikhez a kapcsolt tárhely lejárt és mikor?

```sql
SELECT DomainAddress(d.DomainAddress, d.TLD) as Address,
        s.Expiration
    FROM `Domain` d
    INNER JOIN `Storage` s ON s.Id = d.StorageId
    WHERE s.Expiration < NOW();
```

![Query 8](./queries/query8.png "Query 8")

9. Milyen befizetések történtek _2019-09-12_ - _2020-02-23_ között regisztrált felhasználóktól? Mely felhasználóknak és mi volt a tranzakció azonosító?

```sql
SELECT u.UserName, p.TransactionId
    FROM `User` u
    INNER JOIN `Payment` p ON u.Id = p.UserId
    WHERE p.Date BETWEEN '2019-09-12' AND '2020-02-23';
```

![Query 9](./queries/query9.png "Query 9")

10. Éves statisztika az egyes domain címekhez, amik tartalmazzák az összes látógatást és az összes egyedi látógatót.

```sql
SELECT DomainAddress(d.DomainAddress, d.TLD) as `Address`,
        COALESCE(YEAR(s.Month), YEAR(NOW())) AS Year,
        COALESCE(SUM(s.Views), 0) AS ViewSum,
        COALESCE(SUM(s.UniqueViewers), 0) as UViewSum
    FROM `Domain` d
    LEFT JOIN `Statistic` s ON s.DomainId = d.Id
    GROUP BY DomainAddress, Year
    ORDER BY `Address` ASC, Year DESC;
```

![Query 10](./queries/query10.png "Query 10")

<div class="page-break"></div>

11. Melyek azok az adatközpontok, ahol legalább a webtárhelyek fele rendelkezik adatbázissal, PHP-val és e-mail fiókkal is?

```sql
SELECT CenterName(dc.City, dc.Number) AS Center
    FROM `DataCenter` dc
    INNER JOIN `Storage` s on dc.Id = s.DataCenterId
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    WHERE st.PHPEnabled && st.MaximumEmailAccounts > 0
    GROUP BY dc.Id
    HAVING COUNT(s.Id) >= GetStorageNumber(dc.Id) / 2;
```

![Query 11](./queries/query11.png "Query 11")

12. Mely PHP futtatással rendelkező domainen lesz karbantartás a következő hónapban (30 nap), a _BUD1_ adatközpontban?

```sql
SELECT DomainAddress(d.DomainAddress, d.TLD) AS Address
    FROM `Domain` d
    INNER JOIN `Storage` s on d.StorageId = s.Id
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    INNER JOIN `DataCenter` dc on s.DataCenterId = dc.Id
    INNER JOIN `Notification` n on d.Id = n.DomainId
    WHERE dc.Name = 'BUD1' AND st.PHPEnabled AND n.Title = 'maintenance'
        AND n.TimeFrameEnd <= DATE_ADD(NOW(), INTERVAL 30 DAY)
    GROUP BY Address;
```

![Query 12](./queries/query12.png "Query 12")

13. Mely _.hu_ domain nevek voltak az utóbbi _2 hónapban_ befizetve?

```sql
SELECT DomainAddress(d.DomainAddress, d.TLD) as Domain
    FROM `Domain` d
    INNER JOIN `Bill` b on d.Id = b.DomainId
    INNER JOIN `Payment` p on b.Id = p.BillId
    WHERE d.TLD = 'hu'
        AND p.Date >= DATE_SUB(NOW(), INTERVAL 2 MONTH);
```

![Query 13](./queries/query13.png "Query 13")

<div class="page-break"></div>

14. Az egyes felhasználók mennyi aktív értesítéssel rendelkeznek?

```sql
SELECT u.UserName, GetActiveUserNotifications(u.Id) Notifications
    FROM `User` u;
```

![Query 14](./queries/query14.png "Query 14")

15. Melyek azok a domain nevek, amelyhez _Maxi_ csomagú tárhelyet kapcsoltak?

```sql
SELECT DomainAddress(d.DomainAddress, d.TLD) as Address
    FROM `Domain` d
    INNER JOIN `Storage` s on d.StorageId = s.Id
    INNER JOIN `StorageType` st on s.TypeId = st.Id
    WHERE st.Name = 'Maxi';
```

![Query 15](./queries/query15.png "Query 15")

16. Melyek a legterheltebb adatközpontok? (Lefoglalt GB és Látogatottság viszonylatban)

```sql
SELECT CenterName(dc.City, dc.Number) AS Center
    FROM `DataCenter` dc
    INNER JOIN `Storage` s on dc.Id = s.DataCenterId
    LEFT JOIN `Domain` d on s.Id = d.StorageId
    LEFT JOIN `Statistic` stat on d.Id = stat.DomainId
    GROUP BY dc.Id
    ORDER BY SUM(
            (s.Size + s.EmailStorageSize + s.DatabaseSize)
            * (stat.Views / 100)
        ) DESC;
```

![Query 16](./queries/query16.png "Query 16")

<div class="page-break"></div>

17. Kik azok a felhasználók, akik a határidő előtti napon fizették be a számlát? (és melyek ezek a számlák?)

```sql
SELECT b.BillId, u.FullName
    FROM `User` u
    INNER JOIN `Bill` b on u.Id = b.UserId
    INNER JOIN `Payment` p on b.Id = p.BillId
    WHERE p.Date < b.Deadline
        AND p.Date > SUBDATE(b.Deadline, INTERVAL 1 DAY);
```

18. A top 5 PHP futtatás nélküli weboldalak és tulajdonosaik, amelyek látogatottsága a legmagasabb?

```sql
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
```

![Query 18](./queries/query18.png "Query 18")

> Az összes query megtalálható a `queries.sql` fájlban.

<div class="page-break"></div>
