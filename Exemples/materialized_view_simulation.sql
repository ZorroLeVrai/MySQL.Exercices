/******************** Partie uniquement utile pour le test ***********************/

-- Création d'une table qui servira pour l'exemple
CREATE TABLE t_data (
  id INT AUTO_INCREMENT,
  texte varchar(5),
  val int,
  CONSTRAINT pk_data_id PRIMARY KEY (id)
);

-- Remplissage de la table
INSERT INTO t_data (texte, val) 
WITH RECURSIVE fill_cte AS (
  SELECT 'AA' as texte, 1 as val
  UNION ALL
  SELECT texte, val+1 FROM fill_cte WHERE val < 1000
)
SELECT texte, val FROM fill_cte;

/******************** Partie création de la vue matérialisée ***********************/

-- Création de la table qui sert de vue matérialisée
CREATE TABLE mv_data (
  id INT,
  texte varchar(5),
  val int,
  CONSTRAINT pk_data_id PRIMARY KEY (id)
);

-- Création d'une procédure stockée simple qui raffraichit la vue matérialisée
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_refresh_view_simple()
BEGIN
  -- mais le TRUNCATE doit acquérir un WRITE LOCK (le SELECT pendant le TRUNCATE n'est pas permis)
  TRUNCATE mv_data;
  -- insertion de toutes les données (resultat d'un SELECT coûteux)
  INSERT INTO mv_data
  SELECT id, texte, val FROM t_data;
END $$
DELIMITER ;

-- Création d'une procédure stockée sans truncate (mise à jour des données)
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_refresh_view_v2()
BEGIN
  DROP TEMPORARY TABLE IF EXISTS temp_data;

  -- Cette table temporaire va contenir le resultat d'un SELECT coûteux
  CREATE TEMPORARY TABLE IF NOT EXISTS temp_data
  SELECT id, texte, val FROM t_data;

  -- Supprimer les données dans la vue matérialisée qui n'existent plus
  DELETE FROM mv_data mv
  WHERE NOT EXISTS (SELECT 1 FROM temp_data tmp WHERE tmp.id = mv.id);

  -- Insertion ou mise à jour des données
  INSERT INTO mv_data
  WITH diff AS (
    SELECT id, texte, val FROM temp_data
    EXCEPT
    SELECT id, texte, val FROM mv_data
  )
  SELECT id, texte, val FROM diff
  ON DUPLICATE KEY UPDATE texte = diff.texte, val = diff.val;

END $$
DELIMITER ;

/**************************** Tests de la procédure stockée ***************************/

-- test d'insertion
insert into t_data values (default, 'ZZ', 1001);

select * from t_data limit 5 offset 998;
select * from mv_data limit 5 offset 998;

call sp_refresh_view_v2();
select * from mv_data limit 5 offset 998;

-- test de mise à jour

update t_data set val=1078 where id = 100;

select * from t_data limit 5 offset 98;
select * from mv_data limit 5 offset 98;

call sp_refresh_view_v2();
select * from mv_data limit 5 offset 98;

-- test de suppression
delete from t_data where id = 100;

select * from t_data limit 5 offset 98;
select * from mv_data limit 5 offset 98;

call sp_refresh_view_v2();
select * from mv_data limit 5 offset 98;
