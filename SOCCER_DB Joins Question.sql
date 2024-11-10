USE SOCCER_DB
GO

--1. Write a query in SQL to find the name of the venue with city where the EURO cup 2016 final -- match was played. (soccer_venue, soccer_city, match_mast)

select * from soccer_venue
select * from soccer_city
select * from match_mast

select s.venue_name ,ss.city from soccer_venue s join soccer_city ss on s.city_id=ss.city_id join match_mast m on s.venue_id=m.venue_id where m.play_stage='f'

--2. Write a query in SQL to find the number of goal scored by each team in every match within 
-- normal play schedule.  (match_details, soccer_country)

select * from match_details
select * from soccer_country
select m.goal_score ,s.country_name,m.match_no from match_details m join soccer_country s on m.team_id=s.country_id  where m.decided_by='n'  

--3. Write a query in SQL to find the total number of goals scored by each player within normal 
-- play schedule and arrange the result set according to the heighest to lowest scorer.  
-- (goal_details, player_mast, soccer_country)
select * from goal_details
select * from player_mast
select * from soccer_country
select p.player_name ,count(g.player_id) as many  from goal_details g join player_mast p on g.player_id=p.player_id where g.goal_type='n' group by g.player_id ,p.player_name order by many desc




--4. Write a query in SQL to find the highest individual scorer in EURO cup 2016. 
-- (goal_details, player_mast, soccer_country) 
select * from goal_details
select * from player_mast
select * from soccer_country


select p.player_name from player_mast p  join   goal_details g on g.player_id=p.player_id group by g.player_id ,p.player_name having count(g.player_id) =(select max(many) from (select count(player_id) as many from goal_details group by player_id)as ff)



--5. Write a query in SQL to find the scorer of only goal along with 
-- his country and jersey number in the final of EURO cup 2016.  
--(goal_details,, player_mast,  soccer_country)
select * from goal_details
select * from player_mast
select * from soccer_country
select p.player_name ,s.country_name,p.jersey_no from soccer_country s join player_mast p on s.country_id=p.team_id  join goal_details g on g.player_id=p.player_id group by p.player_name ,s.country_name,p.jersey_no, g.play_stage
having count (g.player_id) =1 and g.play_stage='f'




--6. Write a query in SQL to find the country where Football EURO cup 2016 held.  
-- (soccer_country, soccer_city, soccer_venue)
select * from soccer_country
select * from soccer_city
select * from soccer_venue
select distinct c.country_name  from  soccer_country c join soccer_city cc on c.country_id =cc.country_id join soccer_venue v on cc.city_id=v.city_id



--7. Write a query in SQL to find the player who socred first goal of EURO cup 2016.  
-- (soccer_country, player_mast, goal_details)
select * from soccer_country
select * from player_mast
select * from goal_details

select p.player_name from player_mast p join goal_details g on  p.player_id=g.player_id where goal_id=1



--8. Write a query in SQL to find the name and country of the referee who managed the opening 
-- match.  (soccer_country, match_mast, referee_mast)
select * from soccer_country
select * from match_mast
select * from referee_mast
select r.referee_name ,s.country_name from soccer_country s join referee_mast r on s.country_id=r.country_id join match_mast m on m.referee_id=r.referee_id where match_no=1



--9. Write a query in SQL to find the name and country of the referee who managed the final 
-- match.  (soccer_country, match_mast, referee_mast)

select * from soccer_country
select * from match_mast
select * from referee_mast
select r.referee_name ,s.country_name from soccer_country s join referee_mast r on s.country_id=r.country_id join match_mast m on m.referee_id=r.referee_id where match_no=(select max(match_no) from match_mast)



--10. Write a query in SQL to find the name and country of the referee who assisted the referee 
-- in the opening match.  (asst_referee_mast, soccer_country, match_details)
select * from asst_referee_mast
select * from soccer_country
select * from match_details
select a.ass_ref_name ,s.country_name from asst_referee_mast a join soccer_country s on a.country_id=s.country_id join match_details m on a.ass_ref_id=m.ass_ref where m.match_no =1


