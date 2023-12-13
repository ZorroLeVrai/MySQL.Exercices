CREATE TABLE IF NOT EXISTS titanic_passenger
(
    passengerid integer NOT NULL,
    pclass smallint NOT NULL,
    name character varying(100),
    sex character varying(10),
    age real,
    fare real,
    PRIMARY KEY (passengerid)
);

CREATE TABLE IF NOT EXISTS titanic_survival
(
	passengerid integer NOT NULL,
	Survived boolean,
	PRIMARY KEY (passengerid)
);