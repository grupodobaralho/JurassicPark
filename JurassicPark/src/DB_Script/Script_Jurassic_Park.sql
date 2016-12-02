DROP TABLE tb_AREASATRACOES;
DROP TABLE tb_ATRACOES;
DROP TABLE tb_FUNCIONARIOSVEICULOS;
DROP TABLE tb_FUNCIONARIOS;
DROP TABLE tb_FUNCOES;
DROP TABLE tb_VEICULOS;
DROP TABLE tb_DINOSSAUROS;
DROP TABLE tb_AREAS;

-- -----------------------------------------------------
-- Table tb_AREAS
-- -----------------------------------------------------
CREATE TABLE tb_AREAS(
id_area        NUMBER(7) NOT NULL,
nomeArea       VARCHAR(50) NOT NULL,
tipoTerreno    VARCHAR(20) NOT NULL,
metragem       NUMBER(6) NOT NULL,
populacao      NUMBER(6) NOT NULL,
capacidadeMax  NUMBER(6) NOT NULL,
coberta        CHAR(1) NOT NULL,
setor          VARCHAR(2) NOT NULL,
CONSTRAINT PK_AREAS PRIMARY KEY (id_Area),
CONSTRAINT CK_TIPO CHECK (tipoTerreno IN ('Arenoso', 'Argiloso', 'Floresta', 'Aquatico', 'Pantano','Escritorio','Laboratorio')),
CONSTRAINT CK_METR CHECK (metragem > 0),
CONSTRAINT CK_POP CHECK (populacao >= 0),
CONSTRAINT CK_COB CHECK (coberta IN ('S', 'N'))
);


-- -----------------------------------------------------
-- Table DINOSSAUROS
-- -----------------------------------------------------
CREATE TABLE tb_DINOSSAUROS(
id_Dino        NUMBER(7) NOT NULL,
id_Area        NUMBER(7) NOT NULL,
nome           VARCHAR(50) NOT NULL,
nomeCientifico VARCHAR(50) NOT NULL,
especie        VARCHAR(50) NOT NULL,
sexo           CHAR(1) NOT NULL,
altura         NUMBER(6,2) NOT NULL,
comprimento    NUMBER(6,2),
peso           NUMBER(8,2) NOT NULL,
dieta          CHAR(1) NOT NULL,
epoca          VARCHAR(30) NOT NULL,
nascimento     DATE NOT NULL,
CONSTRAINT PK_DINOSSAUROS PRIMARY KEY (id_Dino),
CONSTRAINT FK_ARE_DIN FOREIGN KEY (id_Area) REFERENCES tb_AREAS (id_Area),
CONSTRAINT CK_SEXDINO CHECK (sexo IN ('M', 'F')),
CONSTRAINT CK_ALT CHECK (altura > 0),
CONSTRAINT CK_PESO CHECK (peso > 0),
CONSTRAINT CK_DIET CHECK (dieta IN ('C', 'H', 'O')),
CONSTRAINT CK_NASC CHECK (nascimento >= TO_DATE('1975-01-01', 'YYYY-MM-DD'))
);


-- -----------------------------------------------------
-- Table tb_VEiCULOS
-- -----------------------------------------------------
CREATE TABLE tb_VEICULOS(
placa           CHAR(4) NOT NULL,
tipo            VARCHAR(50) NOT NULL,
status          CHAR(1) NOT NULL,
ano             NUMBER(4) NOT NULL,
cargaMax        NUMBER(7) NOT NULL,
capTanque       NUMBER(4) NOT NULL,
ultimaRevisao   DATE NULL,
CONSTRAINT PK_VEICULOS PRIMARY KEY (placa),
CONSTRAINT CK_STATUS CHECK (status IN ('A', 'M', 'I'))
);

--------------------------------------------------------
--Table tb_FUNCOES
--------------------------------------------------------
CREATE TABLE tb_FUNCOES(
id_Funcao		    NUMBER(7) NOT NULL,
funcao		      VARCHAR(20) NOT NULL,
salariobase  	  NUMBER(7,2) NOT NULL,
CONSTRAINT PK_FUNCOES PRIMARY KEY (id_Funcao),
CONSTRAINT CK_SB CHECK (salariobase >= 0)
);

