-- 1- Créez une vue `veleve_niveau` qui associe la table `eleve` et la table `niveau` afin d’avoir les informations de l’élève et le niveau d’étude dans une seule vue.
CREATE VIEW veleve_niveau AS
	SELECT e.id, e.prenom, e.nom, e.genre, e.date_naissance, n.niveau
	FROM eleves e
	INNER JOIN niveaux n ON n.id = e.id_niveau;
  
-- 2- Récupérez toutes les notes de Léa Benoit
SELECT m.libelle,nt.note
FROM eleves e
INNER JOIN notes nt ON nt.id_eleve = e.id
INNER JOIN matieres m ON m.id = nt.id_matiere
WHERE prenom = 'Léa'
	AND nom = 'Benoit';
 
-- 3- Ajoutez une note à Léa Benoit supérieur à 20 en Allemand (par exemple 25)
SET @id_note = (SELECT max(id) + 1 FROM notes);
SET @id_eleve = (SELECT id FROM eleves WHERE prenom = 'Léa' AND nom = 'Benoit');
SET @id_matiere = (SELECT id FROM matieres WHERE libelle = 'Allemand');
INSERT INTO notes (id, id_eleve, id_matiere, note)
VALUES (@id_note,
		@id_eleve,
		@id_matiere,
		25);
 
-- 2ème exemple
INSERT INTO notes (id, id_eleve, id_matiere, note)
SELECT (SELECT max(id) FROM notes) + 1,
		(SELECT id FROM eleves WHERE prenom = 'Léa' AND nom = 'Benoit'),
		(SELECT id FROM matieres WHERE libelle = 'Allemand'),
		25;

-- 4 - Ecrivez une requête pour supprimer la note précédemment ajoutéeEcrivez une requête pour supprimer la note précédemment ajoutée
DELETE FROM notes
WHERE id_eleve = (SELECT id FROM eleves WHERE prenom = 'Léa' AND nom = 'Benoit')
	AND id_matiere = (SELECT id FROM matieres WHERE libelle = 'Allemand');
  
-- La requête 4 effectue un full scan de la table eleves et de la table notes.
-- Ce qui est couteux car ces tables peuvent contenir pas mal de données
  
-- 5- En écrivant la requête n°3 nous avons vu que l’on pouvait entrer des notes supérieures à 20. Ajoutez une contrainte à la colonne `note` pour qu’elle soit toujours entre 0 et 20.
ALTER TABLE Notes
ADD CONSTRAINT check_note_range CHECK (note >= 0 AND note <= 20);

-- 6- Modifiez la table `notes` pour que le champ `id` soit généré automatiquement
-- Ajout de l'auto_increment
ALTER TABLE notes MODIFY COLUMN id INT auto_increment;

-- Commencer l'auto_increment à 40020
ALTER TABLE notes auto_increment = 40020;

-- 7- Faire en sorte qu’un élève ne puisse avoir qu’une seule note par matière
ALTER TABLE Notes
ADD CONSTRAINT u_notes_id_matiere_id_eleve UNIQUE (id_matiere, id_eleve);

-- 8- On se propose d'améliorer les performances de la requête n°2

--Utilisez l'index pour rechercher un élève
CREATE INDEX idx_eleves_nom_prenom
ON eleves(nom, prenom);

--Utilisez l'index pour rechercher une note
CREATE INDEX idx_notes_id_eleve
ON notes(id_eleve);

-- 9- Vérifiez maintenant le plan d’exécution de la requête n°4
SET @@explain_format=TREE;

EXPLAIN DELETE FROM notes
WHERE id_eleve = (SELECT id FROM eleves WHERE prenom = 'Léa' AND nom = 'Benoit')
	AND id_matiere = (SELECT id FROM matieres WHERE libelle = 'Allemand');

SET @@explain_format=TRADITIONAL;
  
-- On peut voir dans le plan d'exécution que les indexes sont utilisés pour récupérer les données
-- des tables `eleves` et `notes`.
-- Donc les indexes ajoutés précedemment ont contribué à l'amélioration de la performance de la requête n°4.
