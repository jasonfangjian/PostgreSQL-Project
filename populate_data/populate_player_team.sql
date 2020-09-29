
--建立一个球员和球队之间的view
-- id, player_name, team_name, join_year, leave_year, overall_rating, potential

create or replace VIEW PlayerTeamView as 
	select id as player_id, full_name as player_name,club_team as team_name, cast(EXTRACT(YEAR FROM club_join_date)as Integer) as join_year, 
	             cast(contract_end_year as Integer ) as leave_year , overall_rating, potential
	from player_update
	where club_join_date is not null and contract_end_year is not null
	order by id, full_name