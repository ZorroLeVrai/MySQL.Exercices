-- Affichage des nombres de 1 à 10
WITH RECURSIVE numbers AS (
  SELECT 1 AS nb
  UNION
  SELECT nb + 1 FROM numbers WHERE nb < 10
)
SELECT * FROM numbers;

/******* Recherche de hierarchie ********/
CREATE TABLE organigramme (
  id TINYINT,
  manager_id TINYINT,
  name VARCHAR(20),
  CONSTRAINT pk_organigramme PRIMARY KEY (id)
);

INSERT INTO organigramme VALUES (1, null, 'Gabriel');
INSERT INTO organigramme VALUES (2, 1, 'Léa');
INSERT INTO organigramme VALUES (3, 1, 'Tiago');
INSERT INTO organigramme VALUES (4, 2, 'Emma');
INSERT INTO organigramme VALUES (5, 2, 'Robin');
INSERT INTO organigramme VALUES (6, 3, 'Louise');
INSERT INTO organigramme VALUES (7, 3, 'Jules');
INSERT INTO organigramme VALUES (8, 4, 'Adèle');

-- Requête récursive
WITH RECURSIVE management AS (
	SELECT id FROM organigramme WHERE name='Gabriel'
    UNION
    SELECT orga.id
    FROM management m
    INNER JOIN organigramme orga ON orga.manager_id = m.id
)
SELECT m.id, name
FROM management m
INNER JOIN organigramme o ON o.id = m.id;


