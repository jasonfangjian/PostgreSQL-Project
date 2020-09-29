create or replace function 
	numberOfTopPlayerByCountry_rating(Greater INTEGER)
	RETURNS TABLE (
		country_name TEXT,
		number_player INTEGER
	) AS
$$
DECLARE
	queryString TEXT;
BEGIN
	queryString = 'select p.name::text, CAST(COUNT(DISTINCT p.id) AS INTEGER) as number_count 
	from countryPlayerView as p where p.overall_rating >= ' || 
	              Greater || 'group by p.name order by number_count DESC';
	RETURN QUERY EXECUTE queryString;
END;
$$
LANGUAGE plpgsql;

--how to invoke the method above
select * from numberOfTopPlayerByCountry_rating(75);
