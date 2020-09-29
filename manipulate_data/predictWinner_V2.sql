--和旧版相比，输入一个比赛场数，主队名称和客队名称，我们将在比赛记录中查找主队和客队都一致的交手记录（根据输入的比赛场数，1就是最近1场，5就是最近5场交手记录）
--统计这几场比赛的主队和客队进球数，如果主队多，我们就预计主队赢，反之则客队赢，相等为平手，不预测输赢。
DROP function if exists predictWinner_V2(INTEGER,TEXT,TEXT);
CREATE OR REPLACE FUNCTION
    predictWinner_V2(matchcounts INTEGER, home_team_name TEXT, away_team_name TEXT)
    RETURNS TEXT AS
$$
DECLARE
	queryString TEXT;
	goal_diff Numeric;
	team TEXT;
    home_id INTEGER;
    away_id INTEGER;
BEGIN
     IF matchcounts = 0 THEN
     RETURN 'the number of match cannot be 0';
     END IF;
     SELECT team_api_id FROM team WHERE team_long_name = home_team_name INTO home_id;
     SELECT team_api_id FROM team WHERE team_long_name = away_team_name INTO away_id;
     IF EXISTS(SELECT 1 FROM match WHERE home_team_api_id = home_id AND away_team_api_id = away_id) THEN
	       IF EXISTS(SELECT 1 FROM match WHERE home_team_api_id = home_id AND away_team_api_id = away_id 
			 AND (SELECT COUNT(id) FROM match WHERE home_team_api_id = home_id AND away_team_api_id = away_id)>= matchcounts)
	       THEN
	       SELECT (sum(h.home_team_goal) - sum(h.away_team_goal))AS goal_diff 
	       FROM (SELECT * FROM match WHERE home_team_api_id = home_id AND away_team_api_id = away_id 
		     ORDER BY date DESC LIMIT matchcounts) AS h  INTO goal_diff;
	         IF goal_diff > 0
	         THEN
	       --returning home_team_name into winner_team;
	         return home_team_name;
	         ELSE 
	            IF goal_diff = 0 THEN
	               --returning away_team_name into winner_team;
		       team = 'draw';
	               return team;
	            ELSE
		       RETURN away_team_name;
		    END IF;
	         END IF;
	        ELSE
	        team = 'There are not so many match records';
	        return team;
	        END IF;
          ELSE
          team = 'No record';
          return team;
          END IF;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM predictWinner_V2(5,'Liverpool','Arsenal')