--11. Write a query in SQL to find the name and country of the referee who assisted the referee 
-- in the final match.  (asst_referee_mast, soccer_country, match_details)
select * from asst_referee_mast
select * from soccer_country
select * from match_details
select a.ass_ref_name ,s.country_name from asst_referee_mast a join soccer_country s on a.country_id=s.country_id join match_details m on a.ass_ref_id=m.ass_ref where m.match_no in ( select max (match_no ) from match_details)




--12. Write a query in SQL to find the city where the opening match of EURO cup 2016 played.  
--(soccer_venue, soccer_city, match_mast)
select * from soccer_venue
select * from soccer_city
select * from match_mast

select c.city from soccer_city c join soccer_venue v on c.city_id=v.city_id join match_mast m on v.venue_id=m.venue_id where m.match_no=1



--13. Write a query in SQL to find the stadium hosted the final match of EURO cup 2016 along with 
-- the capacity, and audance for that match.  (soccer_venue, soccer_city, match_mast)

select * from soccer_venue 
select * from soccer_city
select * from match_mast
select v.venue_name,v.aud_capacity ,m.audence from soccer_venue v join match_mast m on v.venue_id=m.venue_id where match_no =(select max (match_no ) from match_mast)



--14. Write a query in SQL to compute a report that contain the number of matches played in each 
-- venue along with their city.  (soccer_venue, soccer_city, match_mast)
select * from soccer_venue 
select * from soccer_city
select * from match_mast
select v.venue_name ,c.city ,count(m.match_no) from soccer_venue v join soccer_city c on v.city_id=c.city_id join match_mast m on v.venue_id=m.venue_id group by m.venue_id,v.venue_name ,c.city



--15. Write a query in SQL to find the player who was the first player to be sent off at the 
-- tournament EURO cup 2016.  ( player_booked, player_mast, soccer_country)
select * from player_booked
select * from player_mast
select * from soccer_country
select m.player_name from player_mast m join player_booked b on m.player_id=b.player_id where b.player_id = ( select top 1 player_id from player_booked  where sent_off ='y')



--16. Write a query in SQL to find the teams that scored only one goal to the torunament.  
--(soccer_team, soccer_country)
select * from soccer_team
select * from soccer_country
select c.country_name from soccer_country c join soccer_team t on c.country_id=t.team_id where  t.goal_for=1



------------------17. Write a query in SQL to find the yellow cards received by each country. 
--(soccer_country, player_booked)
select * from soccer_country
select * from player_booked

select s.country_name ,count(p.player_id) from soccer_country s join player_booked p on s.country_id=p.team_id  group by s.country_name

--18. Write a query in SQL to find the venue with number of goals that has seen. 
-- (soccer_country, goal_details, match_mast, soccer_venue)
select * from goal_details
select * from soccer_country
select * from match_mast
select * from soccer_venue


select  v.venue_name ,count(d.match_no) as high  from soccer_venue v join match_mast m on m.venue_id=v.venue_id  
join goal_details d on d.match_no=m.match_no group by v.venue_name



select s.venue_name  ,count(s.venue_name) as tot_no_goals from goal_details g join Soccer_Country on team_id=country_id join match_mast m on m.match_no=g.match_no join soccer_venue s 
on s.venue_id=m.venue_id group by s.venue_name order by tot_no_goals desc



--19. Write a query in SQL to find the match where no stoppage time added in 1st half of play. 
-- (match_details, match_mast, soccer_country)
select * from match_details 
select * from match_mast
select * from soccer_country 

select match_no from match_mast where stop1_sec=0






--20. Write a query in SQL to find the team(s) who conceded the most goals in EURO cup 2016. 
-- (soccer_team, soccer_country)
select * from soccer_team
select * from soccer_country 
select c.country_name ,t.team_id from soccer_country c join soccer_team t on t.team_id=c.country_id where goal_agnst=(select max(goal_agnst) from soccer_team)


--21. Write a query in SQL to find the match where highest stoppege time added in 2nd half of 
-- play. (match_details, match_mast, soccer_country)
select match_no from match_mast where stop2_sec=(select max ( stop2_sec) from  match_mast)


