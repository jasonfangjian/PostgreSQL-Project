--输入一个生日范围（开始年份和结束年份）以及一个数据的年份（因为里面有08-16年的数据），将会获得在这个生日范围内的球员的身高所对应的平均潜力（以输入的年份的数据为准）
DROP function if exists getRelationBetweenHeightAndPotential(INTEGER,INTEGER,INTEGER);
create or replace function 
	getRelationBetweenHeightAndPotential(start_birthday INTEGER,end_birthday INTEGER, year_of_records Integer)
	RETURNS TABLE (
		height INTEGER,
		avg_potential NUMERIC
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
	queryString = 'select s.height, round(AVG(s.potential),2) as potential  
from (select a.* from playerWithAllAttributes AS a 
      WHERE dateofrecord = (select max(dateofrecord) from playerWithAllAttributes 
                            where EXTRACT(YEAR FROM dateofrecord) = '||year_of_records||' AND player_id = a.player_id)) AS s 
WHERE EXTRACT(YEAR FROM s.birth) >= '||start_birthday||' AND EXTRACT(YEAR FROM s.birth) <='||end_birthday||' 
GROUP BY s.height 
ORDER BY s.height';
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from getRelationBetweenHeightAndPotential(1992,1997,2016);
