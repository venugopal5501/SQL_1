USE SOCCER_DB
GO

-- 1. Write a query in SQL to find the teams played the first match of EURO cup 2016.  
--( match_details, soccer_country)
select * from match_details
select * from soccer_country
select country_name from  soccer_country where country_id  in (  select team_id from match_details where match_no=1)


--2. Write a query in SQL to find the winner of EURO cup 2016. (soccer_country, match_details)
select * from match_details
select * from soccer_country
select country_name from  soccer_country where country_id  in(select team_id from match_details where play_stage='f' and win_lose='w')



--3. Write a query in SQL to find the match with match no, play stage, goal scored, and the 
--audence which was the heighest audence match. (match_mast)
select * from match_mast
select match_no,play_stage ,goal_score ,audence from match_mast where audence =(select max(audence) from match_mast)

--4. Write a query in SQL to find the match no in which Germany played against 
--Poland(match_details, soccer_country)
select * from match_details
select * from soccer_country
select match_no from match_details where team_id in (select country_id from soccer_country where country_name in  ('Germany','Poland')) group by match_no having count( match_no) =2


--5. Write a query in SQL to find the match no, play stage, date of match, number of gole scored, 
-- and the result of the match where Portugal played against Hungary. 
--(match_mast, match_details, soccer_country)
select * from match_mast
select * from match_details
select * from soccer_country


select match_no, play_stage, play_date,  goal_score, results from match_mast where match_no in (select match_no from match_details where team_id in
(select country_id from soccer_country where country_name in  ('Portugal','Hungary') ) group by match_no having count(match_no)=2)

--------------6. Write a query in SQL to display the list of players scored number of goals in every 
-- matches(goal_details, soccer_country, player_mast)
select * from goal_details
select * from soccer_country
select * from player_mast
select p.player_name,g.match_no  ,count(g.player_id)  from player_mast p ,goal_details g where p.player_id=g.player_id
group by p.player_name,g.match_no,g.team_id,g.player_id order by g.match_no 

--------------------------------or------------------------------------

select  ( select p.player_name  from player_mast p where p.player_id=g.player_id ), g.match_no , count(g.goal_id) as no_of_goals  from goal_details g  group by g.match_no,g.player_id order by g.match_no

------------------------------OR-----------------------------
select p.player_name,g.match_no, (select count(gd.goal_id) from goal_details gd where gd.match_no=g.match_no and gd.player_id=g.player_id) as total_goal from goal_details g 
join player_mast p on g.player_id=p.player_id group by p.player_name,g.match_no, g.player_id  order by g.match_no



--7.write a SQL query to find the highest audience match. Return country name of the teams
--(soccer_country, goal_details, match_mast)
select * from goal_details
select * from soccer_country
select * from match_mast
select country_name  from soccer_country where country_id in (  select distinct  team_id from goal_details where match_no in (select match_no from match_mast where audence =(select max(audence) from match_mast)))






--8. write a SQL query to find the player who scored the last goal for Portugal against Hungary. 
-- Return player name.(player_mast, goal_details, match_details, soccer_country)
select * from player_mast
select * from goal_details
select * from match_details
select * from soccer_country
 select player_name  from  player_mast where player_id in  (select top 1 player_id  from  goal_details where match_no in ( select match_no from match_details where team_id in 
 (select country_id from soccer_country where country_name in ('Portugal ','Hungary')) group by match_no having count(match_no)=2) group by player_id ,goal_time order by goal_time desc)



--9. Write a query in SQL to find the 2nd highest stoppage time which had been added in 2nd half 
-- of play. (match_mast)
select * from match_mast
select min (stop2_sec) from match_mast where stop2_sec in( select top 2 stop2_sec from match_mast order by stop2_sec desc)





--10. Write a query in SQL to find the teams played the match where 2nd highest stoppage time had 
-- been added in 2nd half of play. (soccer_country, match_details, match_mast)

select * from soccer_country
select * from match_details
select * from match_mast
select country_name from soccer_country where country_id in ( select team_id from  match_details   where match_no in ( select match_no from  match_mast where stop2_sec in ( select min (stop2_sec) from match_mast where stop2_sec in( select top 2 stop2_sec from match_mast order by stop2_sec desc))))





