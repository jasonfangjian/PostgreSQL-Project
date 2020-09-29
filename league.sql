BEGIN TRANSACTION;
CREATE TABLE League (
	id	SERIAL PRIMARY KEY,
	country_id	INTEGER,
	name	TEXT UNIQUE,
	FOREIGN KEY(country_id) REFERENCES country(id)
);
INSERT INTO League VALUES(1,1,'Belgium Jupiler League');
INSERT INTO League VALUES(1729,1729,'England Premier League');
INSERT INTO League VALUES(4769,4769,'France Ligue 1');
INSERT INTO League VALUES(7809,7809,'Germany 1. Bundesliga');
INSERT INTO League VALUES(10257,10257,'Italy Serie A');
INSERT INTO League VALUES(13274,13274,'Netherlands Eredivisie');
INSERT INTO League VALUES(15722,15722,'Poland Ekstraklasa');
INSERT INTO League VALUES(17642,17642,'Portugal Liga ZON Sagres');
INSERT INTO League VALUES(19694,19694,'Scotland Premier League');
INSERT INTO League VALUES(21518,21518,'Spain LIGA BBVA');
INSERT INTO League VALUES(24558,24558,'Switzerland Super League');
COMMIT;
