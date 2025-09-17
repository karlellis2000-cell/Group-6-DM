CREATE TABLE movies (
	url TEXT PRIMARY KEY,
	movie_id SERIAL,
	title TEXT,
	reldate DATE,
	metascore INTEGER,
	userscore NUMERIC
);
/* 
	Creates a table called "movies"
*/

INSERT INTO movies (url,title,reldate,metascore,userscore)
SELECT url,title,reldate,metascore,userscore
FROM staging_movies
/*
	Imports necessary data from staging_movies in movies table
*/