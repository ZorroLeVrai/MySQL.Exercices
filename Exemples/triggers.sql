DELIMITER //
CREATE TRIGGER tr_after_insert_etudiant
AFTER INSERT ON etudiant
FOR EACH ROW
BEGIN
    INSERT INTO etudiant_copie
    VALUES (NEW.id_etudiant, NEW.nom, NEW.prenom);
END //
DELIMITER ;

/*************************************/

-- Tables utilisées dans l'exemple du trigger

CREATE TABLE etudiant (
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom varchar(20),
    prenom varchar(20)
);

CREATE TABLE etudiant_copie (
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom varchar(20),
    prenom varchar(20)
);