--11. Write a query in SQL to find the match no, date of play and the 2nd highest stoppage time 
-- which have been added in the 2nd half of play.(match_mast)
select * from match_mast
select match_no ,play_date,stop2_sec  FROM	MATCH_MAST WHERE stop2_sec in ( select min (stop2_sec) from match_mast where stop2_sec in( select top 2 stop2_sec from match_mast order by stop2_sec desc))







--12. write a SQL query to find the team, which was defeated by Portugal in EURO cup 2016 final.  
-- Return the country name of the team.(soccer_country, match_details)

select * from soccer_country
select * from match_details
select country_name   from soccer_country where country_id in (select team_id from match_details where win_lose='l' and match_no in ( select match_no from  match_details where win_lose ='w' and play_stage='f' and team_id in (   select country_id from soccer_country where country_name in ('Portugal'))))



-***********************-13. Write a query in SQL to find the club which supplied the most number of players to the 2016 
-- EURO cup. (player_mast)
select * from player_mast
select top 2 count(playing_club) as many  ,playing_club from player_mast group by playing_club order by many desc
                                            --or--


--14. Write a query in SQL to find the player and his jersey number Who scored the first penalty 
-- of the tournament. (player_mast, goal_details)
select * from player_mast
select * from goal_details
select player_name, jersey_no  from  player_mast where  player_id =(   select top 1 player_id from goal_details where goal_type='p' )



-****-15. Write a query in SQL to find the player along with his team and jersey number who scored 
-- the first penalty of the tournament (player_mast, goal_details, soccer_country)
select * from player_mast
select * from goal_details
select * from Soccer_Country 


select  distinct p.player_name ,s.country_name,p.jersey_no from  player_mast p,Soccer_Country s ,goal_details g 
where p.player_id=g.player_id and g.team_id=s.country_id and  p.player_id in
( select top 1 g.player_id from goal_details g where goal_type='p')




                     




--16. Write a query in SQL to find the player who was the goalkeeper for Italy in penalty 
-- shootout against Germany in Football EURO cup 2016. (player_mast, penalty_gk, soccer_country)
select * from player_mast
select * from penalty_gk
select * from Soccer_Country 
select * from playing_position
 select player_name from player_mast where player_id in ( select p.player_gk from penalty_gk p,Soccer_Country s   where p.team_id=s.country_id and   s.country_name ='Italy' and  p.match_no in (  select  p.match_no  from penalty_gk p  where  p.team_id in (  select s.country_id from Soccer_Country s  where s.country_name in ('Italy','Germany') )))

--17. Write a query in SQL to find the number of Germany scored at the tournament. 
--(goal_details, soccer_country)
select * from goal_details
select * from soccer_country

select count(team_id) from goal_details where team_id in ( select country_id from Soccer_Country where country_name='Germany')



--18. Write a query in SQL to find the players along with their jersey no., and playing club, who 
-- were the goalkeepers for the England squad for 2016 EURO cup. (player_mast, soccer_country)
select * from player_mast
select * from soccer_country

select jersey_no ,playing_club,player_name from player_mast where posi_to_play='gk' and team_id =( select country_id from soccer_country where country_name='England')


--19. Write a query in SQL to find the players with other information under contract to Liverpool 
-- were in the Squad of England in 2016 EURO cup.  (player_mast, soccer_country)
select * from player_mast
select * from soccer_country
 select * from player_mast where playing_club = 'Liverpool' and team_id =(select country_id from soccer_country where country_name='England' )


--20. Write a query in SQL to find the player with other infromation Who scored the last goal in 
-- the 2nd semi final i.e. 50th match in EURO cub 2016.(player_mast, goal_details, soccer_country)
select * from player_mast
select * from goal_details
select * from soccer_country
 select * from player_mast where  player_id in ( select player_id from goal_details where play_stage='s' group by play_stage ,player_id,match_no having max(goal_time)in (select goal_time from goal_details where play_stage='s') and match_no=
(select max(match_no) from goal_details where play_stage='s'))


--21. Write a query in SQL to find the player Who was the captain of the EURO cup 2016 winning 
-- team from Portugal. (player_mast, match_captain, match_details)
select * from match_captain
select * from match_details
select * from goal_details
select * from Soccer_Country
select * from player_mast

select player_name from player_mast where player_id in ( select  player_captain from match_captain where team_id  =(select country_id from Soccer_Country where country_name='Portugal'))




--------------22. Write a query in SQL to find the number of players played for france in the final. 
--(player_in_out, match_mast, soccer_country)
select * from player_in_out
select * from match_mast
select * from soccer_country
select * from player_mast


