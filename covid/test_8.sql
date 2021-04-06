-- 在2015/2016的季賽中，對於各聯賽，已知某隊伍隊員平均身高大於180，求該
-- 隊獲勝概率為何？
-- （分子：獲勝隊伍為平均身高大於180隊伍次數，分母：平均身高大於180的隊
-- 伍次數，四捨五入至小數點後第4位）
-- （請依照聯賽名稱字典順序輸出）

-- 分子：隊伍平均身高大於180的獲勝次數
-- 分母：隊伍平均身高大於180的參賽次數



SELECT * FROM match_info M WHERE season = '2015/2016';

SELECT * FROM player P WHERE 


SELECT 
    height 
FROM 
    match_info M,
    league L,
    player P 
WHERE 
    season = '2015/2016' 
AND
    M.league_id = L.id 
AND 
((
    (
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_1) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_2) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_3) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_4) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_5) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_6) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_7) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_8) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_9) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_10) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_11) 
    ) > 1980 
)
) LIMIT 5;

-- id / height / person
SELECT Height.id,Height.sum as height,Person.sum as person FROM 
(SELECT 
    M.id as id,
    M.home_team_id,
    (IFNULL(P1.height, 0)+IFNULL(P2.height, 0)+IFNULL(P3.height, 0)+IFNULL(P4.height, 0)+IFNULL(P5.height, 0)+IFNULL(P6.height, 0)+IFNULL(P7.height, 0)+IFNULL(P8.height, 0)+IFNULL(P9.height, 0)+IFNULL(P10.height, 0)+IFNULL(P11.height, 0)) AS sum
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
LEFT JOIN player P11 ON M.home_player_11 = P11.player_api_id  
WHERE season = '2015/2016') AS Height,
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
FROM match_info WHERE season = '2015/2016') as a) AS Person 
WHERE Person.id = Height.id LIMIT 100; 


SELECT 
    M.id,
    M.home_team_id,
    M.home_player_1,P1.height,
    M.home_player_2,P2.height,
    M.home_player_3,P3.height,
    M.home_player_4,P4.height,
    M.home_player_5,P5.height,
    M.home_player_6,P6.height,
    M.home_player_7,P7.height,
    M.home_player_8,P8.height,
    M.home_player_9,P9.height,
    M.home_player_10,P10.height,
    M.home_player_11,P11.height,
    (IFNULL(P1.height, 0)+IFNULL(P2.height, 0)+IFNULL(P3.height, 0)+IFNULL(P4.height, 0)+IFNULL(P5.height, 0)+IFNULL(P6.height, 0)+IFNULL(P7.height, 0)+IFNULL(P8.height, 0)+IFNULL(P9.height, 0)+IFNULL(P10.height, 0)+IFNULL(P11.height, 0)) AS sum
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
LEFT JOIN player P11 ON M.home_player_11 = P11.player_api_id  
WHERE season = '2015/2016';



SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when home_player_1 is NULL then 0
     when home_player_1 is not NULL then 1 
END AS c1,
case when home_player_2 is NULL then 0
     when home_player_2 is not NULL then 1 
END AS c2,
case when home_player_3 is NULL then 0
     when home_player_3 is not NULL then 1 
END AS c3,
case when home_player_4 is NULL then 0
     when home_player_4 is not NULL then 1 
END AS c4,
case when home_player_5 is NULL then 0
     when home_player_5 is not NULL then 1 
END AS c5,
case when home_player_6 is NULL then 0
     when home_player_6 is not NULL then 1 
END AS c6,
case when home_player_7 is NULL then 0
     when home_player_7 is not NULL then 1 
END AS c7,
case when home_player_8 is NULL then 0
     when home_player_8 is not NULL then 1 
END AS c8,
case when home_player_9 is NULL then 0
     when home_player_9 is not NULL then 1 
END AS c9,
case when home_player_10 is NULL then 0
     when home_player_10 is not NULL then 1 
END AS c10,
case when home_player_11 is NULL then 0
     when home_player_11 is not NULL then 1 
END AS c11 FROM match_info) as a;




select id,
case when home_player_1 is NULL then 0
     when home_player_1 is not NULL then 1 
END AS c1,
case when home_player_2 is NULL then 0
     when home_player_2 is not NULL then 1 
END AS c2,
case when home_player_3 is NULL then 0
     when home_player_3 is not NULL then 1 
END AS c3,
case when home_player_4 is NULL then 0
     when home_player_4 is not NULL then 1 
END AS c4,
case when home_player_5 is NULL then 0
     when home_player_5 is not NULL then 1 
END AS c5,
case when home_player_6 is NULL then 0
     when home_player_6 is not NULL then 1 
END AS c6,
case when home_player_7 is NULL then 0
     when home_player_7 is not NULL then 1 
END AS c7,
case when home_player_8 is NULL then 0
     when home_player_8 is not NULL then 1 
END AS c8,
case when home_player_9 is NULL then 0
     when home_player_9 is not NULL then 1 
END AS c9,
case when home_player_10 is NULL then 0
     when home_player_10 is not NULL then 1 
END AS c10,
case when home_player_11 is NULL then 0
     when home_player_11 is not NULL then 1 
END AS c11 FROM match_info;


