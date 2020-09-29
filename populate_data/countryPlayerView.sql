--将国家名和球员的id和名字（能力值，潜力值，身价等）匹配起来，即球员和他所在的俱乐部所在的国家。
create or replace VIEW countryPlayerView as 
	SELECT q.name,m.id,m.full_name,m.overall_rating,m.potential,m.value_euro,m.wage_euro
   FROM player_update m JOIN ( SELECT a.id,a.team_api_id,a.team_fifa_api_id,a.team_long_name,a.team_short_name,p.id,
            p.name,p.country_id,p.home_team_api_id
           FROM team a JOIN ( SELECT f.id,f.name,s.country_id,s.home_team_api_id
                   FROM country f JOIN ( SELECT match.country_id,match.home_team_api_id
                           FROM match
                           GROUP BY match.country_id, match.home_team_api_id
                           ORDER BY match.country_id) s ON s.country_id = f.id) p 
			      ON p.home_team_api_id = a.team_api_id) q
			      (id, team_api_id, team_fifa_api_id, team_long_name,
			       team_short_name, id_1, name, country_id, home_team_api_id) ON q.team_long_name = m.club_team::text
  GROUP BY q.name, m.id, m.full_name, m.overall_rating, m.potential, m.value_euro, m.wage_euro
  ORDER BY m.overall_rating DESC;
