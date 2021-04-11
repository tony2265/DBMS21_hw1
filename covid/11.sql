-- 比賽通常都會有所謂的「主場優勢」，但是主場優勢也只是優勢，不能保證為隊伍帶來勝利。
-- 你認為
擁有主場優勢的隊伍
隊伍選手依照「其參加比賽前最後一次測量attribute」的平均程度較高的隊伍
比較容易贏？

-- （此題為開放式答案，請用一個SQL找出的結果闡述你的觀點。程度可以是整體分數、運球分數、強度分數、截攔分數四選一，或是將這四種分數平均當作這個選手當時的程度）

-- [主場隊伍]勝率、[平均整體分數較高的隊伍]勝率
-- [主場隊伍]勝率
SELECT SUM(home_team_score>away_team_score)/COUNT(id) FROM match_info;


SELECT id,home_team_score,away_team_score FROM match_info LIMIT 100;


-- [平均整體分數較高的隊伍]勝率
SELECT 
    M.id as id,
    (IF(P1.score is NULL,0,1)+IF(P2.score is NULL,0,1)+IF(P3.score is NULL,0,1)+IF(P4.score is NULL,0,1)+IF(P5.score is NULL,0,1)+IF(P6.score is NULL,0,1)+IF(P7.score is NULL,0,1)+IF(P8.score is NULL,0,1)+IF(P9.score is NULL,0,1)+IF(P10.score is NULL,0,1)+IF(P11.score is NULL,0,1)) as person,
    (IFNULL(P1.score, 0)+IFNULL(P2.score, 0)+IFNULL(P3.score, 0)+IFNULL(P4.score, 0)+IFNULL(P5.score, 0)+IFNULL(P6.score, 0)+IFNULL(P7.score, 0)+IFNULL(P8.score, 0)+IFNULL(P9.score, 0)+IFNULL(P10.score, 0)+IFNULL(P11.score, 0)) AS sum
FROM 
    match_info M
LEFT JOIN (SELECT M.id,P.overall_rating as score FROM match_info M 
LEFT JOIN (SELECT date,player_api_id,overall_rating FROM player_attributes) P ON M.home_player_1 = P.player_api_id 
  WHERE P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date))) P1 ON M.id = P1.id  
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
;


--
Select A.ID,A.product,A.importDate From temp.updateTime,B.updateStatus TableA as A
inner join (Select MAX(updateTime) as updateTime ,product From TableB Group by product) as temp
on A.product=temp.product
inner join TableB as B on B.statusTime=temp.statusTime



-- 各場比賽的 HOME P1 前六個月測試平均
SELECT M.id,AVG(P.overall_rating) as score FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id AND (0<=TIMESTAMPDIFF(MONTH,P.date,M.date) AND TIMESTAMPDIFF(MONTH,P.date,M.date)<6) GROUP BY (M.id)

-- 各場比賽的 HOME P1 比賽前的前次測試日期
SELECT M.id,MAX(P.date) as score FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date) GROUP BY (M.id);
SELECT M.id,M.date,P.date as score FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date) ORDER BY M.id;



-- 各場比賽的 HOME P1 比賽前的前次測試成績

SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date)) ;

SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date));


SELECT M.id,P.overall_rating as score FROM match_info M, P;
-- 找P1找
SELECT P.date,P.overall_rating FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date) ORDER BY P.date DESC LIMIT 1;

SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id


SELECT M.id,MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date) GROUP BY M.id;



-- 改
SELECT M.id,M.date,P.date,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date) ORDER BY M.id,P.date DESC LIMIT 100;


SELECT M.id
FROM (
      SELECT Train, MAX(Time) as MaxTime
      FROM TrainTable
      GROUP BY Train
) r
INNER JOIN TrainTable t
ON t.Train = r.Train AND t.Time = r.MaxTime



SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id AND P.date=(SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date));