--22. Write a query in SQL to find the matchs ending with a goalless draw in group stage of play. 
--(match_details, soccer_country)
select * from match_details
select * from soccer_country

select c.country_name,d.match_no from soccer_country c join match_details d on d.team_id=c.country_id where  goal_score=0 and play_stage='g' and win_lose='d'

--23. Write a query in SQL to find the match no. and the teams played in that match where the 2nd 
-- highest stoppage time had been added in the 2nd half of play. 
--(match_mast, match_details, soccer_country)
select * from match_mast
select * from  match_details
select * from soccer_country
select m.match_no,c.country_name ,m.stop2_sec from soccer_country c join match_details d on c.country_id=d.team_id join match_mast m on m.match_no=d.match_no where m.stop2_sec=( select min(laa) from ( (select top 2 stop2_sec as laa from match_mast order by stop2_sec desc )) as ff)


--24. Write a query in SQL to find the player and his team and how many matches he kept goal for 
-- his team.  (player_mast, match_details, soccer_country)
select * from player_mast
select * from match_details
select * from  soccer_country

select c.country_name ,m.player_name ,count(d.match_no ) from soccer_country c join player_mast m on c.country_id=m.team_id join match_details d on m.player_id=d.player_gk  group by d.player_gk,c.country_name,m.player_name 






--25. Write a query in SQL to find the venue that has seen the most goals.  
-- (goal_details, soccer_country, match_mast, soccer_venue)
select * from goal_details
select * from match_mast
select * from soccer_venue
select top 1 v.venue_name,count(d.match_no) as goal from soccer_venue v join match_mast m on v.venue_id=m.venue_id join goal_details d on m.match_no=d.match_no group by  v.venue_name order by goal desc
--26. Write a query in SQL to find the oldest player to have appeared in a EURO cup 2016 match.  
--(player_mast, soccer_country)
select * from player_mast
select * from soccer_country
select s.country_name ,p.player_name from soccer_country s join player_mast p on s.country_id=p.team_id where age =( select max(age ) from player_mast)



--27. Write a query in SQL to find those two teams which scored three goals in a single game at 
-- this tournament.  (match_details, soccer_country)
select * from match_details
select * from soccer_country

select s.country_name,m.match_no from soccer_country s join match_details m on s.country_id=m.team_id where m.goal_score=3
and m.match_no =(select match_no from  match_details where goal_score=3 group by match_no having count(match_no) =2)  group by m.match_no , s.country_name 



-----------------28. Write a query in SQL to find the teams with other information that finished bottom of their --
-----respective groups scored  four goals in three games.  (soccer_team, soccer_country)
select * from soccer_team
select * from soccer_country
select c.country_name ,t.team_id ,t.team_group from soccer_country c join soccer_team t on t.team_id=c.country_id where t.group_position=(select max(group_position) from Soccer_team)
and t.won=0 and t.goal_agnst=4



--29. Write a query in SQL to find those three players with other information, who contracted to 
-- Lyon participated in the EURO cup 2016 Finals.  (player_mast, soccer_country, match_details)
select * from player_mast
select * from soccer_country
select * from match_details
select player_id from player_mast where playing_club='Lyon'

select p.player_name ,s.country_name from soccer_country s join match_details m on m.team_id=s.country_id join player_mast p on p.team_id=m.team_id
where p.playing_club='Lyon' and m.play_stage='f'





--30. Write a query in SQL to find the final four teams in the tournament.  
-- (soccer_country, match_details)
select * from soccer_country
select * from match_details
select s.country_name from soccer_country s join match_details m on s.country_id=m.team_id where match_no in (select top 4 match_no from match_details order by match_no desc )


-----------------31. Write a query in SQL to find the captains for the top four teams with other information 
-- which participated in the semifinals (match 48 and 49) in the tournament. 
-- (soccer_country, match_captain, player_mast)
select * from match_captain
select * from player_mast
select m.player_captain ,p.jersey_no ,p.playing_club from match_captain m inner join player_mast p on m.player_captain=p.player_id where m.match_no in (48,49)


