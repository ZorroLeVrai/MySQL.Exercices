create table client (
  id int auto_increment,
  name varchar(20),
  CONSTRAINT pk_client_id PRIMARY KEY (id)
);

create table facture (
  id int auto_increment,
  client_id int not null,
  name varchar(20),
  CONSTRAINT pk_facture_id PRIMARY KEY (id),
  constraint fk_facture_client_id FOREIGN KEY (client_id) REFERENCES client(id)
);

alter table facture drop constraint fk_facture_client_id;

alter table facture add constraint fk_facture_client_id
FOREIGN KEY (client_id) REFERENCES client(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

create table facture_info (
  id int auto_increment,
  facture_id int not null,
  name varchar(20),
  CONSTRAINT pk_facture_info_id PRIMARY KEY (id),
  constraint fk_facture_info_facture_id FOREIGN KEY (facture_id) REFERENCES facture(id)
);

insert into client values (default, 'cl_1');

insert into facture values (default, 1, 'fac_1');

insert into facture_info values (default, @last_john, 'txt_1');

SELECT c.id, c.name, f.client_id, f.name, fi.facture_id, fi.name
FROM client c
INNER JOIN facture f ON c.id = f.client_id
INNER JOIN facture_info fi ON fi.facture_id = f.id;


DELETE FROM client WHERE id = 1;


