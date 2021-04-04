SELECT * FROM time_province;


SELECT AVG(A.elderly_population_ratio) FROM region AS A WHERE A.province = A.city;
-- 地區沒錯
SELECT R.province AS province FROM region AS R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(A.elderly_population_ratio) FROM region AS A WHERE A.province = A.city);

SELECT province FROM time_province GROUP BY province;
-- 錯的是地區有多個最大單日、以及有地區消失了
SELECT T.date,T.province,T.confirmed FROM 
time_province T WHERE T.province in (SELECT R.province AS province FROM region AS R WHERE R.elderly_population_ratio > (SELECT AVG(A.elderly_population_ratio) FROM region AS A WHERE A.province = A.city));


SELECT date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city));

SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city));


SELECT B.province,B.date,(B.confirmed-A.confirmed) AS cnt FROM 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) A, 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) B 
WHERE A.No+2 = B.No AND A.province = B.province;


SELECT N.province,MAX(cnt) FROM (SELECT B.province,B.date,(B.confirmed-A.confirmed) AS cnt FROM 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) A, 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) B 
WHERE A.No+2 = B.No AND A.province = B.province) AS N 
GROUP BY N.province;


SELECT Win.province,Time.date FROM (SELECT N.province,MAX(cnt) as max FROM (SELECT B.province,B.date,(B.confirmed-A.confirmed) AS cnt FROM 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) A, 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) B 
WHERE A.No+2 = B.No AND A.province = B.province) AS N 
GROUP BY N.province) AS Win,(SELECT B.province,B.date,(B.confirmed-A.confirmed) AS cnt FROM 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) A, 
(SELECT rank() over (order by date) No,date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) B 
WHERE A.No+2 = B.No AND A.province = B.province
) AS Time 
WHERE Win.province = Time.province AND Win.max = Time.cnt;

SELECT * FROM (SELECT date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) as A,
(SELECT date,province,confirmed FROM time_province WHERE province in (SELECT R.province FROM region R WHERE R.province = R.city AND R.elderly_population_ratio > (SELECT AVG(R.elderly_population_ratio) FROM region R WHERE R.province = R.city))) AS B WHERE A.province = B.province AND A.date = B.date;