-- Function
-- Рахує кількість фільмів обраного жанру (назва жанру передається в функцію)

CREATE OR REPLACE FUNCTION count_films_of_certain_genre(genre text) RETURNS int AS
$$
    DECLARE
        films_amount integer;
    BEGIN
        SELECT COUNT(*) INTO films_amount
        FROM Films
        INNER JOIN Genres ON Films.genre_id = Genres.genre_id
        WHERE Genres.genre_name = genre;
        
        RETURN films_amount;
    END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM count_films_of_certain_genre('Drama');


-- Procedure
-- Виводить фільми обраного жанру (назва жанру передається в процедуру)

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

CALL films_by_certain_genre('Action');


-- Trigger
-- При додаванні нового значення в таблицю Directors, 
-- змінює регістр імені на верхній та додає текст "DIRECTOR: " перед іменем

CREATE OR REPLACE FUNCTION reformat_director_name() RETURNS TRIGGER AS
$$
	BEGIN
		UPDATE Directors
        SET director_name = UPPER('DIRECTOR: ' || NEW.director_name)
        WHERE director_id = NEW.director_id; 
		RETURN NULL;
	END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER reformat_director_name_trigger
AFTER INSERT ON Directors
FOR EACH ROW
EXECUTE FUNCTION reformat_director_name();

SELECT * FROM Directors;
INSERT INTO Directors (director_name) VALUES ('Mia Boyko');
SELECT * FROM Directors;