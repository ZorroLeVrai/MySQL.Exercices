CREATE TABLE groupe (
  groupe_id INT,
  nom VARCHAR(20),
  CONSTRAINT pk_groupe_id PRIMARY KEY (groupe_id)
);

CREATE TABLE utilisateur (
  utilisateur_id INT,
  nom VARCHAR(20),
  groupe_id INT,
  CONSTRAINT pk_utilisateur_id PRIMARY KEY (utilisateur_id),
  CONSTRAINT fk_groupe_id FOREIGN KEY (groupe_id) REFERENCES groupe(groupe_id)
);

CREATE TABLE droits (
  droit_id INT,
  groupe_id INT,
  autorisation_groupe_id INT,
  droit_lecture BOOLEAN,
  droit_ecriture BOOLEAN,
  CONSTRAINT pk_droit_id PRIMARY KEY (droit_id),
  CONSTRAINT fk_droit_grp_id FOREIGN KEY (groupe_id) REFERENCES groupe(groupe_id),
  CONSTRAINT fk_droit_aut_grp_id FOREIGN KEY (autorisation_groupe_id) REFERENCES groupe(groupe_id)
);

CREATE TABLE rdv_utilisateur (
  rdv_utilisateur_id INT,
  utilisateur_id INT,
  libelle VARCHAR(50),
  debut DATETIME,
  fin DATETIME,
  CONSTRAINT pk_rdv_utilisateur_id PRIMARY KEY (rdv_utilisateur_id),
  CONSTRAINT fk_rdv_user_id FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(utilisateur_id)
);

CREATE TABLE rdv_groupe (
  rdv_groupe_id INT,
  groupe_id INT,
  libelle VARCHAR(50),
  debut DATETIME,
  fin DATETIME,
  CONSTRAINT pk_rdv_groupe_id PRIMARY KEY (rdv_groupe_id),
  CONSTRAINT fk_rdv_grp_id FOREIGN KEY (groupe_id) REFERENCES groupe(groupe_id)
);
