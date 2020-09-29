
--与旧版相比，输入一个能力值，计算一个球队中高于这个能力值的球员的平均能力，因为很多强队中低能力值的是预备队，不能反应真正实力，要加以过滤）
--因为用的player——update的数据，这个数据就是2019年的数据，都在球队中，因此不需要根据合同年份来判断，很多租借球员也在队中，但是不会有合同期限。
create or replace function 
	getTopPotentialTeam_V2(Greater INTEGER, top_k Integer)
	RETURNS TABLE (
		team_name TEXT,
		avg_over_rating NUMERIC
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
	queryString = 'select p.team_name::text, round(AVG(p.overall_rating),2) as rating  from PlayerTeamView_V2 as p 
	where p.overall_rating >= '|| Greater|| ' group by p.team_name order by rating DESC LIMIT ' || top_k;
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from getTopPotentialTeam_V2(70,5);
