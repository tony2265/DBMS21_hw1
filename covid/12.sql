-- 什麼情況下進行怎樣的下注會是比較建議的

SELECT (SUM((IF(H.rating>A.rating,1,0))*(IF(M.home_team_score>M.away_team_score,1,0)))+SUM((IF(H.rating<A.rating,1,0))*(IF(M.home_team_score<M.away_team_score,1,0))))/COUNT(M.id) as prob FROM 
match_info M,
(SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
(SELECT 
    M.id as id,
    (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
    (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_2 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_3 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_4 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_5 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_6 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_7 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_8 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_9 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_10 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_11 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR) as H,
(SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
(SELECT 
    M.id as id,
    (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
    (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P1 ON M.id = P1.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_2 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P2 ON M.id = P2.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_3 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P3 ON M.id = P3.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_4 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P4 ON M.id = P4.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_5 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P5 ON M.id = P5.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_6 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P6 ON M.id = P6.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_7 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P7 ON M.id = P7.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_8 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P8 ON M.id = P8.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_9 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P9 ON M.id = P9.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_10 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P10 ON M.id = P10.id  
LEFT JOIN (SELECT M.id,AVG(P.strength+P.dribbling+P.long_shots+P.interceptions) as score FROM match_info M,player_attributes P 
     WHERE M.away_player_11 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)) P11 ON M.id = P11.id  
) AS OAR) AS A WHERE M.id = A.id AND M.id = H.id;







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






