DELIMITER $$
CREATE FUNCTION fpObtenirNom(id INT)
RETURNS varchar(20)
DETERMINISTIC
BEGIN
    DECLARE nomEtudiant VARCHAR(20);
    SET nomEtudiant = (SELECT nom FROM etudiant where id_etudiant = id);
    RETURN (nomEtudiant);
END $$
DELIMITER ;
