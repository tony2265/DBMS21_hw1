SELECT p.preferred_foot,CAST(AVG(p.long_shots) as decimal(38, 2)) as avg_long_shots 
FROM 
player_attributes as p,
(SELECT player_api_id,MAX(date) as m FROM player_attributes,(
(SELECT home_player_1 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_2 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_3 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_4 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_5 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_6 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_7 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_8 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_9 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_10 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT home_player_11 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_1 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_2 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_3 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_4 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_5 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_6 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_7 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_8 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_9 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_10 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' ) UNION 
(SELECT away_player_11 as py FROM match_info M,league L WHERE M.league_id = L.id AND L.name = 'Italy Serie A' AND season = '2015/2016' )) AS A 
WHERE player_api_id IN (A.py) GROUP BY player_api_id) as new 
WHERE p.player_api_id = new.player_api_id AND p.date = new.m 
GROUP BY p.preferred_foot 
LIMIT 2;