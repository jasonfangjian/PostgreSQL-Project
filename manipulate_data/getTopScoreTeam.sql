-- 根据每个赛季，获取进球数量最多的topk球队(主客场相加)

create or replace function
	getTopTeamOfScore(season Text, top_k Integer)
	RETURNS TABLE(
		team_long_name TEXT,
		total_score Numeric
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
	--build the query
	queryString = 'select a.team_long_name, sum(a.sum + h.sum) as total_score from AwayTeamGoalView as a, HomeTeamGoalView as h 
					where a.season = ' || QUOTE_LITERAL(season) || ' and h.season = a.season'
					||' and a.team_long_name = h.team_long_name group by a.team_long_name'
					||' order by total_score DESC LIMIT ' || top_k;
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from getTopTeamOfScore('2008/2009',5);