--32. Write a query in SQL to find the captains with other information for all the matches in the 
-- tournament.  (soccer_country, match_captain, player_mast)

select * from soccer_country 
select * from match_captain
select * from player_mast
select s.country_name ,p.player_name,p.jersey_no  from soccer_country s join match_captain m on s.country_id=m.team_id  join player_mast p  on m.team_id=p.team_id and m.player_captain=p.player_id 



-----****(((((((NOT NEEDED)))))))))****-33. Write a query in SQL to find the captain and goal keeper with other information for all the 
-- matches for all the team.  (soccer_country, match_captain, match_details, player_mast)
select * from soccer_country
select * from match_captain
select * from player_mast
select * from match_details
select (select cp.player_name  from match_captain m join player_mast cp on cp.team_id=m.team_id and cp.player_id=m.player_captain ),gk.player_name from 
 player_mast gk  join match_details d on d.player_gk=gk.player_id


select cp.player_name ,gk.player_name from match_captain m join player_mast cp on cp.team_id=m.team_id and cp.player_id=m.player_captain 
join player_mast gk on gk.player_id=cp.player_id inner join match_details d on d.player_gk=gk.player_id



select cp.player_name ,gk.player_name from match_captain m join player_mast cp on cp.team_id=m.team_id and cp.player_id=m.player_captain join player_mast gk on gk.player_id=cp.player_id  where gk.posi_to_play='gk'

--34. Write a query in SQL to find the player who was selected for the Man of the Match Award in -- the finals of EURO cup 2016.  (soccer_country, match_mast, player_mast)
select * from soccer_country
select * from match_mast
select * from player_mast
select s.country_name ,p.player_name from soccer_country s join player_mast p on p.team_id=s.country_id inner join match_mast m on m.plr_of_match=p.player_id where m.play_stage='f'


--35. Write a query in SQL to find the substitute players who came into the field in the first 
-- half of play within normal play schedule.  (player_in_out, player_mast, soccer_country)
select * from player_in_out
select * from player_mast
select * from soccer_country
select pp.player_name from player_mast pp join player_in_out p on p.player_id=pp.player_id where p.in_out='i' and p.play_schedule='nt' and play_half=1



--36. Write a query in SQL to prepare a list for the player of the match against each match.  
--(match_mast, player_mast, soccer_country)
select * from match_mast
select * from player_mast
select * from soccer_country
select s.country_name ,m.match_no ,p.player_name from soccer_country s join player_mast p on p.team_id=s.country_id  inner join 
match_mast m on m.plr_of_match=p.player_id 

--37. Write a query in SQL to find the player along with his country who taken the penalty shot number 26.  (penalty_shootout, player_mast, soccer_country)
select * from penalty_shootout
select * from player_mast
select * from soccer_country
select s.country_name ,p.player_name from soccer_country s join player_mast p on p.team_id=s.country_id join
penalty_shootout pp on pp.player_id=p.player_id where pp.kick_id=26




--38. Write a query in SQL to find the team against which the penalty shot number 26 had been taken. (penalty_shootout, soccer_country)
select * from penalty_shootout
select * from soccer_country

  select distinct  s.country_name from soccer_country s join penalty_shootout p on p.team_id=s.country_id and p.team_id in ( select distinct team_id from penalty_shootout where match_no =(select match_no from penalty_shootout where kick_id=26) and team_id !=
 ( select team_id from penalty_shootout where kick_id =26 and match_no = (select match_no from penalty_shootout where kick_id=26)))


--39. Write a query in SQL to find the captain who was also the goalkeeper. (match_captain, soccer_country, player_mast)
select * from match_captain
select * from soccer_country
select * from player_mast
select p.player_name ,m.match_no  from match_captain m inner join player_mast p on m.player_captain=p.player_id and p.posi_to_play='gk'

