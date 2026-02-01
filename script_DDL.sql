-- BBDD training que es troba dins del containidor Docker, crear nomes les taules
CREATE TABLE cicle ( 
    id_curs SERIAL PRIMARY KEY,
    promocio VARCHAR(50) NOT NULL
);

CREATE TABLE alumne ( 
    id_alumne SERIAL UNIQUE,
    nom VARCHAR(50) NOT NULL,
    cognom VARCHAR(50) NOT NULL,
    dni CHAR(9) PRIMARY KEY,
    telf VARCHAR(50),
    estat_alumne VARCHAR(50) CHECK (estat_alumne IN ('actiu','inactiu')),
    id_curs INT REFERENCES cicle (id_curs) ON DELETE RESTRICT
);
--SERIAL es un autoincrement nombre sencer per cada nou alumne
--UNIQUE no podem existir os alumnes amb el mateix ID
--ON DELETE RESTRICT si existeixen alumnes al cicle no es pot eliminar

CREATE TABLE avaluacio ( 
    id_avaluacio SERIAL PRIMARY KEY,
    observacio TEXT,
    treball_equip INT CHECK (treball_equip BETWEEN 0 AND 10),
    autonomia INT CHECK (autonomia BETWEEN 0 AND 10),
    comunicacio INT CHECK (comunicacio BETWEEN 0 AND 10),
    puntualitat INT CHECK (puntualitat BETWEEN 0 AND 10),
    nivell_tecnic INT CHECK (nivell_tecnic BETWEEN 0 AND 10),
    actitud INT CHECK (actitud BETWEEN 0 AND 10),
    avaluacio INT CHECK (avaluacio BETWEEN 0 AND 10),
    id_alumne INT REFERENCES alumne (id_alumne) ON DELETE CASCADE,
    id_curs INT REFERENCES cicle (id_curs) ON DELETE CASCADE  
);

--PROVA ALUMNE-AVALUACIÓ-CICLE
INSERT INTO cicle (promocio) VALUES ('ASIX-2025/26');
INSERT INTO alumne (nom, cognom, dni, id_curs) 
VALUES ('Paquito', 'el Chocolatero', '123456789', 1);
INSERT INTO avaluacio (observacio, treball_equip, autonomia, comunicacio, puntualitat, nivell_tecnic, actitud, avaluacio, id_alumne, id_curs)
VALUES ('Excel·lent', 9,8,10,9,8,9,10, 1,1);

SELECT 
id_avaluacio, observacio, treball_equip, autonomia, comunicacio, puntualitat, nivell_tecnic, actitud, avaluacio, ROUND ((treball_equip+autonomia+comunicacio+puntualitat+nivell_tecnic+actitud+avaluacio)*1.0/7,2) 
AS puntuacio
FROM avaluacio;
-- ROUND() *1.0/7,2 fes la mitjana amd decimals, mostra 2 xifres despés de la coma

SELECT * FROM cicle;
SELECT * FROM alumne;


CREATE TABLE empresa (
id_empresa SERIAL PRIMARY KEY ,
nom VARCHAR (50) NOT NULL,
sector VARCHAR (50),
contacte VARCHAR (50),
ubicacio VARCHAR (80),
modalitat_practica VARCHAR (50)
);

CREATE TABLE cv (
id_cv INT PRIMARY KEY ,
data_creacio DATE ,
actualitzacio DATE ,
enllac VARCHAR (200) ,
estat_cv VARCHAR (30),
id_alumne INT,
FOREIGN KEY (id_alumne) REFERENCES alumne (id_alumne)    
);

CREATE TABLE enviament (
id_enviament INT PRIMARY KEY ,
data_enviament DATE ,
estat VARCHAR (30) ,
notes TEXT ,
id_cv INT ,
id_empresa INT ,
FOREIGN KEY (id_cv) REFERENCES cv (id_cv) ,
FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa) 
);
