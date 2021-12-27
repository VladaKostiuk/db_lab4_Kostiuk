-- Procedure

CREATE OR REPLACE PROCEDURE films_by_certain_genre(genre text)
LANGUAGE plpgsql AS
$$
	DECLARE
		film_record record;
	BEGIN
		FOR film_record IN
			SELECT Films.film_name
			FROM Films
			INNER JOIN Genres ON Films.genre_id = Genres.genre_id
			WHERE Genres.genre_name = genre
		LOOP
			RAISE INFO 'Film Name: %', film_record.film_name;
		END LOOP;
	END;
$$;