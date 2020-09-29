--输入一个能力值，以及top前几的数值，将会获得一个球队中高于这个能力值的球员的总身价和总工资的比，按照升序排序，这个比越低意味着性价比越低（低身价高工资）
create or replace function 
	getRatioOfValueToWage(rating INTEGER, top_k Integer)
	RETURNS TABLE (
		team_name TEXT,
		ratio NUMERIC
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
	queryString = 'select p.team_name::text, round(p.value/p.wage,2) as ratio  
	from (SELECT team_name,sum(value_euro) as value,sum(wage_euro) as wage FROM PlayerTeamView_V2 
	WHERE overall_rating >= '||rating||' AND wage_euro IS NOT NULL AND value_euro IS NOT NULL GROUP BY team_name) as p  
	order by ratio LIMIT ' || top_k;
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from getRatioOfValueToWage(75,50);
