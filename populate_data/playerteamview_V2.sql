--相比旧版视图添加了身价和工资
CREATE OR REPLACE VIEW PlayerTeamView_V2 as 
SELECT player_update.id AS player_fifa_api_id,
    player_update.full_name AS player_name,
    player_update.club_team AS team_name,
    player_update.overall_rating,
    player_update.potential,
    player_update.value_euro,
    player_update.wage_euro
    FROM player_update
  WHERE player_update.club_team IS NOT NULL AND player_update.club_team::text <> player_update.nationality::text
  ORDER BY player_update.id, player_update.full_name;
