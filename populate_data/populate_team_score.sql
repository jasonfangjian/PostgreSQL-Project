--根据team name 创建球队和进球数的关系

--主场球队各个赛季的进球数和平均进球数
drop view if exists HomeTeamGoalView;
create or replace VIEW HomeTeamGoalView as
	select t.team_long_name, m.season, SUM(home_team_goal), AVG(home_team_goal)
		from Match as m, Team as t 
		where m.home_team_api_id = t.team_api_id
		group by t.team_long_name, m.season
		order by t.team_long_name, m.season;


drop view if exists AwayTeamGoalView;
create or replace VIEW AwayTeamGoalView as
	select t.team_long_name, m.season, SUM(away_team_goal), round(AVG(away_team_goal),1) as average_goal
		from Match as m, Team as t 
		where m.away_team_api_id = t.team_api_id
		group by t.team_long_name, m.season
		order by t.team_long_name, m.season;

