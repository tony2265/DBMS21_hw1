SELECT H.team_long_name,CAST(S.avg_win_score as decimal(38, 2)) as avg_win_score FROM 
(SELECT t.team_long_name,COUNT(m.id) as cnt,SUM(m.home_team_score>m.away_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score  
FROM match_info m ,team t 
WHERE season = '2015/2016' 
AND t.id = m.home_team_id 
GROUP BY m.home_team_id 
ORDER BY t.team_long_name) AS H,
(SELECT t.team_long_name,COUNT(m.id) as cnt,SUM(m.away_team_score>m.home_team_score)*2+SUM(m.home_team_score=m.away_team_score) AS score   
FROM match_info m ,team t 
WHERE season = '2015/2016' 
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