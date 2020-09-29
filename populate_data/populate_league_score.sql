--根据league name, season， 判断每个主客场球队的进球数，胜负， 和总的进球数
create or replace VIEW LeagueGoalView as 
	select l.name as league_name, season,
			AVG(home_team_goal) as avg_home_team_goal,
			AVG(away_team_goal) as avg_away_team_goal,
			AVG(home_team_goal - away_team_goal) as avg_goal_dif,
			SUM(home_team_goal + away_team_goal) as total_goals
		from Match as m JOIN League as l on l.id = m.league_id
		LEFT JOIN Team as home_team on home_team.team_api_id = m.home_team_api_id
		LEFT JOIN Team as away_team on away_team.team_api_id = m.away_team_api_id
		group by l.name,season
		order by  l.name, season DESC;

