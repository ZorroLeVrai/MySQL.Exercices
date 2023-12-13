-- @block
-- Insertion dans la table client
INSERT INTO client (prenom) VALUES ('John');
SET @client_john = last_insert_id();
INSERT INTO client (prenom) VALUES ('Jane');
SET @client_jane = last_insert_id();

-- @block
-- Insertion des factures pour 'John'
INSERT INTO facture (client_id, libelle, prix)
VALUES (@client_john, 'AA', 12.3);
INSERT INTO facture (client_id, libelle, prix)
VALUES (@client_john, 'BB', 5);
-- Insertion des factures pour 'Jane'
INSERT INTO facture (client_id, libelle, prix)
VALUES (@client_jane, 'CC', 17);

-- @block
-- Verification
SELECT c.prenom, f.libelle, f.prix
FROM client c
INNER JOIN facture f ON f.client_id = c.client_id;