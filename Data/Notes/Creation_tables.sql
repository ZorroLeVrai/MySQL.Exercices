CREATE TABLE IF NOT EXISTS public.Matieres
(
	id INT PRIMARY KEY,
	libelle VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.Niveaux
(
	id INT PRIMARY KEY,
	niveau VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.Eleves
(
	id INT PRIMARY KEY,
	prenom VARCHAR(50) NOT NULL,
	nom VARCHAR(50) NOT NULL,
	genre VARCHAR(10) NOT NULL,
	date_naissance DATE,
	id_niveau SMALLINT REFERENCES Niveaux(id)
);

CREATE TABLE IF NOT EXISTS public.Notes
(
	id INT PRIMARY KEY,
	id_eleve INT REFERENCES Eleves(id),
	id_matiere INT REFERENCES Matieres(id),
	note REAL NOT NULL
);
