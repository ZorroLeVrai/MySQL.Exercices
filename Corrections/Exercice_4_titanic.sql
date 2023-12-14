-- 1- Combien y a t-il de passagers dans notre base de données ?
SELECT COUNT(*) AS "Nb passagers"
FROM titanic_passenger;

-- 2- Quelle est la moyenne du prix du trajet ?
SELECT avg(fare)
FROM titanic_passenger;

-- 3- Quel passager a payé le billet le plus cher ?
SELECT p.name, p.fare
FROM titanic_passenger p
WHERE fare is not null
ORDER BY fare DESC
LIMIT 1;

-- 4- Quelles personnes n’ont pas payé leurs billets de 1ère classe ?
SELECT p.name
FROM titanic_passenger p
WHERE pclass = 1
	AND fare = 0;

-- 5- Quelle personne a obtenu le billet de première classe le moins cher ?
SELECT p.name, p.fare
FROM titanic_passenger p
WHERE pclass = 1
	AND fare != 0
ORDER BY fare
LIMIT 1;

-- 6.1- Quel est le passager le plus jeune ?
SELECT p.name, p.age
FROM titanic_passenger p
WHERE age is not null
ORDER BY age
LIMIT 1;

-- 6.2- Quel est le passager le plus âgé ?
SELECT p.name, p.age
FROM titanic_passenger p
WHERE age is not null
ORDER BY age DESC
LIMIT 1;

-- 7- Quel est le prix moyen des billets de 1ère, 2ème ou 3ème classe ?
SELECT
	pclass as classe,
	avg(fare) AS "prix moyen"
FROM titanic_passenger
GROUP BY classe
ORDER BY classe;

-- 8- Quel est le pourcentage de femmes dans la liste des passagers ?
WITH p AS (
	SELECT sex
	FROM titanic_passenger
)
SELECT 100.0*(SELECT count(*) FROM p WHERE p.sex='female') / (SELECT count(*) FROM p) as pourcentage_femme;

-- 9- Quel est le pourcentage de passagers par tranche d'âge.
SELECT
	CASE
		WHEN age BETWEEN 0 AND 10 THEN '0-10 ans'
		WHEN age BETWEEN 10 AND 25 THEN '10-25 ans'
		WHEN age BETWEEN 25 AND 60 THEN '25-60 ans'
		ELSE '> 60 ans'
	end as tranche_age,
	100.0*count(*) / (SELECT count(*) FROM titanic_passenger) AS pourcentage_passengers
FROM titanic_passenger
GROUP BY tranche_age;

-- 2ème exemple
SELECT
    tranche_age,
    (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS pourcentage_passengers
FROM (
    SELECT
        CASE
            WHEN age BETWEEN 0 AND 10 THEN '0-10 ans'
            WHEN age BETWEEN 11 AND 25 THEN '11-25 ans'
            WHEN age BETWEEN 25 AND 60 THEN '25-60 ans'
            ELSE '> 60 ans'
        END as tranche_age
    FROM
        titanic_passenger
) age_groups
GROUP BY
    tranche_age;
    
-- 10- Quelle est la proportion des survivants ?
WITH pas_sur AS (
  SELECT
	  s.survived
  FROM titanic_passenger p
  INNER JOIN titanic_survival s ON s.passengerid = p.passengerid
)
SELECT sum(survived) * 100.0 / count(*) FROM pas_sur;

-- 2ème exemple
SELECT
	(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS pourcentage_survivants
FROM titanic_passenger p
INNER JOIN titanic_survival s ON s.passengerid = p.passengerid
GROUP BY s.survived
ORDER BY s.survived DESC
LIMIT 1;

-- 11- Quelle est la proportion des survivants par classe de transport ?
WITH stat_sur AS (
  SELECT
	  s.survived,
    p.pclass,
	  (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY p.pclass)) AS pourcentage_survivants
  FROM titanic_passenger p
  INNER JOIN titanic_survival s ON s.passengerid = p.passengerid
  GROUP BY s.survived, p.pclass
)
SELECT pclass, pourcentage_survivants
FROM stat_sur
WHERE survived = 1
ORDER BY pclass;

-- 12- Quelle est la proportion des survivants par tranche d'âge ?
WITH pas_age AS (
  SELECT
    CASE
      WHEN age BETWEEN 0 AND 10 THEN '0-10 ans'
      WHEN age BETWEEN 11 AND 25 THEN '11-25 ans'
      WHEN age BETWEEN 25 AND 60 THEN '25-60 ans'
      ELSE '> 60 ans'
    END as tranche_age,
    p.passengerid,
    s.survived
  FROM
    titanic_passenger p
  INNER JOIN
    titanic_survival s ON s.passengerid = p.passengerid
)
SELECT 
  survived,
  tranche_age,
  (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY tranche_age)) AS pourcentage_survivants
FROM
  pas_age
GROUP BY
  survived,
  tranche_age;
    
-- 13- Quelle est la proportion des survivants par genre ?
SELECT
    genre,
    (COUNT(*) FILTER (WHERE s.survived) * 100.0 / COUNT(*)) AS pourcentage_passengers
FROM (
    SELECT
        sex as genre,
		passengerid
    FROM
        titanic_passenger
) passagers
INNER JOIN titanic_survival s ON s.passengerid = passagers.passengerid
GROUP BY
    genre;
