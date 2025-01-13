DROP SCHEMA IF EXISTS transmusicales CASCADE;
create schema transmusicales;
set schema 'transmusicales';

create table _groupe_artiste(
    id_groupe_artiste VARCHAR(10) NOT NULL PRIMARY KEY,
    nom_groupe_artiste VARCHAR(25) NOT NULL,
    site_web VARCHAR(50)
);

create table _annee(
    an VARCHAR(10) NOT NULL PRIMARY KEY
);

create table _concert(
    no_concert VARCHAR(30) PRIMARY KEY NOT NULL,
    titre VARCHAR(30) NOT NULL,
    resume  VARCHAR(150) NOT NULL,
    duree INTEGER NOT NULL, 
    tarif FLOAT NOT NULL
);

create table _pays(
    nom_p VARCHAR(30) PRIMARY KEY NOT NULL
);


create table _ville(
    nom_v VARCHAR(30) PRIMARY KEY
);


create table _edition(
    nom_edition VARCHAR(30) NOT NULL PRIMARY KEY,
    no_concert VARCHAR(30) NOT NULL
);


create table _lieu(
    id_lieu CHAR(3) PRIMARY KEY NOT NULL,
    nom_lieu VARCHAR(30) NOT NULL,
    accesPMR BOOLEAN NOT NULL,
    capacite_max INTEGER NOT NULL,
    type_lieu VARCHAR(30) NOT NULL
);

create table _type_musique(
    type_m VARCHAR(30) PRIMARY KEY NOT NULL
);

create table _representation(
    numero_representation VARCHAR(30) PRIMARY KEY NOT NULL,
    heure VARCHAR(10) NOT NULL,
    date_representation DATE
);

create table _formation(
    libelle_formation VARCHAR(30) PRIMARY KEY NOT NULL
);

------------------------------------------------------------------------
create table _debut(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    an VARCHAR(10) NOT NULL,
    CONSTRAINT _debut_pk PRIMARY KEY (id_groupe_artiste,an),
    CONSTRAINT _debut_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _debut_fk_annee FOREIGN KEY (an) REFERENCES _annee(an)
);

create table _sortie_discographie(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    an VARCHAR(10) NOT NULL,
    CONSTRAINT _sortie_discographie_pk PRIMARY KEY (id_groupe_artiste,an),
    CONSTRAINT _sortie_discographie_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _sortie_discographie_fk_annee FOREIGN KEY (an) REFERENCES _annee(an)
);

create table _a_pour_origine(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    nom_p VARCHAR(30) NOT NULL,
    CONSTRAINT _a_pour_origine_pk PRIMARY KEY (id_groupe_artiste,nom_p),
    CONSTRAINT _a_pour_origine_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _a_pour_origine_fk__pays FOREIGN KEY (nom_p) REFERENCES _pays(nom_p)
);

create table _se_situe(
    nom_v VARCHAR(30) NOT NULL,
    nom_p VARCHAR(30) NOT NULL,
    CONSTRAINT _se_situe_pk PRIMARY KEY (nom_v,nom_p),
    CONSTRAINT _se_situe_fk__ville FOREIGN KEY (nom_v) REFERENCES _ville(nom_v),
    CONSTRAINT _se_situe_fk__pays FOREIGN KEY (nom_p) REFERENCES _pays(nom_p)
);

create table _annee_edition(
    nom_edition VARCHAR(30) NOT NULL,
    an VARCHAR(10) NOT NULL,
    CONSTRAINT _annee_edition_pk PRIMARY KEY (nom_edition,an),
    CONSTRAINT _annee_edition_fk__edition FOREIGN KEY (nom_edition) REFERENCES _edition(nom_edition),
    CONSTRAINT _annee_edition_fk__annee FOREIGN KEY (an) REFERENCES _annee(an)
);

