DROP DATABASE IF EXISTS MLR2;

CREATE DATABASE IF NOT EXISTS MLR2;
USE MLR2;
# -----------------------------------------------------------------------------
#       TABLE : ETUDIANTS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANTS
 (
   NUM_ETUDIANT BIGINT NOT NULL AUTOINCREMENT ,
   ID_ABONNE INTEGER NOT NULL  ,
   NOM_ETUDIANT TEXT NULL  
   , PRIMARY KEY (NUM_ETUDIANT) 
   , UNIQUE INDEX I_I_ABONNES (ID_ABONNE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ABONNES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ABONNES
 (
   ID_ABONNE INTEGER NOT NULL AUTOINCREMENT ,
   EMAIL TEXT NULL  ,
   PASSWORD TEXT NULL  ,
   ROLE TEXT NULL  ,
   NBR_DE_RETARD INTEGER NULL  ,
   NBR_EN_RETARD INTEGER NULL  
   , PRIMARY KEY (ID_ABONNE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENSEIGNANTS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENSEIGNANTS
 (
   ID_ENSEIGNANT TEXT NOT NULL AUTOINCREMENT ,
   ID_ABONNE INTEGER NOT NULL  ,
   NOM_ENSEIGNANT TEXT NULL  
   , PRIMARY KEY (ID_ENSEIGNANT) 
   , UNIQUE INDEX I_I_ABONNES1 (ID_ABONNE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : LIVRES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LIVRES
 (
   ID_LIVRE INTEGER NOT NULL AUTOINCREMENT ,
   TITRE TEXT NULL  ,
   TOME SMALLINT NULL  ,
   EDITION TEXT NULL  ,
   DATE_SORTIE DATE NULL  ,
   RESUME TEXT NULL  ,
   CATEGORIE TEXT NULL  ,
   NBR_PAGE BIGINT NULL  ,
   STATUT TEXT NULL  ,
   NB_EXEMPLAIRE SMALLINT NULL  ,
   NB_EXEMPLAIRE_EMPRUNTE SMALLINT NULL  ,
   NB_EXEMPLAIRE_RESTANT SMALLINT NULL  
   , PRIMARY KEY (ID_LIVRE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : BIBLIOTHECAIRES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS BIBLIOTHECAIRES
 (
   ID_BIBLIOTHECAIRE INTEGER NOT NULL AUTOINCREMENT ,
   VOLUME_HORAIRE INTEGER NULL  
   , PRIMARY KEY (ID_BIBLIOTHECAIRE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CATEGORIES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CATEGORIES
 (
   ID_CAT INTEGER NOT NULL AUTOINCREMENT ,
   LIBELLE TEXT NOT NULL  
   , PRIMARY KEY (ID_CAT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : EMPRUNTS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EMPRUNTS
 (
   ID_EMPRUNT INTEGER NOT NULL AUTOINCREMENT ,
   ID_EXEMPLAIRE INTEGER NOT NULL  ,
   ID_ABONNE INTEGER NOT NULL  ,
   ID_LIVRE INTEGER NOT NULL  ,
   ID_BIBLIOTHECAIRE INTEGER NOT NULL  ,
   DATE_RESERVATION DATE NULL  ,
   DATE_EMPRUNT DATE NULL  ,
   DATE_RETOUR_PREVUE DATE NULL  ,
   DATE_RETOUR_EFFECTIVE DATE NULL  
   , PRIMARY KEY (ID_EMPRUNT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE EMPRUNTS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_EMPRUNTS_EXEMPLAIRES
     ON EMPRUNTS (ID_LIVRE ASC,ID_EXEMPLAIRE ASC);

CREATE  INDEX I_FK_EMPRUNTS_ABONNES
     ON EMPRUNTS (ID_ABONNE ASC);

CREATE  INDEX I_FK_EMPRUNTS_BIBLIOTHECAIRES
     ON EMPRUNTS (ID_BIBLIOTHECAIRE ASC);

# -----------------------------------------------------------------------------
#       TABLE : EXEMPLAIRES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EXEMPLAIRES
 (
   ID_LIVRE INTEGER NOT NULL  ,
   ID_EXEMPLAIRE INTEGER NOT NULL  
   , PRIMARY KEY (ID_LIVRE,ID_EXEMPLAIRE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE EXEMPLAIRES
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_EXEMPLAIRES_LIVRES
     ON EXEMPLAIRES (ID_LIVRE ASC);

# -----------------------------------------------------------------------------
#       TABLE : INTERAGIR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS INTERAGIR
 (
   ID_BIBLIOTHECAIRE INTEGER NOT NULL  ,
   ID_LIVRE INTEGER NOT NULL  ,
   ID_LIVRE_1 INTEGER NOT NULL  ,
   TIMESTAMP DATETIME NULL  
   , PRIMARY KEY (ID_BIBLIOTHECAIRE,ID_LIVRE,ID_LIVRE_1) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE INTERAGIR
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_INTERAGIR_BIBLIOTHECAIRES
     ON INTERAGIR (ID_BIBLIOTHECAIRE ASC);

CREATE  INDEX I_FK_INTERAGIR_LIVRES
     ON INTERAGIR (ID_LIVRE ASC);

CREATE  INDEX I_FK_INTERAGIR_LIVRES_2
     ON INTERAGIR (ID_LIVRE_1 ASC);

# -----------------------------------------------------------------------------
#       TABLE : CLASSER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CLASSER
 (
   ID_LIVRE INTEGER NOT NULL  ,
   ID_CAT INTEGER NOT NULL  ,
   ID_LIVRE_1 INTEGER NOT NULL  
   , PRIMARY KEY (ID_LIVRE,ID_CAT,ID_LIVRE_1) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE CLASSER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CLASSER_LIVRES
     ON CLASSER (ID_LIVRE ASC);

CREATE  INDEX I_FK_CLASSER_CATEGORIES
     ON CLASSER (ID_CAT ASC);

CREATE  INDEX I_FK_CLASSER_LIVRES_2
     ON CLASSER (ID_LIVRE_1 ASC);

# -----------------------------------------------------------------------------
#       TABLE : TCHATER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TCHATER
 (
   ID_ABONNE INTEGER NOT NULL  ,
   ID_BIBLIOTHECAIRE INTEGER NOT NULL  ,
   MESSAGE TEXT NULL  ,
   DATE_TCHAT DATETIME NULL  
   , PRIMARY KEY (ID_ABONNE,ID_BIBLIOTHECAIRE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE TCHATER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_TCHATER_ABONNES
     ON TCHATER (ID_ABONNE ASC);

CREATE  INDEX I_FK_TCHATER_BIBLIOTHECAIRES
     ON TCHATER (ID_BIBLIOTHECAIRE ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE ETUDIANTS 
  ADD FOREIGN KEY FK_ETUDIANTS_ABONNES (ID_ABONNE)
      REFERENCES ABONNES (ID_ABONNE) ;


ALTER TABLE ENSEIGNANTS 
  ADD FOREIGN KEY FK_ENSEIGNANTS_ABONNES (ID_ABONNE)
      REFERENCES ABONNES (ID_ABONNE) ;


ALTER TABLE EMPRUNTS 
  ADD FOREIGN KEY FK_EMPRUNTS_EXEMPLAIRES (ID_LIVRE,ID_EXEMPLAIRE)
      REFERENCES EXEMPLAIRES (ID_LIVRE,ID_EXEMPLAIRE) ;


ALTER TABLE EMPRUNTS 
  ADD FOREIGN KEY FK_EMPRUNTS_ABONNES (ID_ABONNE)
      REFERENCES ABONNES (ID_ABONNE) ;


ALTER TABLE EMPRUNTS 
  ADD FOREIGN KEY FK_EMPRUNTS_BIBLIOTHECAIRES (ID_BIBLIOTHECAIRE)
      REFERENCES BIBLIOTHECAIRES (ID_BIBLIOTHECAIRE) ;


ALTER TABLE EXEMPLAIRES 
  ADD FOREIGN KEY FK_EXEMPLAIRES_LIVRES (ID_LIVRE)
      REFERENCES LIVRES (ID_LIVRE) ;


ALTER TABLE INTERAGIR 
  ADD FOREIGN KEY FK_INTERAGIR_BIBLIOTHECAIRES (ID_BIBLIOTHECAIRE)
      REFERENCES BIBLIOTHECAIRES (ID_BIBLIOTHECAIRE) ;


ALTER TABLE INTERAGIR 
  ADD FOREIGN KEY FK_INTERAGIR_LIVRES (ID_LIVRE)
      REFERENCES LIVRES (ID_LIVRE) ;


ALTER TABLE INTERAGIR 
  ADD FOREIGN KEY FK_INTERAGIR_LIVRES_2 (ID_LIVRE_1)
      REFERENCES LIVRES (ID_LIVRE) ;


ALTER TABLE CLASSER 
  ADD FOREIGN KEY FK_CLASSER_LIVRES (ID_LIVRE)
      REFERENCES LIVRES (ID_LIVRE) ;


ALTER TABLE CLASSER 
  ADD FOREIGN KEY FK_CLASSER_CATEGORIES (ID_CAT)
      REFERENCES CATEGORIES (ID_CAT) ;


ALTER TABLE CLASSER 
  ADD FOREIGN KEY FK_CLASSER_LIVRES_2 (ID_LIVRE_1)
      REFERENCES LIVRES (ID_LIVRE) ;


ALTER TABLE TCHATER 
  ADD FOREIGN KEY FK_TCHATER_ABONNES (ID_ABONNE)
      REFERENCES ABONNES (ID_ABONNE) ;


ALTER TABLE TCHATER 
  ADD FOREIGN KEY FK_TCHATER_BIBLIOTHECAIRES (ID_BIBLIOTHECAIRE)
      REFERENCES BIBLIOTHECAIRES (ID_BIBLIOTHECAIRE) ;

