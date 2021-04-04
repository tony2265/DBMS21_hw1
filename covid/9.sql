SELECT a.team_long_name,CAST(a.avg_win_score as decimal(38, 2)) AS avg_win_score FROM (
SELECT two.name as team_long_name,(total_home.score+total_away.score)/(total_home.num+total_away.num) AS avg_win_score FROM 
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
ORDER BY (two.num*2+one.num+a_two.num*2+a_one.num)/(total_home.num+total_away.num) DESC 
LIMIT 5) as a;

