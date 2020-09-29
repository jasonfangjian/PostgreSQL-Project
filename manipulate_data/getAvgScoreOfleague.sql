--输入赛季，将会得到每个联赛当赛季的场均进球，获得连续8年的数据（08-16）可以分析趋势

DROP FUNCTION getavgscoreofleague(text);
create or replace function
	getAvgScoreOfleague(season_input Text)
	RETURNS TABLE(
		league_name TEXT,
		avg_score Numeric
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
    IF NOT EXISTS(SELECT 1 FROM LeagueMatchView WHERE LeagueMatchView.season = season_input )
	THEN
	RAISE NOTICE '%','no season';
	RETURN;
	ELSE
	--build the query
	queryString = 'select league_name,
	ROUND(CAST((SUM(home_team_goal)+SUM(away_team_goal))as numeric)/CAST(COUNT(match_api_id) AS NUMERIC) ,2 )AS AVG 
	FROM LeagueMatchView WHERE season ='||QUOTE_LITERAL(season_input)||'GROUP BY league_name'; 
	RETURN QUERY EXECUTE queryString;
	END IF;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from getAvgScoreOfleague('2008/2009');
