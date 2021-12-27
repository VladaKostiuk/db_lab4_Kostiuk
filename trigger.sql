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