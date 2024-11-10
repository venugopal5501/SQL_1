USE SOCCER_DB
GO
select * from Soccer_Country;
--1. Write a query in SQL to find the number of venues for EURO cup 2016. (soccer_venue)

select * from soccer_city;
select * from soccer_country;    
select * from soccer_venue
select count(venue_id) from soccer_venue 

--2. Write a query in SQL to find the number OF countries participated in the EURO cup 2016. 
--(player_mast)
select * from soccer_country;  
select count(country_id) from soccer_country
--3. Write a query in SQL to find the number goals scored in EURO cup 2016
-- within normal play schedule.(goal_details)

select * from goal_details
select count(goal_id) as no_of_goals from goal_details

-- 4. Write a query in SQL to find the number of matches ended with a result. (match_mast)

select * from match_mast
select count(results) as no_of_match_has_result from match_mast where results='win'

-- 5. Write a query in SQL to find the number of matches ended with draws.(match_mast)
select count(results) as no_of_match_has_draw from match_mast where results='draw'



-- 6. Write a query in SQL to find the date when did Football EURO cup 2016 begin.(match_mast)
select * from match_mast
select top 1 play_date from match_mast


-- 7. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.( goal_details)
select * from goal_details
select count(goal_type) from goal_details where goal_type='o'

-- 8. Write a query in SQL to count the 'number' of matches ended with a 'results' 
--in 'group stage'. (match_mast)
select * from match_mast
select count(results) as no_of_match_has_results from match_mast where results='win'




--  9. Write a query in SQL to find the 'number' of matches got a result by penalty shootout. --(penalty_shootout)
select * from penalty_shootout
select * from match_mast
select count(match_no) as count from match_mast where decided_by='p' and results='win'



-- 10. Write a query in SQL to find the number of matches were decided on penalties
-- decided on penalties in the Round of 16. (match_mast)
select count(match_no) from match_mast where decided_by='p' and play_stage='R'


-- 11. Write a query in SQL to find the number of goal scored (COUNT (*)) ,  in every match 
--(match_no) within normal play schedule. (goal_details)
SELECT * FROM goal_details
SELECT count(goal_id),match_no from goal_details  where goal_schedule='nt' group by match_no

-- 12. Write a query in SQL to find the match no, date of play, and goal scored for that match
-- in which no stoppage time have been added in 1st half of play. 
SELECT * FROM goal_details
select * from match_mast
select match_no,play_date,goal_score from match_mast where stop1_sec=0



-- 13. Write a query in SQL to find the number of matches
-- ending with a goalless draw in group stage of play. (match_details)
select * from match_details
select count(match_no) from match_details where win_lose='d' and goal_score=0 and play_stage='g'


-- 14. Write a query in SQL to find the number of matches ending with only one goal
-- win except those matches which were decided by penalty shootout.(match_details)
select * from match_details
select count (*) from (select match_no from match_details where goal_score =1 and win_lose='w' except select match_no from match_details where decided_by='p') as dd


-- 15. Write a query in SQL to find the total number of players
-- replaced in the tournament. (player_in_out)

select * from player_in_out
select count(match_no) from player_in_out where in_out='o'

-- 16. Write a query in SQL to find the total number of palyers replaced
-- within normal time of play.(player_in_out)
select * from player_in_out
select count(match_no) from player_in_out where in_out='o' and play_schedule='nt'



-- 17. Write a query in SQL to find the number of players
-- replaced in the stoppage time. (player_in_out)
select count(match_no) from player_in_out where in_out='o' and play_schedule='st'
	


-- 18. Write a query in SQL to find the total number of players replaced
-- in the first half of play. (player_in_out)
select count(match_no) from player_in_out where in_out='o' and play_half=1
select * from player_in_out



-- 19. Write a query in SQL to find  the total number of goalless draws
-- have there in the entire tournament. (match_details)
/*	THERE ARE 2 TEAMS FOR THE SAME RESULT */
select * from match_details
 select count(distinct match_no) from match_details where goal_score=0 and win_lose='d' 
 


  select count(match_no) from match_details where goal_score=0 and win_lose='d' group by match_no


--	20. Write a query in SQL to find the total number of players replaced
-- in the extra time of play. (player_in_out)

select count(match_no) from player_in_out where in_out='o' and play_schedule='et'


-- 21. Write a query in SQL to compute a list to show the number of substitute happened 
-- in various stage of play for the entire tournament. (player_in_out)
	select * from player_in_out
select count(in_out) ,play_schedule  from player_in_out where in_out='o' group by play_schedule
exec sp_help player_in_out

-- 22. Write a query in SQL to find the number of shots taken in penalty 
-- shootout matches.(penalty_shootout)
select * from penalty_shootout
select count(kick_no) from penalty_shootout


-- 23. Write a query in SQL to find the number of shots socred goal 
-- in penalty shootout matches. (penalty_shootout)
	select * from penalty_shootout
	select count(score_goal) from penalty_shootout where score_goal='y'


-- 24. Write a query in SQL to find the number of shots missed or saved in 
-- penalty shootout matches. (penalty_shootout)
	select * from penalty_shootout
	select count(score_goal) from penalty_shootout where score_goal='n'



-- 25. Write a query in SQL to prepare a list of players with number of shots they taken in 
-- penalty shootout matches. (Sample table: soccer_country, penalty_shootout, player_mast)
	select * from penalty_shootout
select * from Soccer_Country
select * from player_mast
select pla.player_name,count(pen.player_id) from player_mast pla join penalty_shootout pen on pen.player_id=pla.player_id group by pen.player_id,pla.player_name

-- 26. Write a query in SQL to find the number of penalty shots taken by the teams. 
--(soccer_country, penalty_shootout)
	select * from Soccer_Country
	select * from penalty_shootout
	select count(kick_no),team_id from penalty_shootout group by team_id

-- 27. Write a query in SQL to find the number of booking happened in each half of play 
-- within normal play schedule. (player_booked)
	select * from player_booked
	select count(booking_time)as  number_of_booking ,play_half from player_booked where play_schedule='nt' group by   play_half


-- 28. Write a query in SQL to find the number of booking happened in stoppage time. 
-- (player_booked)
		select * from player_booked
			select count(booking_time)as  number_of_booking from player_booked where play_schedule='st' 




-- 29. Write a query in SQL to find the number of booking happened in extra time. (player_booked)
		select * from player_booked
					select count(booking_time)as  number_of_booking from player_booked where play_schedule='et' 


