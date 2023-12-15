-- @block
CREATE TABLE IF NOT EXISTS eleve (
  id INT AUTO_INCREMENT,
  nom VARCHAR(20) NOT NULL,
  prenom VARCHAR(20) NOT NULL,
  date_naissance DATE,
  CONSTRAINT pk_eleve_id PRIMARY KEY (id)
);
-- @block
CREATE TABLE IF NOT EXISTS matiere (
  id INT AUTO_INCREMENT,
  libelle VARCHAR(20) NOT NULL,
  CONSTRAINT pk_matiere_id PRIMARY KEY (id)
);
-- @block
CREATE TABLE IF NOT EXISTS inscription (
  id_eleve INT,
  id_matiere INT,
  CONSTRAINT pk_inscription_eleve_matiere_id PRIMARY KEY (id_eleve, id_matiere),
  CONSTRAINT fk_sui_mat_eleve FOREIGN KEY(id_eleve) REFERENCES eleve(id),
  CONSTRAINT fk_sui_mat_matiere FOREIGN KEY(id_matiere) REFERENCES matiere(id)
);
-- @block
CREATE TABLE IF NOT EXISTS note (
  id INT AUTO_INCREMENT,
  score DECIMAL(4,2) NOT NULL,
  date DATE,
  libelle_semestre VARCHAR(20) NOT NULL,
  id_matiere INT,
  id_eleve INT,
  CONSTRAINT pk_note_id PRIMARY KEY (id),
  CONSTRAINT fk_note_eleve FOREIGN KEY(id_eleve) REFERENCES eleve(id),
  CONSTRAINT fk_note_matiere FOREIGN KEY(id_matiere) REFERENCES matiere(id)
);