-- -----------------------------------------------------
-- Table tb_FUNCIONARIOS
-- -----------------------------------------------------
CREATE TABLE tb_FUNCIONARIOS(
id_Funcionario  NUMBER(7) NOT NULL,
id_Funcao       NUMBER(7) NOT NULL, 
id_Area         NUMBER(7) NOT NULL,
nome            VARCHAR(50) NOT NULL,
idade           NUMBER(3) NOT NULL,           
sexo            CHAR(1) NOT NULL,
dataIngresso    DATE NOT NULL,
multipsal      NUMBER(3,2) NOT NULL,
CONSTRAINT PK_FUNCIONARIOS PRIMARY KEY (id_Funcionario),
CONSTRAINT FK_ARE_FUNCIO FOREIGN KEY (id_Area) REFERENCES tb_AREAS (id_Area),
CONSTRAINT FK_FUNC_FUNCIO FOREIGN KEY (id_Funcao) REFERENCES tb_FUNCOES (id_Funcao),
CONSTRAINT CK_IDFUNC CHECK (id_Funcionario > 1000000),
CONSTRAINT CK_SEXOFUN CHECK (sexo IN ('F', 'M')),
CONSTRAINT CK_DATAING CHECK (dataIngresso >= TO_DATE('1990-11-20', 'YYYY-MM-DD')),
CONSTRAINT CK_MULTIP CHECK (multipsal >= 1.00)
);


-- -----------------------------------------------------
-- Table tb_FUNCIONARIOSVEICULOS
-- -----------------------------------------------------
CREATE TABLE tb_FUNCIONARIOSVEICULOS(
id_Funcionario NUMBER(7) NOT NULL,
placa			     CHAR(4) NOT NULL,
km             NUMBER(7),
retirada		   DATE NOT NULL,
devolucao		   DATE,
CONSTRAINT FK_FUNCIO_FUNCIOVEI FOREIGN KEY (id_Funcionario) REFERENCES tb_FUNCIONARIOS (id_Funcionario),
CONSTRAINT FK_VEI_FUNCIOVEI FOREIGN KEY (placa) REFERENCES tb_VEICULOS (placa),
CONSTRAINT CK_KM CHECK (km > 0)
);


-- -----------------------------------------------------
-- Table tb_ATRACOES
-- -----------------------------------------------------
CREATE TABLE tb_ATRACOES(
id_Atracao      NUMBER(7) NOT NULL,
nome	          VARCHAR(50) NOT NULL,
tipo            VARCHAR(20) NOT NULL,
duracao         NUMBER(3) NOT NULL,
equipeFunc      NUMBER(3) NOT NULL,
CONSTRAINT PK_Atracoes PRIMARY KEY (id_Atracao),
CONSTRAINT CK_DUR CHECK (duracao > 0),
CONSTRAINT CK_EQUIP CHECK (equipeFunc >= 0)
);

-- -----------------------------------------------------
-- Table tb_AREASATRACOES
-- -----------------------------------------------------
CREATE TABLE tb_AREASATRACOES(
id_Area	  	    NUMBER(7) NOT NULL,
id_Atracao      NUMBER(7) NOT NULL,
qtdPublico      NUMBER(6) NOT NULL,
dataHoraEvento  DATE NOT NULL,
CONSTRAINT FK_ARE_AREATR FOREIGN KEY (id_Area) REFERENCES tb_AREAS (id_Area),
CONSTRAINT FK_ATR_AREATR FOREIGN KEY (id_Atracao) REFERENCES tb_ATRACOES (id_Atracao)
);


INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('AA98','Caminhao para funcionarios', 'A', 2001, 22, 90,  TO_DATE('2015-09-16', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('CA19','Caminhao para funcionarios', 'A', 1997, 12, 75, TO_DATE('2016-06-17' , 'YYYY-MM-DD')); 

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('AF86','Caminhao para funcionarios', 'I', 2016, 25, 200, null);

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('BK95','Caminhao de transporte de animais', 'A', 2007, 2, 100, TO_DATE('2015-02-23', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('BO08','Caminhao de transporte de animais', 'M', 2013, 5, 110, TO_DATE('2016-05-30', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('MJ48','Caminhao de transporte de animais', 'A', 2016, 10, 85, NULL); 

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('CA74','Helicoptero de passeio', 'A', 2015, 12, 150, NULL);

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('KJ95','Helicoptero de passeio', 'A', 2000, 10, 164 ,TO_DATE( '2016-08-25' , 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('TM39','Helicoptero para funcionarios', 'I', 2010, 14, 155 , TO_DATE('2016-04-11', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('YF72','Helicoptero para funcionarios', 'M', 1997, 14, 155 , TO_DATE('2016-11-11', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('GH22','Jipe para funcinarios', 'A', 2003, 7, 60 , TO_DATE('2016-11-30', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('TK91','Jipe para funcinarios', 'A', 2016, 7, 75 , NULL);

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('GT09','Jipe para funcinarios', 'M', 2007, 5, 65 , TO_DATE( '2014-09-19', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('TJ25','Translado de passeio', 'A', 2014, 20, 70 , TO_DATE('2016-09-22', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('YU63','Translado de passeio', 'A', 2016, 24, 85 , NULL);

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('OP99','Translado de passeio', 'M', 2007, 20, 70 , TO_DATE('2014-07-29', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('IK38','Barco de passeio', 'A', 2015, 150, 65 , NULL);

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('IL02','Barco de passeio', 'I', 2007, 120, 50 , TO_DATE('2015-04-19', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('PK30','Lancha para Funcionarios', 'A', 2009, 45, 8 , TO_DATE('2016-02-01', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('KM98','Lancha para Funcionarios', 'I', 2007, 40, 6 , TO_DATE('2016-04-26', 'YYYY-MM-DD'));

INSERT INTO tb_VEICULOS (placa, tipo, status, ano, cargaMax, capTanque, ultimaRevisao)
VALUES ('DL26','Lancha para Funcionarios', 'A', 2016, 60, 9 , NULL);












INSERT INTO tb_AREAS (nomearea, id_area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Deserto Triassico', 1, 'Arenoso', 2500, 13, 20,'N', 'S');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Terra de ninguem', 12, 'Argiloso', 1350, 7, 12,'N', 'NE');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Saara Triassico', 3, 'Arenoso', 500, 2, 5,'S', 'S');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Reino desertoso', 7, 'Arenoso', 3000, 1, 30,'N', 'SE');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Caverna da escuridao', 13, 'Argiloso', 800, 3, 7,'S', 'N');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Caverna triassica', 16, 'Argiloso', 730, 5, 7,'N', 'NO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Reino umido', 22, 'Argiloso', 1300, 9, 14,'S', 'N');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Argilas ancestrais', 19, 'Argiloso', 200, 1, 1,'S', 'NO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Selva jurassica', 55, 'Floresta', 3500, 25, 32,'N', 'O');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Floresta dos gigantes', 45, 'Floresta', 2250, 13,20 ,'N', 'O');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Floresta Triassica', 48, 'Floresta', 1200, 6, 10,'S', 'SO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Lar do primeiro', 44, 'Floresta', 200, 1, 1,'S', 'SO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Floresta negra', 52, 'Floresta', 7900, 42, 67,'N', 'O');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Mar dos dinossauros', 31, 'Aquatico', 3100, 9, 19,'N', 'L');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Lago jurassico', 39, 'Aquatico', 6900, 7, 55,'N', 'L');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Repouso do rei dos mares', 40, 'Aquatico', 700, 1, 1,'N', 'L');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Pantano ', 61, 'Pantano', 2850, 9, 21,'N', 'NO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Pantano Jurassico', 67, 'Pantano', 300, 2, 3,'S', 'NO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Reino pantanoso', 66, 'Pantano', 1100, 11, 11 ,'N', 'NO');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Pantano da perdiçao', 64, 'Pantano', 5750, 27, 50 ,'N', 'N');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Aquario Jurassico', 41, 'Aquatico', 1350, 4, 8,'S', 'L');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Terra dos Tirassonauros', 2, 'Arenoso', 200, 2, 2,'S', 'S');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Laboratório de pesquisas', 1000, 'Laboratorio', 700, 10, 20,'S', 'SE');

INSERT INTO tb_AREAS (nomearea,id_Area, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES ('Escritório Administrativo', 1001, 'Escritorio', 650, 12, 25,'S', 'SE');








INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (23, 40, 'Apolo', 'Basilosaurus', 'Basilossauro', 'M', 18, 36000, 'C', 'Eoceno',  TO_DATE('1983-08-26', 'YYYY-MM-DD'));
 
INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (95, 40, 'MagnaPiscis', 'Basilosaurus', 'Basilossauro', 'F', 16, 34000, 'C', 'Eoceno', TO_DATE('1999-02-27' , 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (55, 41, 'Jamaica', 'Teleosauros codomensis', 'Teleossauro', 'M', 4, 300 , 'C', 'Jurassico', TO_DATE('1989-07-22', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (151, 39, 'Jorge', 'Ichthyosauria', 'Ictiossauro', 'M', 3, 1800 , 'C', 'Triassico', TO_DATE('2002-03-17', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (11, 39, 'Fiona', 'Nothosaurus giganteus', 'Nothossauro', 'F', 8.7 , 4800 , 'C', 'Triassico', TO_DATE('1979-09-10', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (88, 1, 'Celer Bird', 'Ornithomimosaurias rastiensas', 'Ornithomimosauria', 'M', 1.1 , 180 , 'C', 'Jurassico', TO_DATE('1997-12-25', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (68, 1, 'Coyote', 'Velociraptor mongoliensis', 'Velociraptor,', 'M', 1.8 , 90 , 'C', 'Cretaceo', TO_DATE('1992-11-29', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (66, 1, 'Papa-leguas', 'Velociraptor mongoliensis', 'Velociraptor,', 'F', 2.1 , 110 , 'C', 'Cretaceo', TO_DATE('1991-8-12', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (60, 2, 'Sr.T-Rex', 'Tyrannosaurus', 'Tiranossauro,', 'M', 6.7 , 11000 , 'C', 'Cretaceo', TO_DATE('1990-10-25', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (58, 2, 'Ms.T-Rex', 'Tyrannosaurus', 'Tiranossauro,', 'F', 6 , 10500 , 'C', 'Cretaceo', TO_DATE('1988-09-02', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (103, 7, 'Nanico', 'Diplodocus', 'Diplodoco,', 'M', 45 , 37500 , 'H', 'Jurassico', TO_DATE('1999-08-19', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (19, 66, 'Rei do pantano', 'Triceratops horridus', 'Triceratops', 'M', 4 , 7000 , 'H', 'Cretaceo', TO_DATE('1982-03-11', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (22, 66, 'Rainha do pantano', 'Triceratops horridus', 'Triceratops', 'F', 3.7 , 6300 , 'H', 'Cretaceo', TO_DATE('1983-10-22', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (46, 61, 'Fiat Avis', 'Pterodactylus', 'Pterodactilo', 'F', 1.1 , 40 , 'C', 'Mesozoico', TO_DATE('1989-06-15', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (1, 44, 'Primogenitus', 'Titanosaurus giganteus', 'Titanossauro', 'M', 22 , 82000 , 'H', 'Cretaceo',  TO_DATE('1975-01-22', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (15, 48, 'Maradona', 'Argentinossaurus', 'Argentinossauro', 'M', 15 , 72000 , 'H', 'Cretaceo',  TO_DATE('1986-04-17', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (181, 48, 'Three-Horned-Devil', 'Triceratops horridus', 'Triceratops', 'M', 3.4 , 5600 , 'H', 'Cretaceo', TO_DATE('2004-2-18', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (31, 66, 'Big Ass Lizard', 'Brachiosaurus', 'Braquiossauro', 'F', 18.7 , 48000 , 'H', 'Jurassico',  TO_DATE('1985-07-30', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (96, 19, 'Bone Backed Dino', 'Spinosaurus', 'Espinossauro', 'M', 6.1 , 8500 , 'C', 'Cretaceo',  TO_DATE('1999-09-18', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (71, 12, 'Juno', 'Velociraptor mongoliensis', 'Velociraptor,', 'M', 1.7 , 100 , 'C', 'Cretaceo',  TO_DATE('1993-07-07', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (178, 1, 'Baby T-rex', 'Tyrannosaurus', 'Tiranossauro,', 'M', 5 , 8500 , 'C', 'Cretaceo', TO_DATE('2008-10-12', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (235, 66, 'Princesa do pantano', 'Triceratops horridus', 'Triceratops', 'F', 1.1 , 2300, 'H', 'Cretaceo', TO_DATE('2015-10-21', 'YYYY-MM-DD'));

INSERT INTO tb_DINOSSAUROS (id_Dino, id_Area, nome, nomeCientifico, especie, sexo, altura, peso, dieta, epoca, nascimento)
VALUES (223, 48, 'Darling', 'Argentinossaurus', 'Argentinossauro', 'F', 4 , 9900 , 'H', 'Cretaceo',  TO_DATE('2014-08-16', 'YYYY-MM-DD'));



INSERT INTO tb_FUNCOES (id_funcao, funcao, salariobase)
VALUES (100, 'Tratador', 4000);

INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
VALUES (200, 'Seguranca', 5000);

INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
VALUES (300, 'Capa_De_Chuva', 6500);

INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
VALUES (400, 'Guia', 5000);

INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
VALUES (500, 'Veterinario', 10000);

INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
VALUES (600, 'Cientista', 15000);

INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
VALUES (700, 'Administrativo', 2000);





INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1610430, 200, 44, 'Israel Deorce', 22, 'M', TO_DATE('2016-03-01', 'YYYY-MM-DD'), 1.11);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(3698524, 200, 48, 'Roberto Antunes', 44, 'M', TO_DATE('2013-08-17', 'YYYY-MM-DD'), 1.05);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1548973, 200, 66, 'Felícia Ferreira', 36, 'F', TO_DATE('2002-06-16', 'YYYY-MM-DD'), 1.5);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(3116634, 200, 1, 'Pedro Antunes', 52, 'F', TO_DATE('1994-11-22', 'YYYY-MM-DD'), 2);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1996517, 300, 1, 'Marcio Fagundes', 33, 'M', TO_DATE('2008-09-15', 'YYYY-MM-DD'), 1.6);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1886214, 300, 39, 'Andreia Paz', 29, 'F', TO_DATE('2010-09-14', 'YYYY-MM-DD'), 1.3);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1986214, 300, 66, 'Marcelo Pontiguar',52, 'M', TO_DATE('1995-09-15', 'YYYY-MM-DD'), 1.9);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1459873, 300, 3, 'Mark Andrews', 24, 'M', TO_DATE('2016-10-17', 'YYYY-MM-DD'), 1);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(5556987, 400, 2, 'Sam Neil', 69, 'M', TO_DATE('1991-02-17', 'YYYY-MM-DD'), 2.5);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1613595, 400, 7, 'Laura Dern', 54, 'F', TO_DATE('1991-07-22', 'YYYY-MM-DD'), 2.5);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(7982693, 400, 66, 'Mary Sheen', 26, 'F', TO_DATE('2011-05-16', 'YYYY-MM-DD'), 1.4);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(2643298, 400, 67, 'Ronaldo Carlos', 33, 'M', TO_DATE('2008-04-18', 'YYYY-MM-DD'), 1.5);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(6532484, 100, 3, 'João Romero',43, 'M', TO_DATE('2011-03-01', 'YYYY-MM-DD'), 1.3);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(2145682, 100, 1, 'Alan Grant', 29, 'M', TO_DATE('2014-08-07', 'YYYY-MM-DD'), 1.2);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(6389651, 100, 3, 'Alexia Murphy',39, 'F', TO_DATE('2016-04-19', 'YYYY-MM-DD'), 1);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(4235987, 100, 44, 'Sasha Grey', 28, 'F', TO_DATE('2012-06-15', 'YYYY-MM-DD'), 1.2);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(7752157, 100, 66, 'Robert Dean', 24, 'M', TO_DATE('2013-09-12', 'YYYY-MM-DD'), 1.1);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1245734, 500, 2, 'Navarro Bowmann', 52, 'M', TO_DATE('1991-03-21', 'YYYY-MM-DD'), 2.3);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1110863, 500, 55, 'Fabricio Pontes', 39, 'M', TO_DATE('2006-01-03', 'YYYY-MM-DD'), 1.6);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1459324, 500, 39, 'Lily Aldrin', 32, 'F', TO_DATE('2001-10-13', 'YYYY-MM-DD'), 1.8);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1111111, 600, 1000, 'Steven Spielberg', 69, 'M', TO_DATE('1990-11-20', 'YYYY-MM-DD'), 5);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1298641, 600, 1000, 'Peter Willians', 45, 'M', TO_DATE('1999-10-29', 'YYYY-MM-DD'), 2);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(2356876, 600, 1000, 'Brittany Newhouse', 41, 'F', TO_DATE('1998-10-07', 'YYYY-MM-DD'), 2.1);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(6359718, 700, 1001, 'Diego Arão', 39, 'M', TO_DATE('2004-11-06', 'YYYY-MM-DD'), 1.5);

INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(5741255, 700, 1001, 'Mariana Paixão', 25, 'M', TO_DATE('2015-12-02', 'YYYY-MM-DD'), 1);




INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada)
VALUES (1610430, 'AA98', TO_DATE('2016-08-11', 'YYYY-MM-DD'));

INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada)
VALUES (7982693, 'GT09', TO_DATE('2016-05-29', 'YYYY-MM-DD'));

INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada)
VALUES (6389651, 'IK38', TO_DATE('2015-08-22', 'YYYY-MM-DD'));

INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada, DEVOLUCAO )
VALUES (1110863, 'KJ95', TO_DATE('2014-08-11', 'YYYY-MM-DD') , TO_DATE('2014-09-14', 'YYYY-MM-DD' ));

INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada, DEVOLUCAO)
VALUES (2145682, 'IL02', TO_DATE('2013-11-08', 'YYYY-MM-DD'), TO_DATE('2015-10-09', 'YYYY-MM-DD'));

INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada, DEVOLUCAO)
VALUES (1459324, 'BK95', TO_DATE('2016-05-31', 'YYYY-MM-DD'), TO_DATE('2016-06-01', 'YYYY-MM-DD'));


INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(001, 'Dinos Fofinhos', 'Kids', '90', 4);

INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(002, 'Safari Selvagem', 'Família', '180', 7);

INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(003, 'Dinossauros Aquáticos', 'Familia', '60', 6);

INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(004, 'Dinos Aterrorizantes', 'Terror', '30', 3);

INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(005, 'Passeio pelos laboratórios', 'Família', '60', 3);

INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(006, 'Musical com dinossauros', 'Familia', '90', 10);

INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(007, 'Dinos caçando no seu habitat ', 'Adulto', '60', 6);



INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(40, 003, 300, TO_DATE('2016-11-30 16:00', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(40, 003, 300, TO_DATE('2016-12-01 17:35', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(41, 003, 150, TO_DATE('2016-12-07 15:20', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(41, 003, 100, TO_DATE('2016-12-04 13:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(2, 007, 15, TO_DATE('2016-11-28 18:10', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(2, 007, 15, TO_DATE('2016-12-05 09:00', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(40, 007, 8, TO_DATE('2016-11-30 19:00', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1, 007, 10, TO_DATE('2016-12-06 16:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1, 001, 150, TO_DATE('2016-11-28 10:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(31, 001, 230, TO_DATE('2016-12-03 18:00', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(66, 001, 180, TO_DATE('2016-12-09 13:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(45, 002, 20, TO_DATE('2016-11-30 17:25', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(55, 002, 25, TO_DATE('2016-12-03 08:45', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(45, 002, 25, TO_DATE('2016-12-02 16:40', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1, 002, 20, TO_DATE('2016-11-29 14:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(13, 004, 20, TO_DATE('2016-12-04 19:50', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(2, 004, 15, TO_DATE('2016-12-03 16:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(52, 004, 20, TO_DATE('2016-11-27 20:40', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(64, 004, 30, TO_DATE('2016-11-29 21:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1, 004, 25, TO_DATE('2016-11-30 20:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1000, 005, 25, TO_DATE('2016-11-30 10:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1000, 005, 35, TO_DATE('2016-11-30 16:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1000, 005, 35, TO_DATE('2016-12-03 15:30', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(2, 006, 250, TO_DATE('2016-12-01 20:40', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(66, 006, 300, TO_DATE('2016-12-04 16:50', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(64, 006, 275, TO_DATE('2016-11-29 17:35', 'YYYY-MM-DD HH24:MI'));

INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(1, 002, 20, TO_DATE('2016-11-30 18:30', 'YYYY-MM-DD HH24:MI'));




--
----exemplo tb_ATRACOES
--INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
--VALUES(001, 'Dinos Fofinhosss', 'Kids', '90', 4);
--
----tb_AREASATRACOES
--INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
--VALUES(40, 001, 200, TO_DATE('2016-03-01 15:00', 'YYYY-MM-DD HH24:MI'));



--------------------------------------------------------------------------------
--a. 5 consultas básicas envolvendo os comandos distinct, order by,
--count(*), like, in e funções de manipulação de datas.

--1) Quantidade de espécies distintas
SELECT COUNT(DISTINCT dino.especie) QTD_ESPECIES
FROM tb_dinossauros dino;

--2) Todos dinossauros do mais velho ao mais novo
SELECT dino.nome NOME, dino.especie ESPECIE, FLOOR((SYSDATE - dino.nascimento)/365) IDADE
FROM tb_dinossauros dino
ORDER BY IDADE DESC;

--3) Todas as espécies que não possuem 'sauro' no nome
SELECT DISTINCT dino.especie ESPECIE
FROM tb_dinossauros dino
WHERE dino.especie NOT LIKE '%sauro%';

--4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras
SELECT *
FROM tb_dinossauros dino
WHERE dino.sexo like 'F' AND dino.peso < 10000 AND dino.dieta like 'H';

--5) Todas os veículos que não estão ativos
SELECT veiculo.placa PLACA, veiculo.status STATUS
FROM tb_veiculos veiculo
WHERE veiculo.status IN ('M', 'I');


--------------------------------------------------------------------------------
--b. 5 consultas das quais 2 envolvam junções entre duas tabelas e 3
--envolvam junções entre três ou mais tabelas.

--1) Quantidade de dinossauros e de espécies por área
SELECT area.nomearea, COUNT(dino.id_dino) QTD_DINOS, COUNT(DISTINCT dino.especie)
FROM tb_dinossauros dino INNER JOIN tb_areas area ON dino.id_area = area.id_area
GROUP BY area.nomearea;

--2) Quantidade de funcionarios por funcao
SELECT funcao.funcao FUNCAO, COUNT(func.id_funcionario) QTD_FUNCIONARIOS
FROM tb_funcoes funcao INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao
GROUP BY funcao.funcao
ORDER BY FUNCAO;

--3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
SELECT dino.nome, atracao.nome EVENTO, area.nomearea AREA, TO_CHAR(evento.datahoraevento, 'dd/mm/yyyy hh24:mi') HORA, evento.qtdpublico CAPACIDADE
FROM tb_dinossauros dino
    INNER JOIN tb_areas area ON dino.id_area = area.id_area
    INNER JOIN tb_areasatracoes evento ON area.id_area = evento.id_area
    INNER JOIN tb_atracoes atracao ON atracao.id_atracao = evento.id_atracao
WHERE dino.nomeCientifico LIKE 'Tyranosaurus%' AND evento.datahoraevento >= SYSDATE;

--4) Retorna os veículos que estão com algum funcionário
SELECT vec.placa PLACA, func.nome NOME, funcvec.retirada RETIRADA, funcvec.devolucao DEVOLUCAO
FROM tb_veiculos vec
    INNER JOIN tb_funcionariosveiculos funcvec ON vec.placa = funcvec.placa
    INNER JOIN tb_funcionarios func ON funcvec.id_funcionario = func.id_funcionario
WHERE funcvec.devolucao IS NULL;

--5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área
SELECT area.nomearea AREA, COUNT(DISTINCT func.id_funcionario) QTD_FUNCIONARIOS, COUNT(DISTINCT dino.id_dino) QTD_DINOS, ROUND(COUNT(DISTINCT func.id_funcionario)/COUNT(dino.id_dino),2) RELACAO
FROM tb_funcionarios func
    INNER JOIN tb_areas area ON func.id_area = area.id_area
    INNER JOIN tb_dinossauros dino ON area.id_area = dino.id_area
GROUP BY (area.nomearea);


--------------------------------------------------------------------------------
--c. 5 consultas envolvendo group by e having, juntamente com funções
--de agregação.

--1) Retorna quantidade de veículos por ano
SELECT veiculo.ano ANO, COUNT(veiculo.ano) FROTA
FROM tb_veiculos veiculo
GROUP BY veiculo.ano
ORDER BY ANO;

--2)Retorna a media salarial dos funcionários por área
SELECT area.nomearea AREA, ROUND(AVG(func.multipsal*funcao.salariobase),2) MEDIA_SALARIAL
FROM tb_funcoes funcao
    INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao
    INNER JOIN tb_areas area ON func.id_area = area.id_area
GROUP BY area.nomearea
ORDER BY MEDIA_SALARIAL;

--3)Status da capacidade de transporte da frota
SELECT vec.status STATUS, SUM(vec.cargamax) CAPACIDADE_TRANSPORTE
FROM tb_veiculos vec
GROUP BY vec.status;

--4)Mostra as areas em que o menor salário é ao menos 6000
SELECT area.nomearea AREA, MIN(func.multipsal*funcao.salariobase) SALARIO
FROM tb_funcoes funcao
    INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao
    INNER JOIN tb_areas area ON func.id_area = area.id_area
GROUP BY area.nomearea
HAVING MIN(func.multipsal*funcao.salariobase) >= 6000;

--5)Mostra as áreas que tiverem ao total menos de 500 pessoas de público no último mês
SELECT area.nomearea AREA, SUM(qtdpublico) PUBLICO_MES
FROM tb_areas area INNER JOIN tb_areasatracoes aa
ON area.id_area = aa.id_area
WHERE aa.datahoraevento BETWEEN SYSDATE - 30 AND SYSDATE
GROUP BY area.nomearea
HAVING (SUM(qtdpublico) < 500);

--------------------------------------------------------------------------------
--d. 5 consultas envolvendo sub-consultas.

--1) Nome e altura dos dinossauros que habitam areas maiores de 5000m2
SELECT dino.nome NOME, dino.altura ALTURA
FROM tb_dinossauros dino
WHERE dino.id_dino IN 
  (SELECT dino2.id_dino
    FROM tb_dinossauros dino2 INNER JOIN tb_areas area ON dino2.id_area = area.id_area
    WHERE area.metragem > 5000);

--2) Nome e altura dos dinossauros que habitam areas maiores de 5000m2
SELECT func.nome NOME, func.sexo SEXO
FROM tb_funcionarios func
WHERE func.id_funcionario IN 
  (SELECT func2.id_funcionario
    FROM tb_funcionarios func2 INNER JOIN tb_areas area ON func2.id_area = area.id_area
    WHERE area.tipoterreno LIKE 'Arenoso')
ORDER BY SEXO, NOME;

--3)Mostra funcionarios que trabalham no S
SELECT func.nome NOME, area.setor SETOR
FROM tb_funcionarios func INNER JOIN tb_areas area ON func.id_area = area.id_area
WHERE area.id_area IN
    (SELECT area2.id_area
    FROM tb_areas area2
    WHERE area.setor LIKE 'S');

--4)Mostra funções que trabalham no coberto e as áreas 
SELECT DISTINCT funcao.funcao FUNCAO, area.nomearea AREA
FROM tb_funcoes funcao
    INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao
    INNER JOIN tb_areas area ON func.id_area = area.id_area
WHERE area.id_area IN
    (SELECT area2.id_area
    FROM tb_areas area2
    WHERE coberta LIKE 'S');