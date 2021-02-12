/* Questions */

/* Data centers listája név alapján ASC rendezve és város szám füzött kódda */
SELECT dc.Name, CONCAT(dc.City, '-', dc.Number) as Keyword FROM DataCenter dc
ORDER BY Name;