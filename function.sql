-- Function

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