SELECT st.date,st.num as coronavirus,data.confirmed as confirmed_accumulate,data.confirmed_add as confirmed_add,data.deceased as dead_accumulate,data.dead_add as dead_add FROM 
(SELECT b.date,b.confirmed,(b.confirmed-a.confirmed) as confirmed_add,b.deceased,(b.deceased-a.deceased) as dead_add FROM 
(SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time) as a,
(SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time) as b 
WHERE 
(a.No+1 = b.No) OR (b.No = 1 AND a.No = 1)) AS data,
(
SELECT date,CAST(coronavirus as decimal(38, 2)) as num FROM 
search_trend as st,
(SELECT STD(coronavirus) as num FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as std, 
(SELECT AVG(coronavirus) as num FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as avg  
WHERE st.coronavirus > 2*std.num+avg.num) as st 
WHERE data.date = st.date;

SELECT b.date,b.confirmed,b.confirmed-a.confirmed,b.deceased,b.deceased-a.deceased FROM 
(SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time) as a,
(SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time) as b 
WHERE 
(a.No+1 = b.No) OR (b.No = 1 AND a.No = 1);

SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time;

SELECT date,CAST(coronavirus as decimal(38, 2)) as num FROM 
search_trend as st,
(SELECT STD(coronavirus) as num FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as std, 
(SELECT AVG(coronavirus) as num FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as avg  
WHERE st.coronavirus > 2*std.num+avg.num;


SELECT * FROM 
search_trend as st,
(SELECT STD(coronavirus) as num FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as std, 
(SELECT AVG(coronavirus) as num FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as avg  
WHERE st.coronavirus > 2*std.num+avg.num;

SELECT STD(coronavirus) as std FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30';


SELECT (coronavirus - avg.a)*(coronavirus - avg.a) as b FROM search_trend,(SELECT AVG(coronavirus) as a FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as avg WHERE date > '2019-12-24' AND date < '2020-06-30';


SELECT AVG(coronavirus) as a FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30';
SELECT * FROM time;

-- coronavirus 的搜尋次數大於其平均兩個標準差時，
-- 該天檢測陽性人數（累積）、檢測陽性增加幅度、死亡人數（累積）、死亡人數增加幅度各有多少人？
-- 依照時間由小到大排序，並將coronavirus四捨五入到小數點後第二位
-- （coronavirus的標準差請利用2019-12-25至2020-06-29的數值來計算）
-- （增加幅度請用該天累積人數減去前一天的累積人數）

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
