-- @block
-- insertion des élèves
INSERT INTO eleve (prenom, nom, date_naissance)
VALUES ('Gaston', 'Pourquier', '1943-02-22');
SET @eleve_gaston = last_insert_id();

INSERT INTO eleve (prenom, nom, date_naissance)
VALUES ('Harry', 'Potter', str_to_date('15/10/91', '%d/%m/%Y'));
SET @eleve_harry = last_insert_id();

-- @block
-- insertion des matières
INSERT INTO matiere (libelle) VALUES ('Français');
SET @matiere_francais = last_insert_id();

INSERT INTO matiere (libelle) VALUES ('Magie');
SET @matiere_magie = last_insert_id();

INSERT INTO matiere (libelle) VALUES ('Math');
SET @matiere_math = last_insert_id();

INSERT INTO matiere (libelle) VALUES ('Histoire');
SET @matiere_histoire = last_insert_id();

-- @block
-- insertion manuelle des inscriptions
INSERT INTO inscription VALUES (@eleve_gaston, @matiere_francais);
INSERT INTO inscription VALUES (@eleve_gaston, @matiere_histoire);
INSERT INTO inscription VALUES (@eleve_gaston, @matiere_math);
INSERT INTO inscription VALUES (@eleve_harry, @matiere_magie);
INSERT INTO inscription VALUES (@eleve_harry, @matiere_histoire);

-- @block
-- insertion manuelle des notes
INSERT INTO note
VALUES (DEFAULT, 18, CURRENT_DATE, 'Terminale Sem1', @matiere_magie, @eleve_harry);
INSERT INTO note
VALUES (DEFAULT, 10, CURRENT_DATE, 'Terminale Sem1', @matiere_histoire, @eleve_harry);
INSERT INTO note
VALUES (DEFAULT, 15, CURRENT_DATE, 'Terminale Sem1', @matiere_francais, @eleve_gaston);
INSERT INTO note
VALUES (DEFAULT, 17, CURRENT_DATE, 'Terminale Sem1', @matiere_histoire, @eleve_gaston);
INSERT INTO note
VALUES (DEFAULT, 16, CURRENT_DATE, 'Terminale Sem1', @matiere_math, @eleve_gaston);

-- @block
-- Verification inscription
SELECT e.prenom, e.nom, m.libelle
FROM inscription i
INNER JOIN eleve e ON e.id = i.id_eleve 
INNER JOIN matiere m ON m.id = i.id_matiere;

-- @block
-- Verification notes
SELECT e.prenom, e.nom, m.libelle, n.score
FROM note n
INNER JOIN eleve e ON e.id = n.id_eleve 
INNER JOIN matiere m ON m.id = n.id_matiere;