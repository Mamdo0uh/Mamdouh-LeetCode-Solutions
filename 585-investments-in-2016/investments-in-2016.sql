SELECT ROUND(CAST(SUM(tiv_2016) AS DECIMAL(18,2)), 2) AS tiv_2016
FROM insurance
WHERE tiv_2015 IN (SELECT tiv_2015 FROM insurance GROUP BY tiv_2015
    HAVING COUNT(pid) > 1
) 
AND CONCAT(lat, ',', lon) IN ( SELECT CONCAT(lat, ',', lon) FROM insurance
GROUP BY lat, lon
    HAVING COUNT(pid) = 1
)