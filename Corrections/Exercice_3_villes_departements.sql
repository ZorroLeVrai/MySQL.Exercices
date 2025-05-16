-- 1- Obtenir la liste des 10 villes les plus peuplées en 2012
SELECT ville_nom as nom, ville_population_2012 as population
FROM ville
ORDER BY ville_population_2012 DESC 
LIMIT 10;

-- 2- Obtenir la liste des 50 villes ayant la plus faible superficie
SELECT ville_nom as nom, ville_surface as surface
FROM ville 
ORDER BY ville_surface ASC 
LIMIT 50;

-- 3- Obtenir la liste des départements d’outres-mer , c’est-à-dire ceux dont le numéro de département commencent par “97”
SELECT departement_nom
FROM departement 
WHERE departement_code LIKE '97%';

-- 4- Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé
SELECT v.ville_nom, d.departement_nom 
FROM ville v
LEFT JOIN departement d ON d.departement_code = v.ville_departement
ORDER BY v.ville_population_2012 DESC 
LIMIT 10;

-- 5- Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces départements, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes
SELECT d.departement_nom, d.departement_code, COUNT(ville_nom) AS nb_communes
FROM departement d
LEFT JOIN ville v ON d.departement_code = v.ville_departement
GROUP BY d.departement_nom, d.departement_code
ORDER BY nb_communes DESC;

-- 6- Obtenir la liste des 10 plus grands départements, en terme de superficie
SELECT d.departement_nom, d.departement_code, SUM(v.ville_surface) AS superficie
FROM departement d
INNER JOIN ville v ON d.departement_code = v.ville_departement
GROUP BY d.departement_nom, d.departement_code
ORDER BY superficie DESC
LIMIT 10;

-- 7- Compter le nombre de villes dont le nom commence par "Saint"
SELECT COUNT(*) AS nb
FROM ville 
WHERE ville_nom LIKE 'Saint%';

-- 8- Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes
SELECT ville_nom, COUNT(*) AS "nb nom ville"
FROM ville 
GROUP BY ville_nom
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- 9- Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieure à la superficie moyenne.
SELECT ville_nom, ville_surface
FROM ville 
WHERE ville_surface > (SELECT AVG(ville_surface) FROM ville);

-- 2ème exemple
WITH v AS (
  SELECT AVG(ville_surface) AS avg_surface FROM ville
)
SELECT ville_nom, ville_surface
FROM ville, v
WHERE ville_surface > v.avg_surface;

-- 10- Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants
SELECT d.departement_nom, d.departement_code, SUM(v.ville_population_2012) AS population_2012
FROM ville v
INNER JOIN departement d ON d.departement_code = v.ville_departement
GROUP BY d.departement_nom, d.departement_code
HAVING SUM(ville_population_2012) > 2000000
ORDER BY population_2012 DESC;

-- 11- Remplacez les tirets par un espace vide, pour toutes les villes commençant par "SAINT-"
START TRANSACTION;

  UPDATE ville 
  SET ville_nom = REPLACE(ville_nom, '-', ' ') 
  WHERE ville_nom LIKE 'SAINT-%';

--ROLLBACK;
COMMIT;

-- Création d'une table temporaire pour tester la modification
CREATE TEMPORARY TABLE temp_ville
SELECT * FROM ville;

UPDATE temp_ville 
SET ville_nom = REPLACE(ville_nom, '-', ' ') 
WHERE ville_nom LIKE 'SAINT-%';