select count( player_id )+11 from player_in_out  where in_out='o' and  team_id in ( select country_id from Soccer_Country where country_name='france') 
and match_no=(select max(match_no) from player_in_out )






--23. Write a query in SQL to find the goalkeeper of the team Germany who didn't concede any goal 
--in their group stage matches.  (player_mast, match_details, soccer_country)

select * from player_mast
select * from match_details
select * from soccer_country


select player_name from player_mast where player_id in ( select distinct m.player_gk from match_details m where match_no in (select m.match_no from match_details m where play_stage='g' and  team_id in (  select s.country_id from Soccer_Country s where s.country_name='Germany')) 
and win_lose='w' and player_gk in (select player_gk from match_details where goal_score=0 ))


--24. Write a query in SQL to find the runners-up in Football EURO cup 2016.  
--(match_details, soccer_country)
select * from match_details
select * from soccer_country

select country_name from soccer_country where country_id in ( select team_id from match_details where play_stage='f' and win_lose='l')



---------------25. Write a query in SQL to find the maximum penalty shots taken by the teams.  
--(soccer_country, penalty_shootout)
select * from soccer_country
select * from penalty_shootout

select country_name from soccer_country where country_id in (  select team_id  from penalty_shootout group by team_id having count(player_id) in  (select max(high) from ( (select count(player_id) as high  from penalty_shootout group by team_id)) as laa))






--26. Write a query in SQL to find the maximum number of penalty shots taken by the players.  
--(player_mast, penalty_shootout, soccer_country)
select * from player_mast
select * from penalty_shootout
select * from soccer_country
select player_name from player_mast where player_id in (select player_id from penalty_shootout group by player_id having count(player_id) in (select max (high) from (select count(player_id) as high from penalty_shootout group by player_id ) as dd))




--27. Write a query in SQL to find the match no. where highest number of penalty shots taken.  
--(penalty_shootout)

select * from penalty_shootout
select match_no from penalty_shootout group by match_no having count(match_no) =(select max(high) from (( select count(match_no)  as high from penalty_shootout group by match_no )) as dd)


--28. Write a query in SQL to find the match no. and teams who played the match where highest 
-- number of penalty shots had been taken.  (penalty_shootout)

select * from penalty_shootout
select match_no ,team_id from penalty_shootout group by match_no,team_id having count(match_no) =(select max ( high) from ((select count(match_no) as high from penalty_shootout   group by match_no,team_id))as  dd ) 
and count(team_id) =(select max ( high) from ((select count(team_id) as high from penalty_shootout   group by match_no,team_id))as sss )




--------------------29. Write a query in SQL to find the player of portugal who taken the 7th kick against poland.  
-- (penalty_shootout, soccer_country)

select * from penalty_shootout
select * from soccer_country
select * from player_mast



select player_name from player_mast where player_id in ( select player_id from penalty_shootout where kick_no=7 and match_no in ( select match_no from penalty_shootout where   team_id in  (select country_id from Soccer_Country where country_name in ('portugal'))intersect
  select match_no from penalty_shootout where   team_id in  (select country_id from Soccer_Country where country_name in ('poland'))))





--30. Write a query in SQL to find the stage of match where the penalty kick number 23 had been 
-- taken.  (match_mast, penalty_shootout)
select * from match_mast
select * from penalty_shootout
select play_stage from match_mast  where match_no in  (select match_no from penalty_shootout where kick_id=23)





--31. Write a query in SQL to find the venues where penalty shootout matches played. 
--(soccer_venue, match_mast, penalty_shootout)
select * from soccer_venue
select * from match_mast
select * from penalty_shootout

 select venue_name from soccer_venue where venue_id in (  select venue_id from  match_mast  where decided_by ='p' and match_no in   (select match_no from penalty_shootout))







--32. Write a query in SQL to find the date when penalty shootout matches played.  
-- (match_mast, penalty_shootout)
select * from match_mast
select * from penalty_shootout
select distinct  p.match_no ,m.play_date from match_mast m,penalty_shootout p where m.match_no=p.match_no  


--33. Write a query in SQL to find the most quickest goal at the EURO cup 2016, after 5 minutes.  
--(goal_details)
	select * from goal_details
select goal_id,goal_time from goal_details where goal_time =(select min (goal_time ) from goal_details where goal_time >5)