-- Création de la table élève
CREATE TABLE eleve (
  id TINYINT,
  nom VARCHAR(20),
  classe CHAR(1),
  note DECIMAL(4,2),
  CONSTRAINT pk_eleve PRIMARY KEY (id)
);

-- Insertion des élèves
INSERT INTO eleve VALUES (1, 'Gabriel', 'A', 18);
INSERT INTO eleve VALUES (2, 'Léa', 'B', 15);
INSERT INTO eleve VALUES (3, 'Tiago', 'C', 8);
INSERT INTO eleve VALUES (4, 'Emma', 'A', 17);
INSERT INTO eleve VALUES (5, 'Louise', 'B', 15);
INSERT INTO eleve VALUES (6, 'Martin', 'B', 12);
INSERT INTO eleve VALUES (7, 'Jules', 'C', 14);
INSERT INTO eleve VALUES (8, 'Léonie', 'A', 15);

-- Ajoutez une colonne nb de personnes par classe
SELECT
	nom,
    classe,
    note,
    count(*) OVER (PARTITION BY classe) AS nb_par_classe
FROM
	eleve;

-- Ajoutez une colonne affichant la moyenne de chaque classe
SELECT
	nom,
    classe,
    note,
    avg(note) OVER (PARTITION BY classe) AS moyenne
FROM
	eleve;

-- Calculez la proportion de chaque classe
SELECT
	classe,
    count(*) / (sum(count(*)) OVER ()) AS proportion
FROM
	eleve
GROUP BY
	classe;
