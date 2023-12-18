DELIMITER //
CREATE PROCEDURE spInsererEtudiant(IN nom VARCHAR(20), IN prenom VARCHAR(20))
BEGIN
    INSERT INTO etudiant (nom, prenom) VALUES (nom, prenom);
END //
DELIMITER ;
