SELECT 
province,COUNT(w.date) as cnt 
FROM weather as w,region as r 
WHERE 
(r.code = w.code) AND 
(w.date LIKE '2016-05-%') AND 
(w.avg_relative_humidity > 70) 
GROUP BY province 
ORDER BY cnt DESC 
LIMIT 3;