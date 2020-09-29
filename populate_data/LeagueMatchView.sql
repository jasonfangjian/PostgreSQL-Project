--将联赛名和比赛匹配起来
create or replace VIEW LeagueMatchView as 
	select l.name as league_name,match_api_id, season,date,home_team_api_id,
	away_team_api_id, home_team_goal,away_team_goal
	from Match as m JOIN League as l on l.id = m.league_id
