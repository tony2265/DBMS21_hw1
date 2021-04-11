-- home、平手、away:賠率
-- B365H | B365D | B365A | WHH  | WHD  | WHA  | SJH  | SJD  | SJA  


-- 爆冷門 : 指得分數相差大於等於5、且任一家賭商開的賠率較輸的隊伍高
-- 依照賽事id由小到大排序

-- 選手平均年紀、當時算起前六個月內選手平均整體分數各是多少


SELECT 
    m.id,
    m.home_team_score,
    m.away_team_score,
    ((m.home_team_score-m.away_team_score)>=5),
    (m.B365H>m.B365A) 
FROM match_info m LIMIT 5;


-- id
SELECT id    
FROM match_info 
WHERE (((home_team_score-away_team_score)>=5) AND
      ((B365H>B365A AND B365H>B365D) OR (WHH>WHA AND WHH>WHD)  OR (SJH>SJA AND SJH > SJD)))
      OR
      (((away_team_score-home_team_score)>=5) AND
      ((B365A>B365H AND B365A>B365D) OR (WHA>WHH AND WHA>WHD)  OR (SJA>SJH AND SJA>SJD)));


SELECT *  FROM 
(SELECT m.id AS id 
FROM match_info m 
WHERE (((m.home_team_score-m.away_team_score)>=5) AND
      ((m.B365H>m.B365A) OR (m.WHH>m.WHA)  OR (SJH>SJA)))
      OR
      (((m.away_team_score-m.home_team_score)>=5) AND
      ((m.B365A>m.B365H) OR (m.WHA>m.WHH)  OR (SJA>SJH)))) AS ID,
match_info M,

-- HOME ALL
SELECT ID.id as id,
CAST(H_age.age as decimal(38, 2)) as home_player_avg_age,
CAST(A_age.age as decimal(38, 2)) as away_player_avg_age,
CAST(H_rating.rating as decimal(38, 2)) as home_player_avg_rating,
CAST(A_rating.rating as decimal(38, 2)) as away_player_avg_rating 
FROM 
(SELECT id    
FROM match_info 
WHERE (((home_team_score-away_team_score)>=5) AND
      ((B365H>B365A AND B365H>B365D) OR (WHH>WHA AND WHH>WHD)  OR (SJH>SJA AND SJH > SJD)))
      OR
      (((away_team_score-home_team_score)>=5) AND
      ((B365A>B365H AND B365A>B365D) OR (WHA>WHH AND WHA>WHD)  OR (SJA>SJH AND SJA>SJD)))) AS ID 