--40. Write a query in SQL to find the number of captains who was also the goalkeeper.  (match_captain, player_mast, soccer_country)
select * from match_captain
select * from player_mast
select * from soccer_country
select count(*) as no_of_caption  from (select distinct  p.player_name   from match_captain m inner join player_mast p on m.player_captain=p.player_id and p.posi_to_play='gk') as captipn



--41. Write a query in SQL to find the players along with their team booked number of times in the tournament. 
----Show the result according to the team and number of times booked in descending order.  ( soccer_country, player_booked, player_mast)
select * from soccer_country
select * from player_booked
select * from player_mast
select pp.player_name ,s.country_name ,count(p.player_id) as no_of_book from soccer_country s join player_mast pp on pp.team_id=s.country_id inner join
player_booked p on p.player_id=pp.player_id group by pp.player_name ,s.country_name order by no_of_book  desc


--42. Write a query in SQL to find the players who booked most number of times.  (soccer_country, player_booked, player_mast)
select * from soccer_country
select * from player_booked
select * from player_mast
select distinct p.player_name from  player_mast p  inner join player_booked pp on p.player_id=pp.player_id where p.player_id in ( select player_id from player_booked group by player_id having count(player_id) =(select top 1count(player_id ) as hign from player_booked group by player_id order by hign desc))



--43. Write a query in SQL to find the number of players booked for each team.  (soccer_country, player_booked)
select * from soccer_country
select * from player_booked
select s.country_name ,count(p.player_id) from soccer_country s join player_booked p on p.team_id=s.country_id group by p.team_id, s.country_name




----------------sub-44. Write a query in SQL to find the most number of cards shown in the matches.  (soccer_country, player_booked, player_mast)
select * from soccer_country
select * from player_booked
select * from player_mast
select match_no from player_booked   group by match_no having count(match_no) =(select max(d) from ( (select count(match_no) as d from player_booked group by match_no)) as ff)



--45. Write a query in SQL to list the name of assistant referees with their countries for each matches.  (match_details, asst_referee_mast, soccer_country)
select * from match_details
select * from asst_referee_mast
select * from  soccer_country
select s.country_name,a.ass_ref_name,m.match_no from soccer_country s join asst_referee_mast a on s.country_id=a.country_id join match_details m on m.ass_ref=a.ass_ref_id group by m.match_no,s.country_name,a.ass_ref_name,m.match_no
--46. Write a query in SQL to find the assistant referees of each countries assists the number of matches. (match_details, asst_referee_mast, soccer_country)
select * from match_details
select * from asst_referee_mast
select * from  soccer_country
select s.country_name,count(distinct m.match_no) from soccer_country s join asst_referee_mast a on s.country_id=a.country_id join match_details m on m.ass_ref=a.ass_ref_id group by s.country_name




-----------47. Write a query in SQL to find the countries from where the assistant referees assist most of the matches. (match_details, asst_referee_mast, soccer_country)
select * from match_details
select * from asst_referee_mast
select * from  soccer_country


select top 1 s.country_name,count( distinct m.match_no) as max  from soccer_country s  join asst_referee_mast a
on a.country_id=s.country_id  join match_details m on m.ass_ref=a.ass_ref_id  group by s.country_name order by max desc

--48. Write a query in SQL to list the name of referees with their countries for each match.  (match_mast, referee_mast, soccer_country)
select * from match_mast
select * from referee_mast
select * from soccer_country
select s.country_name,r.referee_name from soccer_country s join referee_mast r on r.country_id=s.country_id inner join match_mast m on m.referee_id=r.referee_id 
group by m.match_no,s.country_name,r.referee_name 



--49. Write a query in SQL to find the referees of each country managed number of matches. (match_mast, referee_mast, soccer_country)
select * from match_mast
select * from referee_mast
select * from soccer_country
select s.country_name,count(m.match_no) from soccer_country s join referee_mast r on r.country_id=s.country_id inner join match_mast m on m.referee_id=r.referee_id 
group by s.country_name




--50. Write a query in SQL to find the countries from where the referees managed most of the matches.  (match_mast, referee_mast, soccer_country)
select * from match_mast
select * from referee_mast
select * from soccer_country

