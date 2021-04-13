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
    P1.id,P1.score,P2.score,P3.score,P4.score,P5.score,P6.score,P7.score,P8.score,P9.score,P10.score,P11.score
FROM 
(SELECT id FROM match_info) M,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date))
) P1,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P2,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P3,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P4,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P5,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P6,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P7,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P8,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P9,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P10,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P11 
WHERE M.id = P1.id AND M.id = P2.id AND M.id = P3.id AND M.id = P4.id AND M.id = P5.id AND M.id = P6.id AND M.id = P7.id AND M.id = P8.id AND M.id = P9.id AND M.id = P10.id AND M.id = P11.id;


SELECT 
    M.id,P1.score,P2.score,P3.score,P4.score,P5.score
FROM 
(SELECT id FROM match_info) M,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date))
) P1,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P2,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_3 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_3 = P.player_api_id AND (P.date<M.date))
) P3,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_4 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_4 = P.player_api_id AND (P.date<M.date))
) P4,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_5 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_5 = P.player_api_id AND (P.date<M.date))
) P5
WHERE M.id = P1.id AND M.id = P2.id AND M.id = P3.id AND M.id = P4.id AND M.id = P5.id ;



------------------
SELECT 
    M.id,P1.score
FROM 
(SELECT id FROM match_info) M 
LEFT JOIN(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<=M.date))
) P1 ON M.id = P1.id ;


SELECT  M.id FROM match_info M;


------------------
SELECT 
    M.id,P1.score
FROM 
(SELECT id FROM match_info) M 
,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<=M.date))
) P1 WHERE M.id = P1.id ;


SELECT 
     M.id,P1.score,P2.score,P3.score,P4.score,P5.score
FROM(
          (
               (
                    (
                         match_info M
                         INNER JOIN (SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
                         WHERE M.home_player_1 = P.player_api_id AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date))) P1 
                         ON M.id =P1.id
                    )
                    INNER JOIN(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
                    WHERE M.home_player_2 = P.player_api_id AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))) P2 
                    ON M.id = P2.id 
               )
               INNER JOIN (SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
               WHERE M.home_player_3 = P.player_api_id AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_3 = P.player_api_id AND (P.date<M.date))) P3 
               ON M.id = P3.id
          )
          INNER JOIN (SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
          WHERE M.home_player_4 = P.player_api_id AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_4 = P.player_api_id AND (P.date<M.date))) P4 
          ON M.id = P4.id
     )
     INNER JOIN (SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_5 = P.player_api_id AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_5 = P.player_api_id AND (P.date<M.date))) P5 
     ON M.id = P5.id
;


WITH
H1 AS
(
     SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_1 = P.player_api_id 
     AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<=M.date))
),
H2 AS
(
     SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_2 = P.player_api_id 
     AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<=M.date))
),
H3 AS
(
     SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_3 = P.player_api_id 
     AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_3 = P.player_api_id AND (P.date<=M.date))
),
H4 AS
(
     SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_4 = P.player_api_id 
     AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_4 = P.player_api_id AND (P.date<=M.date))
),
H5 AS
(
     SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_5 = P.player_api_id 
     AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_5 = P.player_api_id AND (P.date<=M.date))
),
H6 AS
(
     SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
     WHERE M.home_player_6 = P.player_api_id 
     AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_6 = P.player_api_id AND (P.date<=M.date))
)

SELECT M.id,H1.score FROM match_info M,H1,H2,H3,H4,H5,H6 WHERE M.id = H1.id AND M.id = H2.id AND M.id = H3.id AND M.id = H4.id AND M.id = H5.id AND M.id = H6.id;


SELECT 
    M.id,(P1.score+P2.score+P3.score) as score
FROM 
(SELECT id FROM match_info) M,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_1 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_1 = P.player_api_id AND (P.date<M.date))
) P1,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_2 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_2 = P.player_api_id AND (P.date<M.date))
) P2,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_3 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_3 = P.player_api_id AND (P.date<M.date))
) P3
WHERE M.id = P1.id AND M.id = P2.id AND M.id = P3.id ;

SELECT 
    M.id,(P4.score+P5.score+P6.score) as score
FROM 
(SELECT id FROM match_info) M,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_4 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_4 = P.player_api_id AND (P.date<M.date))
) P4,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_5 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_5 = P.player_api_id AND (P.date<M.date))
) P5,
(SELECT M.id,P.overall_rating as score FROM match_info M,player_attributes P 
WHERE M.home_player_6 = P.player_api_id 
AND P.date = (SELECT MAX(P.date) FROM match_info M,player_attributes P WHERE M.home_player_6 = P.player_api_id AND (P.date<M.date))
) P6
WHERE M.id = P4.id AND M.id = P5.id AND M.id = P6.id ;




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