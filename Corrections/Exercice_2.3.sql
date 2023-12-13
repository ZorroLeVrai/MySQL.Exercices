-- 1- Quelle est la date de naissance de Gaston Pourquier ?
SELECT date_naissance
FROM eleve e
WHERE e.nom = 'Pourquier'
	AND e.prenom = 'Gaston';

-- 2- Récupérer la note de Gaston Pourquier en Histoire
SELECT n.score
FROM note n
INNER JOIN matiere m on m.id = n.id_matiere
INNER JOIN eleve e on e.id = n.id_eleve
WHERE
  m.libelle = 'Histoire'
  AND e.prenom = 'Gaston'
  AND e.nom = 'Pourquier';

-- 3.1- Récupérer la meilleure note obtenue en Histoire
SELECT max(score) AS "meilleure note"
FROM note n
INNER JOIN matiere m ON m.id = n.id_matiere
WHERE m.libelle = 'Histoire';

-- 3.2- Qui a obtenu la meilleur note en Histoire ?
SELECT n.score, e.nom, e.prenom
FROM note n
INNER JOIN matiere m ON m.id = n.id_matiere
INNER JOIN eleve e ON e.id = n.id_eleve
WHERE m.libelle = 'Histoire'
ORDER BY n.score DESC
LIMIT 1;

-- 2ème exemple
SELECT n.score, e.nom, e.prenom
FROM note n
INNER JOIN eleve e ON e.id = n.id_eleve
INNER JOIN matiere m ON m.id = n.id_matiere
WHERE m.libelle = 'Histoire'
	AND n.score = ( SELECT max(score)
		FROM note n
		INNER JOIN matiere m ON m.id = n.id_matiere
		WHERE m.libelle = 'Histoire'
	);
  
-- 3ème exemple
WITH nh AS (
		SELECT n.id_eleve, n.id_matiere, n.score 
		FROM note n
		INNER JOIN matiere m ON m.id = n.id_matiere
		WHERE m.libelle = 'Histoire'
	)
SELECT nh.score, e.nom, e.prenom
FROM nh
INNER JOIN eleve e ON e.id = nh.id_eleve
WHERE nh.score = (SELECT max(nh.score) FROM nh);

-- 4- Quelle est la différence d'age (en années) entre le plus jeune et le plus agé des élèves ?
SELECT round((datediff(max(e.date_naissance), min(e.date_naissance)))/365.0, 2) As years
FROM eleve e;

-- 5- Donner les moyennes des notes pour chaque élève.
-- Ordonner les résultats par moyenne décroissante.
SELECT e.nom, e.prenom, avg(n.score) AS moyenne
FROM eleve e
INNER JOIN note n ON e.id = n.id_eleve
GROUP BY e.nom, e.prenom
ORDER BY moyenne DESC;
