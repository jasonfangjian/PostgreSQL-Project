  
--输入一个能力值，返回高于这个能力值的球员在哪些国家的联赛踢球的分布
create or replace function 
	numberOfTopPlayerByCountry_topValue(top_k INTEGER)
	RETURNS TABLE (
		country_name TEXT,
		number_player INTEGER
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
	queryString = 'select p.name::text, CAST(COUNT(DISTINCT p.id) AS INTEGER) as number_count 
	FROM (SELECT *  FROM countryPlayerView ORDER BY value_euro DESC LIMIT '||top_k||') AS p 
	group by p.name 
	order by number_count DESC';
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from numberOfTopPlayerByCountry_topValue(100);
