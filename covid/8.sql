SELECT END.name as name,(SUM(END.Hwin)+SUM(END.Awin))/(SUM(END.Htall)+SUM(END.Atall)) as prob FROM (SELECT L.name AS name,(FIANL.Hwin*FIANL.Htall) as Hwin,FIANL.Htall,(FIANL.Awin*FIANL.Atall) as Awin,FIANL.Atall FROM 
(SELECT H.team as Hteam,H.win as Hwin,((H.height/H.person) > 180) as Htall,A.team as Ateam,A.win as Awin,((A.height/A.person) > 180) as Atall FROM 
(SELECT Height.id,Height.team,Height.win,Height.sum as height,Person.sum as person FROM 
(SELECT 
    M.id as id,
    M.league_id as team,
    (M.home_team_score>M.away_team_score) as win,
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
WHERE Person.id = Height.id) AS H,
(SELECT Height.id,Height.team,Height.win,Height.sum as height,Person.sum as person FROM 
(SELECT 
    M.id as id,
    M.league_id as team,
    (M.away_team_score>M.home_team_score) as win,
    (IFNULL(P1.height, 0)+IFNULL(P2.height, 0)+IFNULL(P3.height, 0)+IFNULL(P4.height, 0)+IFNULL(P5.height, 0)+IFNULL(P6.height, 0)+IFNULL(P7.height, 0)+IFNULL(P8.height, 0)+IFNULL(P9.height, 0)+IFNULL(P10.height, 0)+IFNULL(P11.height, 0)) AS sum
FROM 
    match_info M
LEFT JOIN player P1 ON M.away_player_1 = P1.player_api_id  
LEFT JOIN player P2 ON M.away_player_2 = P2.player_api_id  
LEFT JOIN player P3 ON M.away_player_3 = P3.player_api_id  
LEFT JOIN player P4 ON M.away_player_4 = P4.player_api_id  
LEFT JOIN player P5 ON M.away_player_5 = P5.player_api_id  
LEFT JOIN player P6 ON M.away_player_6 = P6.player_api_id  
LEFT JOIN player P7 ON M.away_player_7 = P7.player_api_id  
LEFT JOIN player P8 ON M.away_player_8 = P8.player_api_id  
LEFT JOIN player P9 ON M.away_player_9 = P9.player_api_id  
LEFT JOIN player P10 ON M.away_player_10 = P10.player_api_id  
LEFT JOIN player P11 ON M.away_player_11 = P11.player_api_id  
WHERE season = '2015/2016') AS Height,
(SELECT a.id as id,(a.c1+a.c2+a.c3+a.c4+a.c5+a.c6+a.c7+a.c8+a.c9+a.c10+a.c11) as sum FROM (select id,
case when away_player_1 is NULL then 0 when away_player_1 is not NULL then 1 END AS c1,
case when away_player_2 is NULL then 0 when away_player_2 is not NULL then 1 END AS c2,
case when away_player_3 is NULL then 0 when away_player_3 is not NULL then 1 END AS c3,
case when away_player_4 is NULL then 0 when away_player_4 is not NULL then 1 END AS c4,
case when away_player_5 is NULL then 0 when away_player_5 is not NULL then 1 END AS c5,
case when away_player_6 is NULL then 0 when away_player_6 is not NULL then 1 END AS c6,
case when away_player_7 is NULL then 0 when away_player_7 is not NULL then 1 END AS c7,
case when away_player_8 is NULL then 0 when away_player_8 is not NULL then 1 END AS c8,
case when away_player_9 is NULL then 0 when away_player_9 is not NULL then 1 END AS c9,
case when away_player_10 is NULL then 0 when away_player_10 is not NULL then 1 END AS c10,
case when away_player_11 is NULL then 0 when away_player_11 is not NULL then 1 END AS c11 
FROM match_info WHERE season = '2015/2016') as a) AS Person 
WHERE Person.id = Height.id) AS A WHERE A.id = H.id) AS FIANL LEFT JOIN league L ON L.id = FIANL.Hteam) AS END GROUP BY END.name;