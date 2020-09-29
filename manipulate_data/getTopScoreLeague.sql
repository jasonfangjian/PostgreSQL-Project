--每个赛季根据进球数 获取该赛季进球总数的top k个联盟
create or replace function 
	getTopScoreLeague(season TEXT, top_k Integer)
	RETURNS Table (
		league_season TEXT,
		league_name TEXT,
		total_score BIGINT
	)AS
$$
DECLARE
	queryString TEXT;
BEGIN
	--build the query
	queryString = 'select l.season, l.league_name, l.total_goals from  LeagueGoalView as l where l.season = ' ||
				  QUOTE_LITERAL(season) || ' order by l.total_goals DESC LIMIT ' || top_k;
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from getTopScoreLeague('2013/2014',2);