LEFT JOIN(SELECT B.id,(B.sum/Person.sum) as age FROM 
(SELECT 
    M.id as id,
    (IFNULL((DATEDIFF(M.date,P1.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P2.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P3.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P4.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P5.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P6.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P7.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P8.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P9.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P10.birthday)/365.25),0)+
     IFNULL((DATEDIFF(M.date,P11.birthday)/365.25),0)) AS sum
FROM 
    match_info M 
LEFT JOIN player P1 ON M.home_player_1 = P1.player_api_id  
LEFT JOIN player P2 ON M.home_player_2 = P2.player_api_id  
LEFT JOIN player P3 ON M.home_player_3 = P3.player_api_id  
LEFT JOIN player P4 ON M.home_player_4 = P4.player_api_id  
LEFT JOIN player P5 ON M.home_player_5 = P5.player_api_id  
LEFT JOIN player P6 ON M.home_player_6 = P6.player_api_id  
LEFT JOIN player P7 ON M.home_player_7 = P7.player_api_id  
LEFT JOIN player P8 ON M.home_player_8 = P8.player_api_id  
LEFT JOIN player P9 ON M.home_player_9 = P9.player_api_id  
LEFT JOIN player P10 ON M.home_player_10 = P10.player_api_id  
LEFT JOIN player P11 ON M.home_player_11 = P11.player_api_id) AS B,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0 when home_player_1 is not NULL then 1 END AS c1,
case when home_player_2 is NULL then 0 when home_player_2 is not NULL then 1 END AS c2,
case when home_player_3 is NULL then 0 when home_player_3 is not NULL then 1 END AS c3,
case when home_player_4 is NULL then 0 when home_player_4 is not NULL then 1 END AS c4,
case when home_player_5 is NULL then 0 when home_player_5 is not NULL then 1 END AS c5,
case when home_player_6 is NULL then 0 when home_player_6 is not NULL then 1 END AS c6,
case when home_player_7 is NULL then 0 when home_player_7 is not NULL then 1 END AS c7,
case when home_player_8 is NULL then 0 when home_player_8 is not NULL then 1 END AS c8,
case when home_player_9 is NULL then 0 when home_player_9 is not NULL then 1 END AS c9,
case when home_player_10 is NULL then 0 when home_player_10 is not NULL then 1 END AS c10,
case when home_player_11 is NULL then 0 when home_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = B.id) H_age ON ID.id = H_age.id 
LEFT JOIN (SELECT B.id,(B.sum/Person.sum) as age FROM 
(SELECT 
    M.id as id,
    (IFNULL((DATEDIFF(M.date,P1.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P2.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P3.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P4.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P5.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P6.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P7.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P8.birthday)/365.25), 0)+
     IFNULL((DATEDIFF(M.date,P9.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P10.birthday)/365.25),0)+
     IFNULL((DATEDIFF(M.date,P11.birthday)/365.25),0)) AS sum
FROM 
    match_info M 
LEFT JOIN player P1 ON  M.away_player_1 = P1.player_api_id  
LEFT JOIN player P2 ON  M.away_player_2 = P2.player_api_id  
LEFT JOIN player P3 ON  M.away_player_3 = P3.player_api_id  
LEFT JOIN player P4 ON  M.away_player_4 = P4.player_api_id  
LEFT JOIN player P5 ON  M.away_player_5 = P5.player_api_id  
LEFT JOIN player P6 ON  M.away_player_6 = P6.player_api_id  
LEFT JOIN player P7 ON  M.away_player_7 = P7.player_api_id  
LEFT JOIN player P8 ON  M.away_player_8 = P8.player_api_id  
LEFT JOIN player P9 ON  M.away_player_9 = P9.player_api_id  
LEFT JOIN player P10 ON M.away_player_10 = P10.player_api_id  
LEFT JOIN player P11 ON M.away_player_11 = P11.player_api_id) AS B,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when away_player_1  is NULL then 0 when away_player_1 is not NULL then 1 END AS c1,
case when away_player_2  is NULL then 0 when away_player_2 is not NULL then 1 END AS c2,
case when away_player_3  is NULL then 0 when away_player_3 is not NULL then 1 END AS c3,
case when away_player_4  is NULL then 0 when away_player_4 is not NULL then 1 END AS c4,
case when away_player_5  is NULL then 0 when away_player_5 is not NULL then 1 END AS c5,
case when away_player_6  is NULL then 0 when away_player_6 is not NULL then 1 END AS c6,
case when away_player_7  is NULL then 0 when away_player_7 is not NULL then 1 END AS c7,
case when away_player_8  is NULL then 0 when away_player_8 is not NULL then 1 END AS c8,
case when away_player_9  is NULL then 0 when away_player_9 is not NULL then 1 END AS c9,
case when away_player_10 is NULL then 0 when away_player_10 is not NULL then 1 END AS c10,
case when away_player_11 is NULL then 0 when away_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = B.id) A_age ON ID.id = A_age.id 
LEFT JOIN 
(SELECT OAR.id,(OAR.sum/Person.sum) as rating FROM 
(SELECT 
    M.id as id,
    ((IFNULL(P1.score, 0))+(IFNULL(P2.score, 0))+(IFNULL(P3.score, 0))+(IFNULL(P4.score, 0))+(IFNULL(P5.score, 0))+(IFNULL(P6.score, 0))+(IFNULL(P7.score, 0))+(IFNULL(P8.score, 0))+(IFNULL(P9.score, 0))+(IFNULL(P10.score, 0))+(IFNULL(P11.score, 0))) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_2 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_3 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_4 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_5 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_6 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_7 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_8 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_9 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_10 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_11 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0 when home_player_1 is not NULL then 1 END AS c1,
case when home_player_2 is NULL then 0 when home_player_2 is not NULL then 1 END AS c2,
case when home_player_3 is NULL then 0 when home_player_3 is not NULL then 1 END AS c3,
case when home_player_4 is NULL then 0 when home_player_4 is not NULL then 1 END AS c4,
case when home_player_5 is NULL then 0 when home_player_5 is not NULL then 1 END AS c5,
case when home_player_6 is NULL then 0 when home_player_6 is not NULL then 1 END AS c6,
case when home_player_7 is NULL then 0 when home_player_7 is not NULL then 1 END AS c7,
case when home_player_8 is NULL then 0 when home_player_8 is not NULL then 1 END AS c8,
case when home_player_9 is NULL then 0 when home_player_9 is not NULL then 1 END AS c9,
case when home_player_10 is NULL then 0 when home_player_10 is not NULL then 1 END AS c10,
case when home_player_11 is NULL then 0 when home_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = OAR.id) H_rating ON ID.id = H_rating.id 
LEFT JOIN 
(SELECT OAR.id,(OAR.sum/Person.sum) as rating FROM 
(SELECT 
    M.id as id,
    ((IFNULL(P1.score, 0))+(IFNULL(P2.score, 0))+(IFNULL(P3.score, 0))+(IFNULL(P4.score, 0))+(IFNULL(P5.score, 0))+(IFNULL(P6.score, 0))+(IFNULL(P7.score, 0))+(IFNULL(P8.score, 0))+(IFNULL(P9.score, 0))+(IFNULL(P10.score, 0))+(IFNULL(P11.score, 0))) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_1 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_2 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_3 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_4 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_5 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_6 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_7 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_8 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_9 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_10 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_11 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when away_player_1  is NULL then 0 when away_player_1 is not NULL then 1 END AS c1,
case when away_player_2  is NULL then 0 when away_player_2 is not NULL then 1 END AS c2,
case when away_player_3  is NULL then 0 when away_player_3 is not NULL then 1 END AS c3,
case when away_player_4  is NULL then 0 when away_player_4 is not NULL then 1 END AS c4,
case when away_player_5  is NULL then 0 when away_player_5 is not NULL then 1 END AS c5,
case when away_player_6  is NULL then 0 when away_player_6 is not NULL then 1 END AS c6,
case when away_player_7  is NULL then 0 when away_player_7 is not NULL then 1 END AS c7,
case when away_player_8  is NULL then 0 when away_player_8 is not NULL then 1 END AS c8,
case when away_player_9  is NULL then 0 when away_player_9 is not NULL then 1 END AS c9,
case when away_player_10 is NULL then 0 when away_player_10 is not NULL then 1 END AS c10,
case when away_player_11 is NULL then 0 when away_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = OAR.id) A_rating ON ID.id = A_rating.id;
-- ----------------------------------------------------------------------

(0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6)
(M.date >= P.date AND P.date > DATE_ADD(M.date,INTERVAL -6 MONTH))

-- home id、總年紀、總人數
SELECT B.id,(B.sum/Person.sum) as age FROM 
(SELECT 
    M.id as id,
--     (IFNULL((DATEDIFF(M.date,P1.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P2.birthday)/365.25), 0)+
--      IFNULL((DATEDIFF(M.date,P3.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P4.birthday)/365.25), 0)+
--      IFNULL((DATEDIFF(M.date,P5.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P6.birthday)/365.25), 0)+
--      IFNULL((DATEDIFF(M.date,P7.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P8.birthday)/365.25), 0)+
--      IFNULL((DATEDIFF(M.date,P9.birthday)/365.25), 0)+IFNULL((DATEDIFF(M.date,P10.birthday)/365.25),0)+
--      IFNULL((DATEDIFF(M.date,P11.birthday)/365.25),0)) AS sum
    (IFNULL((TIMESTAMPDIFF(YEAR,P1.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P2.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P3.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P4.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P5.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P6.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P7.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P8.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P9.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P10.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P11.birthday,M.date)), 0)) AS sum
FROM 
    match_info M 
LEFT JOIN player P1 ON M.home_player_1 = P1.player_api_id  
LEFT JOIN player P2 ON M.home_player_2 = P2.player_api_id  
LEFT JOIN player P3 ON M.home_player_3 = P3.player_api_id  
LEFT JOIN player P4 ON M.home_player_4 = P4.player_api_id  
LEFT JOIN player P5 ON M.home_player_5 = P5.player_api_id  
LEFT JOIN player P6 ON M.home_player_6 = P6.player_api_id  
LEFT JOIN player P7 ON M.home_player_7 = P7.player_api_id  
LEFT JOIN player P8 ON M.home_player_8 = P8.player_api_id  
LEFT JOIN player P9 ON M.home_player_9 = P9.player_api_id  
LEFT JOIN player P10 ON M.home_player_10 = P10.player_api_id  
LEFT JOIN player P11 ON M.home_player_11 = P11.player_api_id) AS B 
WHERE Person.id = B.id AND B.id = 538;

-- away id、總年紀、總人數
SELECT B.id,(B.sum/B.person) as age FROM 
(SELECT 
    M.id as id,
    (IF(P1.birthday is NULL,0,1)+IF(P2.birthday is NULL,0,1)+IF(P3.birthday is NULL,0,1)+IF(P4.birthday is NULL,0,1)+IF(P5.birthday is NULL,0,1)+IF(P6.birthday is NULL,0,1)+IF(P7.birthday is NULL,0,1)+IF(P8.birthday is NULL,0,1)+IF(P9.birthday is NULL,0,1)+IF(P10.birthday is NULL,0,1)+IF(P11.birthday is NULL,0,1)) as person,
    (IFNULL((TIMESTAMPDIFF(YEAR,P1.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P2.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P3.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P4.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P5.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P6.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P7.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P8.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P9.birthday,M.date)), 0)+IFNULL((TIMESTAMPDIFF(YEAR,P10.birthday,M.date)), 0)+
     IFNULL((TIMESTAMPDIFF(YEAR,P11.birthday,M.date)), 0)) AS sum
FROM 
    match_info M 
LEFT JOIN player P1 ON  M.away_player_1 = P1.player_api_id  
LEFT JOIN player P2 ON  M.away_player_2 = P2.player_api_id  
LEFT JOIN player P3 ON  M.away_player_3 = P3.player_api_id  
LEFT JOIN player P4 ON  M.away_player_4 = P4.player_api_id  
LEFT JOIN player P5 ON  M.away_player_5 = P5.player_api_id  
LEFT JOIN player P6 ON  M.away_player_6 = P6.player_api_id  
LEFT JOIN player P7 ON  M.away_player_7 = P7.player_api_id  
LEFT JOIN player P8 ON  M.away_player_8 = P8.player_api_id  
LEFT JOIN player P9 ON  M.away_player_9 = P9.player_api_id  
LEFT JOIN player P10 ON M.away_player_10 = P10.player_api_id  
LEFT JOIN player P11 ON M.away_player_11 = P11.player_api_id) AS B;



















-- HOME各隊選手平均整體分數
SELECT OAR.id,(OAR.sum/Person.sum) as rating FROM 
(SELECT 
    M.id as id,
    ((IFNULL(P1.score, 0))+(IFNULL(P2.score, 0))+(IFNULL(P3.score, 0))+(IFNULL(P4.score, 0))+(IFNULL(P5.score, 0))+(IFNULL(P6.score, 0))+(IFNULL(P7.score, 0))+(IFNULL(P8.score, 0))+(IFNULL(P9.score, 0))+(IFNULL(P10.score, 0))+(IFNULL(P11.score, 0))) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_2 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_3 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_4 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_5 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_6 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_7 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_8 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_9 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_10 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_11 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0 when home_player_1 is not NULL then 1 END AS c1,
case when home_player_2 is NULL then 0 when home_player_2 is not NULL then 1 END AS c2,
case when home_player_3 is NULL then 0 when home_player_3 is not NULL then 1 END AS c3,
case when home_player_4 is NULL then 0 when home_player_4 is not NULL then 1 END AS c4,
case when home_player_5 is NULL then 0 when home_player_5 is not NULL then 1 END AS c5,
case when home_player_6 is NULL then 0 when home_player_6 is not NULL then 1 END AS c6,
case when home_player_7 is NULL then 0 when home_player_7 is not NULL then 1 END AS c7,
case when home_player_8 is NULL then 0 when home_player_8 is not NULL then 1 END AS c8,
case when home_player_9 is NULL then 0 when home_player_9 is not NULL then 1 END AS c9,
case when home_player_10 is NULL then 0 when home_player_10 is not NULL then 1 END AS c10,
case when home_player_11 is NULL then 0 when home_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = OAR.id;

-- 改

SELECT OAR.id,(OAR.sum/Person.sum) as rating FROM 
(SELECT 
    M.id as id,
    ((IFNULL(P1.score, 0))+(IFNULL(P2.score, 0))+(IFNULL(P3.score, 0))+(IFNULL(P4.score, 0))+(IFNULL(P5.score, 0))+(IFNULL(P6.score, 0))+(IFNULL(P7.score, 0))+(IFNULL(P8.score, 0))+(IFNULL(P9.score, 0))+(IFNULL(P10.score, 0))+(IFNULL(P11.score, 0))) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_2 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_3 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_4 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_5 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_6 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_7 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_8 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_9 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_10 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_11 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0 when home_player_1 is not NULL then 1 END AS c1,
case when home_player_2 is NULL then 0 when home_player_2 is not NULL then 1 END AS c2,
case when home_player_3 is NULL then 0 when home_player_3 is not NULL then 1 END AS c3,
case when home_player_4 is NULL then 0 when home_player_4 is not NULL then 1 END AS c4,
case when home_player_5 is NULL then 0 when home_player_5 is not NULL then 1 END AS c5,
case when home_player_6 is NULL then 0 when home_player_6 is not NULL then 1 END AS c6,
case when home_player_7 is NULL then 0 when home_player_7 is not NULL then 1 END AS c7,
case when home_player_8 is NULL then 0 when home_player_8 is not NULL then 1 END AS c8,
case when home_player_9 is NULL then 0 when home_player_9 is not NULL then 1 END AS c9,
case when home_player_10 is NULL then 0 when home_player_10 is not NULL then 1 END AS c10,
case when home_player_11 is NULL then 0 when home_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = OAR.id AND OAR.id = 23433;


SELECT M.id,M.date,P.date,P.overall_rating FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) AND M.id = 23433;

SELECT M.id,M.date,P.date,P.overall_rating FROM match_info M,player_attributes P 
     WHERE M.home_player_11 = P.player_api_id AND  AND M.id = 23433;


SELECT M.id,M.date,P.date,P.overall_rating FROM match_info M,player_attributes P 
     WHERE M.away_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) AND M.id = 23433;


-- away各隊選手平均整體分數
SELECT OAR.id,(OAR.sum/Person.sum) as rating FROM 
(SELECT 
    M.id as id,
    ((IFNULL(P1.score, 0))+(IFNULL(P2.score, 0))+(IFNULL(P3.score, 0))+(IFNULL(P4.score, 0))+(IFNULL(P5.score, 0))+(IFNULL(P6.score, 0))+(IFNULL(P7.score, 0))+(IFNULL(P8.score, 0))+(IFNULL(P9.score, 0))+(IFNULL(P10.score, 0))+(IFNULL(P11.score, 0))) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_1 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_2 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_3 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_4 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_5 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_6 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_7 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_8 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_9 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_10 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_11 = P.player_api_id AND (TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when away_player_1  is NULL then 0 when away_player_1 is not NULL then 1 END AS c1,
case when away_player_2  is NULL then 0 when away_player_2 is not NULL then 1 END AS c2,
case when away_player_3  is NULL then 0 when away_player_3 is not NULL then 1 END AS c3,
case when away_player_4  is NULL then 0 when away_player_4 is not NULL then 1 END AS c4,
case when away_player_5  is NULL then 0 when away_player_5 is not NULL then 1 END AS c5,
case when away_player_6  is NULL then 0 when away_player_6 is not NULL then 1 END AS c6,
case when away_player_7  is NULL then 0 when away_player_7 is not NULL then 1 END AS c7,
case when away_player_8  is NULL then 0 when away_player_8 is not NULL then 1 END AS c8,
case when away_player_9  is NULL then 0 when away_player_9 is not NULL then 1 END AS c9,
case when away_player_10 is NULL then 0 when away_player_10 is not NULL then 1 END AS c10,
case when away_player_11 is NULL then 0 when away_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = OAR.id;  





-- 改 success
SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
(SELECT 
    M.id as id,
    (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
    (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_2 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_3 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_4 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_5 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_6 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_7 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_8 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_9 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_10 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_11 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR;






-- 單人平均年紀 P1
SELECT Height.id,Height.age FROM 
(SELECT 
    M.id as id,
    (DATEDIFF(M.date,P1.birthday)/365.25) as age
FROM 
    match_info M
LEFT JOIN player P1 ON M.home_player_1 = P1.player_api_id  
LEFT JOIN player P2 ON M.home_player_2 = P2.player_api_id  
LEFT JOIN player P3 ON M.home_player_3 = P3.player_api_id  
LEFT JOIN player P4 ON M.home_player_4 = P4.player_api_id  
LEFT JOIN player P5 ON M.home_player_5 = P5.player_api_id  
LEFT JOIN player P6 ON M.home_player_6 = P6.player_api_id  
LEFT JOIN player P7 ON M.home_player_7 = P7.player_api_id  
LEFT JOIN player P8 ON M.home_player_8 = P8.player_api_id  
LEFT JOIN player P9 ON M.home_player_9 = P9.player_api_id  
LEFT JOIN player P10 ON M.home_player_10 = P10.player_api_id  
LEFT JOIN player P11 ON M.home_player_11 = P11.player_api_id ) AS Height,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0 when home_player_1 is not NULL then 1 END AS c1,
case when home_player_2 is NULL then 0 when home_player_2 is not NULL then 1 END AS c2,
case when home_player_3 is NULL then 0 when home_player_3 is not NULL then 1 END AS c3,
case when home_player_4 is NULL then 0 when home_player_4 is not NULL then 1 END AS c4,
case when home_player_5 is NULL then 0 when home_player_5 is not NULL then 1 END AS c5,
case when home_player_6 is NULL then 0 when home_player_6 is not NULL then 1 END AS c6,
case when home_player_7 is NULL then 0 when home_player_7 is not NULL then 1 END AS c7,
case when home_player_8 is NULL then 0 when home_player_8 is not NULL then 1 END AS c8,
case when home_player_9 is NULL then 0 when home_player_9 is not NULL then 1 END AS c9,
case when home_player_10 is NULL then 0 when home_player_10 is not NULL then 1 END AS c10,
case when home_player_11 is NULL then 0 when home_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = Height.id LIMIT 100;  



-- 單人平均整體分數 P1
SELECT * FROM 
(SELECT 
    M.id as id 
FROM 
    match_info M
LEFT JOIN player_attributes P1 ON M.home_player_1 = P1.player_api_id  
LEFT JOIN player_attributes P2 ON M.home_player_2 = P2.player_api_id  
LEFT JOIN player_attributes P3 ON M.home_player_3 = P3.player_api_id  
LEFT JOIN player_attributes P4 ON M.home_player_4 = P4.player_api_id  
LEFT JOIN player_attributes P5 ON M.home_player_5 = P5.player_api_id  
LEFT JOIN player_attributes P6 ON M.home_player_6 = P6.player_api_id  
LEFT JOIN player_attributes P7 ON M.home_player_7 = P7.player_api_id  
LEFT JOIN player_attributes P8 ON M.home_player_8 = P8.player_api_id  
LEFT JOIN player_attributes P9 ON M.home_player_9 = P9.player_api_id  
LEFT JOIN player_attributes P10 ON M.home_player_10 = P10.player_api_id  
LEFT JOIN player_attributes P11 ON M.home_player_11 = P11.player_api_id ) AS overall_rating,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0 when home_player_1 is not NULL then 1 END AS c1,
case when home_player_2 is NULL then 0 when home_player_2 is not NULL then 1 END AS c2,
case when home_player_3 is NULL then 0 when home_player_3 is not NULL then 1 END AS c3,
case when home_player_4 is NULL then 0 when home_player_4 is not NULL then 1 END AS c4,
case when home_player_5 is NULL then 0 when home_player_5 is not NULL then 1 END AS c5,
case when home_player_6 is NULL then 0 when home_player_6 is not NULL then 1 END AS c6,
case when home_player_7 is NULL then 0 when home_player_7 is not NULL then 1 END AS c7,
case when home_player_8 is NULL then 0 when home_player_8 is not NULL then 1 END AS c8,
case when home_player_9 is NULL then 0 when home_player_9 is not NULL then 1 END AS c9,
case when home_player_10 is NULL then 0 when home_player_10 is not NULL then 1 END AS c10,
case when home_player_11 is NULL then 0 when home_player_11 is not NULL then 1 END AS c11 
FROM match_info ) as a) AS Person 
WHERE Person.id = overall_rating.id LIMIT 10;  


-- 「當時算起前六個月內（不含）」P1選手平均整體分數
SELECT M.id,M.home_player_1,AVG(P1.overall_rating) as P1_score 
FROM match_info M,player_attributes P1 
WHERE M.home_player_1 = P1.player_api_id AND (TIMESTAMPDIFF(MONTH,P1.date,M.date)<6) GROUP BY (M.id) LIMIT 100;
