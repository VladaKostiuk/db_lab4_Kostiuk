CREATE TABLE Genres
(
  genre_id SERIAL,
  genre_name CHAR(50) NOT NULL
);

CREATE TABLE Directors
(
  director_id SERIAL,
	director_name CHAR(50) NOT NULL
);

CREATE TABLE Films
(
  film_id SERIAL,
  film_name CHAR(50) NOT NULL,
  film_overview CHAR(1000) NOT NULL,
  genre_id INT NOT NULL,
  director_id INT NOT NULL,
  release_year DATE NOT NULL
);

ALTER TABLE Genres ADD CONSTRAINT PK_Genres PRIMARY KEY (genre_id);
ALTER TABLE Directors ADD CONSTRAINT PK_Directors PRIMARY KEY (director_id);
ALTER TABLE Films ADD CONSTRAINT PK_Films PRIMARY KEY (film_id);

ALTER TABLE Films ADD CONSTRAINT FK_Films_Genres FOREIGN KEY (genre_id) REFERENCES Genres (genre_id);
ALTER TABLE Films ADD CONSTRAINT FK_Films_Directors FOREIGN KEY (director_id) REFERENCES Directors (director_id);