select top 1 s.country_name,count(m.referee_id) as max  from soccer_country s join referee_mast r on r.country_id=s.country_id inner join match_mast m on m.referee_id=r.referee_id  group by s.country_name order by max desc


--51. Write a query in SQL to find the referees managed the number of matches. (match_mast, referee_mast, soccer_country)
select * from match_mast
select * from referee_mast
select * from soccer_country
select r.referee_name ,count( m.referee_id) from referee_mast r join match_mast m on m.referee_id=r.referee_id group by  r.referee_name 

--52. Write a query in SQL to find those referees who managed most of the match.  ( match_mast, referee_mast, soccer_country)
select * from match_mast
select * from referee_mast
select * from soccer_country
 select r.referee_name  from referee_mast r join match_mast m on m.referee_id=r.referee_id group by  r.referee_name having count(m.referee_id) =
( select max(maxi) from  (select count(referee_id ) as maxi  from match_mast group by referee_id ) as hhh)




--53. Write a query in SQL to find the referees managed the number of matches in each venue.  (match_mast, referee_mast, soccer_country, soccer_venue)
select * from match_mast
select * from referee_mast
select * from soccer_venue
select s.venue_name ,r.referee_name,count(match_no) from soccer_venue s join match_mast m on m.venue_id=s.venue_id join referee_mast r on r.referee_id=m.referee_id
group by m.venue_id,s.venue_name ,r.referee_name



--54. Write a query in SQL to find the referees and number of booked he made. (player_booked, match_mast, referee_mast)
select * from player_booked
select * from match_mast
select * from referee_mast

select r.referee_name ,count(p.match_no) from referee_mast r join  match_mast m on m.referee_id=r.referee_id join player_booked p on p.match_no=m.match_no 
group by r.referee_name
--55. Write a query in SQL to find the referees who booked most number of players.  (player_booked, match_mast, referee_mast)
select * from player_booked
select * from match_mast
select * from referee_mast
select top 1 r.referee_name ,count(p.match_no) as d from referee_mast r join  match_mast m on m.referee_id=r.referee_id join player_booked p on p.match_no=m.match_no 
group by r.referee_name order by d desc 




--56. Write a query in SQL to find the player of each team who wear jersey number 10.  (player_mast, soccer_country)
select * from player_mast
select * from soccer_country
select s.country_name ,p.player_name from soccer_country s join player_mast p on p.team_id=s.country_id where p.jersey_no=10   group by s.country_name ,p.player_name





--57. Write a query in SQL to find the defender who scored goal for his team.  (goal_details, player_mast, soccer_country)
select * from goal_details
select * from player_mast
select * from soccer_country
select p.player_name from player_mast p inner join goal_details g on g.player_id=p.player_id where p.posi_to_play='df'





--58. Write a query in SQL to find the position of a player to play who scored own goal.  (goal_details, player_mast, soccer_country)

select * from goal_details
select * from player_mast
select * from soccer_country       
select p.player_name,p.posi_to_play    from player_mast p join goal_details g on g.player_id=p.player_id where g.goal_type='o'



--59. Write a query in SQL to find the results of penalty shootout matches. (match_details, soccer_country)
select * from  match_details
select * from soccer_country
select s.country_name ,m.match_no,m.win_lose from soccer_country s join match_details m on m.team_id=s.country_id where m.penalty_score is not null






--60. Write a query in SQL to find the goal scored by the players according to their playing position.  (goal_details, player_mast, soccer_country)
select * from goal_details
select * from player_mast
select * from soccer_country
select p.player_name ,count(g.player_id),p.posi_to_play from player_mast p inner join goal_details g on g.player_id=p.player_id group by p.posi_to_play, p.player_name

 


--61. Write a query in SQL to find those players who came into the field in the most last time of play.  (player_in_out, player_mast, soccer_country)
select * from player_in_out
select * from player_mast
select * from soccer_country

select p.player_name from player_mast p join player_in_out pp on pp.player_id=p.player_id where pp.in_out='i' and pp.time_in_out=(select max(time_in_out) from 
player_in_out where in_out='i')
