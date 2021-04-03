SELECT st.date,st.num as coronavirus,data.confirmed as confirmed_accumulate,data.confirmed_add as confirmed_add,data.deceased as dead_accumulate,data.dead_add as dead_add FROM 
(SELECT b.date,b.confirmed,(b.confirmed-a.confirmed) as confirmed_add,b.deceased,(b.deceased-a.deceased) as dead_add FROM 
(SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time) as a,
(SELECT rank() over (order by date) as No,date,confirmed,deceased FROM time) as b 
WHERE 
(a.No+1 = b.No) OR (b.No = 1 AND a.No = 1)) AS data,
(SELECT date,CAST(coronavirus as decimal(38, 2)) as num FROM 
search_trend as st,
(SELECT SQRT(SUM((sub.b)*(sub.b))/COUNT(sub.b)) as num FROM 
(SELECT (coronavirus - avg.a) as b FROM search_trend,(SELECT AVG(coronavirus) as a FROM search_trend WHERE date > '2019-12-24' AND date < '2020-06-30') as avg 
WHERE date > '2019-12-24' AND date < '2020-06-30') as sub) as sd 
WHERE st.coronavirus > 2*sd.num) as st 
WHERE data.date = st.date;