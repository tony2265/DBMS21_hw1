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
SELECT m.id AS id 
FROM match_info m 
WHERE (((m.home_team_score-m.away_team_score)>=5) AND
      ((m.B365H>m.B365A) OR (m.WHH>m.WHA)  OR (SJH>SJA)))
      OR
      (((m.away_team_score-m.home_team_score)>=5) AND
      ((m.B365A>m.B365H) OR (m.WHA>m.WHH)  OR (SJA>SJH)));


SELECT *  FROM 
(SELECT m.id AS id 
FROM match_info m 
WHERE (((m.home_team_score-m.away_team_score)>=5) AND
      ((m.B365H>m.B365A) OR (m.WHH>m.WHA)  OR (SJH>SJA)))
      OR
      (((m.away_team_score-m.home_team_score)>=5) AND
      ((m.B365A>m.B365H) OR (m.WHA>m.WHH)  OR (SJA>SJH)))) AS ID,
match_info M,




-- home id、總年紀、總人數
SELECT Height.id,Height.sum as height,Person.sum as person FROM 
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
WHERE Person.id = Height.id;  



-- 單人平均年紀
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
