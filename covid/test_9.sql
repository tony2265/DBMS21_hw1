-- 參加的每一場比賽平均
-- 可以贏對手幾分

-- home場數
SELECT t.team_long_name,COUNT(m.id),SUM(m.home_team_score>m.away_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score  
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id 
ORDER BY t.team_long_name;

-- away場數
SELECT t.team_long_name,COUNT(m.id),SUM(m.away_team_score>m.home_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score   
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.away_team_id 
GROUP BY m.away_team_id 
ORDER BY t.team_long_name;

-- 年度強權
SELECT H.team_long_name, (H.score+A.score)/(A.cnt+H.cnt) as score FROM 
(SELECT t.team_long_name,COUNT(m.id) as cnt,SUM(m.home_team_score>m.away_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score  
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id 
ORDER BY t.team_long_name) AS H,
(SELECT t.team_long_name,COUNT(m.id) as cnt,SUM(m.away_team_score>m.home_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score   
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.away_team_id 
GROUP BY m.away_team_id 
ORDER BY t.team_long_name) AS A 
WHERE A.team_long_name = H.team_long_name ORDER BY score DESC LIMIT 5;



-- 可能正確
SELECT H.team_long_name,CAST(S.avg_win_score as decimal(38, 2)) as avg_win_score FROM 
(SELECT t.team_long_name,COUNT(m.id) as cnt,SUM(m.home_team_score>m.away_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score  
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id 
ORDER BY t.team_long_name) AS H,
(SELECT t.team_long_name,COUNT(m.id) as cnt,SUM(m.away_team_score>m.home_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score   
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.away_team_id 
GROUP BY m.away_team_id 
ORDER BY t.team_long_name) AS A 
LEFT JOIN (SELECT H.team_long_name,(H.score+A.score)/(H.cnt+A.cnt) as avg_win_score FROM 
(SELECT t.team_long_name,SUM(m.home_team_score-m.away_team_score) AS score,COUNT(m.id) AS cnt FROM match_info m,team t 
WHERE t.id = m.home_team_id AND season = '2015/2016' GROUP BY m.home_team_id ORDER BY t.team_long_name) AS H,
(SELECT t.team_long_name,SUM(m.away_team_score-m.home_team_score) AS score,COUNT(m.id) AS cnt FROM match_info m,team t 
WHERE t.id = m.away_team_id AND season = '2015/2016' GROUP BY m.away_team_id ORDER BY t.team_long_name) AS A 
WHERE H.team_long_name = A.team_long_name ORDER BY avg_win_score DESC LIMIT 20) AS S ON S.team_long_name = A.team_long_name 
WHERE A.team_long_name = H.team_long_name ORDER BY (H.score+A.score)/(A.cnt+H.cnt)  DESC LIMIT 5;


-- avg_win_score 
SELECT H.team_long_name,(H.score+A.score)/(H.cnt+A.cnt) as avg_win_score FROM 
(SELECT t.team_long_name,SUM(m.home_team_score-m.away_team_score) AS score,COUNT(m.id) AS cnt FROM match_info m,team t 
WHERE t.id = m.home_team_id AND season = '2015/2016' GROUP BY m.home_team_id ORDER BY t.team_long_name) AS H,
(SELECT t.team_long_name,SUM(m.away_team_score-m.home_team_score) AS score,COUNT(m.id) AS cnt FROM match_info m,team t 
WHERE t.id = m.away_team_id AND season = '2015/2016' GROUP BY m.away_team_id ORDER BY t.team_long_name) AS A 
WHERE H.team_long_name = A.team_long_name ORDER BY avg_win_score;


SELECT m.id,t.team_long_name,m.home_team_id,m.away_team_id,(m.home_team_score-m.away_team_score) AS score FROM match_info m,team t 
WHERE t.id = m.home_team_id AND season = '2015/2016' AND m.home_team_id = 15624;

SELECT m.id,t.team_long_name,m.home_team_id,m.away_team_id,(m.away_team_score-m.home_team_score) AS score FROM match_info m,team t 
WHERE t.id = m.away_team_id AND season = '2015/2016' AND m.away_team_id = 15624;


SELECT t.team_long_name,SUM(m.home_team_score-m.away_team_score) AS score,COUNT(m.id) FROM match_info m,team t 
WHERE t.id = m.home_team_id AND season = '2015/2016' GROUP BY m.home_team_id ORDER BY t.team_long_name;

SELECT t.team_long_name,SUM(m.away_team_score-m.home_team_score) AS score,COUNT(m.id) FROM match_info m,team t 
WHERE t.id = m.away_team_id AND season = '2015/2016' GROUP BY m.away_team_id ORDER BY t.team_long_name;


SELECT


SELECT two.name as team_long_name,(two.num*2+one.num+a_two.num*2+a_one.num)/(total_home.num+total_away.num) as seq,(total_home.score+total_away.score)/(total_home.num+total_away.num) AS avg_win_score FROM 
(SELECT t.team_long_name as name,COUNT(m.id) as num 
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND 
m.home_team_score > m.away_team_score 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id
ORDER BY t.team_long_name) AS two,
(SELECT t.team_long_name as name,COUNT(m.id) as num 
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND 
m.home_team_score = m.away_team_score 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id
ORDER BY t.team_long_name) as one,
(SELECT t.team_long_name as name,COUNT(m.id) as num 
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND 
m.away_team_score > m.home_team_score 
AND t.id = m.away_team_id 
GROUP BY m.away_team_id
ORDER BY t.team_long_name) as a_two,
(SELECT t.team_long_name as name,COUNT(m.id) as num  
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND 
m.home_team_score = m.away_team_score 
AND t.id = m.away_team_id 
GROUP BY m.away_team_id
ORDER BY t.team_long_name) as a_one,
(SELECT t.team_long_name as name,COUNT(m.id) as num,SUM(m.home_team_score-m.away_team_score) as score 
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id 
ORDER BY t.team_long_name) as total_home,
(SELECT t.team_long_name as name,COUNT(m.id) as num,SUM(m.away_team_score-m.home_team_score) as score 
FROM match_info m ,team t 
WHERE 
season = '2015/2016' 
AND t.id = m.away_team_id 
GROUP BY m.away_team_id 
ORDER BY t.team_long_name) as total_away 
WHERE two.name = one.name AND two.name = a_one.name AND two.name = a_two.name AND two.name = total_home.name AND two.name = total_away.name 
ORDER BY seq DESC 
LIMIT 5;

