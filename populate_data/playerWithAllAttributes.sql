--将球员名称和其对应的各年份的数据属性对应起来（08-16）
create or replace VIEW playerWithAllAttributes as 
	select f.player_api_id as player_id, s.player_name as player_name,
	TO_TIMESTAMP(s.birthday, 'YYYY/MM/DD HH24:MI:SS') as birth, s.height as height,  
	TO_TIMESTAMP(f.date, 'YYYY/MM/DD HH24:MI:SS') as dateOfRecord , 
	f.overall_rating AS rating, f.potential AS potential
	from player AS s INNER JOIN player_attributes AS f ON s.player_api_id = f.player_api_id
	where s.birthday is not null AND s.height is not null AND f.date is not null
	order by s.player_name