create table _dans(
    id_lieu VARCHAR(10) NOT NULL,
    nom_v VARCHAR(30) NOT NULL,
    CONSTRAINT _dans_pk PRIMARY KEY (id_lieu,nom_v),
    CONSTRAINT _dans_fk__lieu FOREIGN KEY (id_lieu) REFERENCES _lieu(id_lieu),
    CONSTRAINT _dans_fk__ville FOREIGN KEY (nom_v) REFERENCES _ville(nom_v)
);

create table _se_deroule(
    nom_edition VARCHAR(30)  NOT NULL,
    no_concert VARCHAR(30) NOT NULL,
    CONSTRAINT _se_deroule_pk PRIMARY KEY (nom_edition,no_concert),
    CONSTRAINT _se_deroule_fk__edition FOREIGN KEY (nom_edition) REFERENCES _edition(nom_edition),
    CONSTRAINT _se_deroule_fk__concert FOREIGN KEY (no_concert) REFERENCES _concert(no_concert)
);


create table _est_de(
    no_concert VARCHAR(30) NOT NULL,
    type_m VARCHAR(30) NOT NULL,
    CONSTRAINT _est_de_pk PRIMARY KEY (no_concert,type_m),
    CONSTRAINT _est_de_fk__concert FOREIGN KEY (no_concert) REFERENCES _concert(no_concert),
    CONSTRAINT _est_de_fk__type_musique FOREIGN KEY (type_m) REFERENCES _type_musique(type_m)
);

create table _correspond_a(
    no_concert VARCHAR(30) NOT NULL,
    numero_representation VARCHAR(30) NOT NULL,
    CONSTRAINT _correspond_a_pk PRIMARY KEY (no_concert,numero_representation),
    CONSTRAINT _correspond_a_fk__concert FOREIGN KEY (no_concert) REFERENCES _concert(no_concert),
    CONSTRAINT _correspond_a_fk_representation FOREIGN KEY (numero_representation) REFERENCES _representation(numero_representation)
);

create table _a_pour(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    libelle_formation VARCHAR(30) NOT NULL,
    CONSTRAINT _a_pour_pk PRIMARY KEY (id_groupe_artiste,libelle_formation),
    CONSTRAINT _a_pour_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _a_pour_fk__formation FOREIGN KEY (libelle_formation) REFERENCES _formation(libelle_formation)
);

create table _type_ponctuel(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    type_m VARCHAR(30) NOT NULL,
    CONSTRAINT _type_ponctuel_pk PRIMARY KEY (id_groupe_artiste,type_m),
    CONSTRAINT _type_ponctuel_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _type_ponctuel_fk__type_musique FOREIGN KEY (type_m) REFERENCES _type_musique(type_m)
);
create table _type_principal(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    type_m VARCHAR(30) NOT NULL,
    CONSTRAINT _type_principal_pk PRIMARY KEY (id_groupe_artiste,type_m),
    CONSTRAINT _type_principal_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _type_principal_fk__type_musique FOREIGN KEY (type_m) REFERENCES _type_musique(type_m)
);
create table _joue_par(
    id_groupe_artiste VARCHAR(10) NOT NULL,
    numero_representation VARCHAR(30) NOT NULL,
    CONSTRAINT _joue_par_pk PRIMARY KEY (id_groupe_artiste,numero_representation),
    CONSTRAINT _joue_par_fk__groupe_artiste FOREIGN KEY (id_groupe_artiste) REFERENCES _groupe_artiste(id_groupe_artiste),
    CONSTRAINT _joue_par_fk__representation FOREIGN KEY (numero_representation) REFERENCES _representation(numero_representation)
);

create table _a_lieu_dans(
    numero_representation VARCHAR(30) NOT NULL,
    id_lieu VARCHAR(10) NOT NULL,
    CONSTRAINT _a_lieu_dans_pk PRIMARY KEY (numero_representation,id_lieu),
    CONSTRAINT _a_lieu_dans_fk__representation FOREIGN KEY (numero_representation) REFERENCES _representation(numero_representation),
    CONSTRAINT _a_lieu_dans_fk__lieu FOREIGN KEY (id_lieu) REFERENCES _lieu(id_lieu)
);