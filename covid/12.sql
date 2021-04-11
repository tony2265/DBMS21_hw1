-- 在 主場的隊伍，其隊伍整體分數平均高於客場隊伍，下注的期望值
SELECT SUM( 0.5835*(B365H-1)+(1-0.5835)*(-1) ) FROM 
match_info M,
(SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
     (SELECT 
     M.id as id,
     (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
     (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
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
     ) AS OAR) as H,

(SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
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
     ) AS OAR) AS A 
WHERE M.id = A.id AND M.id = H.id AND (H.rating > A.rating) AND B365H IS NOT NULL;

-- home 主場平均高的勝率 0.5835
-- home 主場平均高的平率 0.2350
-- home 主場平均高的敗率 0.1815

-- home 主場平均高的勝率 0.5835
SELECT (SUM((IF(H.rating>A.rating,1,0))*(IF(M.home_team_score>M.away_team_score,1,0)))/SUM(IF(H.rating>A.rating,1,0))) as Win_prob FROM 
     match_info M,
     (SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
     (SELECT 
     M.id as id,
     (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
     (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
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
     ) AS OAR) as H,
     (SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
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
     ) AS OAR) AS A WHERE M.id = A.id AND M.id = H.id;

-- home 主場平均高的平率 0.2350
SELECT (SUM((IF(H.rating>A.rating,1,0))*(IF(M.home_team_score=M.away_team_score,1,0)))/SUM(IF(H.rating>A.rating,1,0))) as Tie_prob FROM 
     match_info M,
     (SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
     (SELECT 
     M.id as id,
     (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
     (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
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
     ) AS OAR) as H,
     (SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
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
     ) AS OAR) AS A WHERE M.id = A.id AND M.id = H.id;

-- home 主場平均高的敗率 0.1815
SELECT (SUM((IF(H.rating>A.rating,1,0))*(IF(M.home_team_score<M.away_team_score,1,0)))/SUM(IF(H.rating>A.rating,1,0))) as Loss_prob FROM 
     match_info M,
     (SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
     (SELECT 
     M.id as id,
     (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
     (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
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
     ) AS OAR) as H,
     (SELECT OAR.id,(OAR.sum/OAR.person) as rating FROM 
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
     ) AS OAR) AS A WHERE M.id = A.id AND M.id = H.id;