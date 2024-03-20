CREATE TABLE OBJET (
  PRIMARY KEY (id_O),
  id_O        VARCHAR(42) NOT NULL,
  nom         TEXT,
  image       BLOB,
  description TEXT,
  prix        INTEGER
);

CREATE TABLE RESULTATS (
  PRIMARY KEY (id_R),
  id_R     VARCHAR(42) NOT NULL,
  user     VARCHAR(42),
  niveau   VARCHAR(42),
  datetime VARCHAR(42),
  id_O     VARCHAR(42) NOT NULL
);

ALTER TABLE RESULTATS ADD FOREIGN KEY (id_O) REFERENCES OBJET (id_O);