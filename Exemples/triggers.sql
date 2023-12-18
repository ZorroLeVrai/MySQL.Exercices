DELIMITER //
CREATE TRIGGER tr_after_insert_etudiant
AFTER INSERT ON etudiant
FOR EACH ROW
BEGIN
    INSERT INTO etudiant_copie
    VALUES (NEW.id_etudiant, NEW.nom, NEW.prenom);
END //
DELIMITER ;