SELECT Win.province,Time.date FROM (SELECT N.province,MAX(cnt) as max FROM (
    SELECT B.province,B.date,(B.confirmed-A.confirmed) AS cnt FROM 
    (SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) as A, 
    (SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) as B,
    (SELECT COUNT(R.province) AS cnt FROM region AS R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(A.elderly_population_ratio) FROM region AS A WHERE A.province = A.city)) as C 
    WHERE A.No+C.cnt = B.No AND A.province = B.province
    ) AS N 
GROUP BY N.province) AS Win,(
    SELECT B.province,B.date,(B.confirmed-A.confirmed) AS cnt FROM 
    (SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) as A, 
    (SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) as B, 
    (SELECT COUNT(R.province) AS cnt FROM region AS R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(A.elderly_population_ratio) FROM region AS A WHERE A.province = A.city)) as C 
    WHERE A.No+C.cnt = B.No AND A.province = B.province
    ) AS Time 
WHERE Win.province = Time.province AND Win.max = Time.cnt;