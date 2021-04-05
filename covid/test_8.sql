SELECT 
    L.name,COUNT(M.id) AS H  
FROM 
    match_info M,
    league L 
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
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_10)+
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_11) 
    ) > 1980 
)
-- AND
-- (
--     (SELECT -180 FROM match_info M WHERE M.home_player_1 IS NULL)
-- ) 
)
GROUP BY L.name;

SELECT height FROM match_info M,player P WHERE P.player_api_id = M.home_player_1 AND M.home_player_1 IS NOT NULL;

SELECT -180 FROM match_info M WHERE M.home_player_1 IS NULL;

SELECT MIN(height),MAX(height) FROM player P ;


SELECT D.name as name,(M.molecular/D.denominator) as prob FROM
(SELECT A.name as name,(H+A) as denominator FROM
(SELECT 
    L.name,COUNT(M.id) AS H  
FROM 
    match_info M,
    league L 
WHERE 
    season = '2015/2016' 
AND
    M.league_id = L.id 
AND 
((
    (
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_1 AND M.home_player_1 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_2 AND M.home_player_2 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_3 AND M.home_player_3 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_4 AND M.home_player_4 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_5 AND M.home_player_5 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_6 AND M.home_player_6 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_7 AND M.home_player_7 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_8 AND M.home_player_8 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_9 AND M.home_player_9 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_10 AND M.home_player_10 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_11 AND M.home_player_11 IS NOT NULL) 
    ) > 1980 
)
-- AND IS NOT NULL
-- (
--     (SELECT height FROM match_info M WHERE M.home_player_1 IS NOT NULL)
-- ) 
)
GROUP BY L.name) AS H,
(SELECT 
    L.name,COUNT(M.id) AS A  
FROM 
    match_info M,
    league L 
WHERE 
    season = '2015/2016' 
AND
    M.league_id = L.id 
AND 
((
    (
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_1 AND M.away_player_1 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_2 AND M.away_player_2 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_3 AND M.away_player_3 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_4 AND M.away_player_4 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_5 AND M.away_player_5 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_6 AND M.away_player_6 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_7 AND M.away_player_7 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_8 AND M.away_player_8 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_9 AND M.away_player_9 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_10 AND M.away_player_10 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_11 AND M.away_player_11 IS NOT NULL) 
    ) > 1980 
) )
GROUP BY L.name) AS A 
WHERE A.name = H.name 
ORDER BY name
) AS D,
(SELECT A.name as name,(H+A) as molecular FROM
(SELECT 
    L.name,COUNT(M.id) AS H  
FROM 
    match_info M,
    league L 
WHERE 
    season = '2015/2016' 
AND
    M.league_id = L.id 
AND 
((home_team_score > away_team_score)
AND(
    (
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_1 AND M.home_player_1 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_2 AND M.home_player_2 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_3 AND M.home_player_3 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_4 AND M.home_player_4 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_5 AND M.home_player_5 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_6 AND M.home_player_6 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_7 AND M.home_player_7 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_8 AND M.home_player_8 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_9 AND M.home_player_9 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_10 AND M.home_player_10 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.home_player_11 AND M.home_player_11 IS NOT NULL) 
    ) > 1980 
) )
GROUP BY L.name) AS H,
(SELECT 
    L.name,COUNT(M.id) AS A  
FROM 
    match_info M,
    league L 
WHERE 
    season = '2015/2016' 
AND
    M.league_id = L.id 
AND 
((home_team_score < away_team_score)
AND(
    (
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_1 AND M.away_player_1 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_2 AND M.away_player_2 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_3 AND M.away_player_3 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_4 AND M.away_player_4 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_5 AND M.away_player_5 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_6 AND M.away_player_6 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_7 AND M.away_player_7 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_8 AND M.away_player_8 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_9 AND M.away_player_9 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_10 AND M.away_player_10 IS NOT NULL) +
    (SELECT height FROM player P WHERE P.player_api_id = M.away_player_11 AND M.away_player_11 IS NOT NULL) 
    ) > 1980 
) )
GROUP BY L.name) AS A 
WHERE A.name = H.name 
ORDER BY name
) AS M 
WHERE 
D.name = M.name 
ORDER BY D.name;

