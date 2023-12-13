-- @block
-- création de la table client
CREATE TABLE IF NOT EXISTS client (
  client_id INT AUTO_INCREMENT,
  prenom VARCHAR(20) NOT NULL,
  CONSTRAINT pk_client_id PRIMARY KEY (client_id)
);
-- @block
-- création de la table facture
CREATE TABLE IF NOT EXISTS facture (
  facture_id INT AUTO_INCREMENT,
  client_id INT NOT NULL,
  libelle VARCHAR(20) NOT NULL,
  prix DECIMAL(10, 2) NOT NULL,
  CONSTRAINT pk_facture_id PRIMARY KEY (facture_id),
  CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES client(client_id)
);