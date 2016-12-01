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























----VINI, seguem exemplos pra tu te basear 
--INSERT INTO tb_AREAS (id_Area,nomearea, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
--VALUES (40,'Cavernola', 'Arenoso', 2500, 13, 20,'N', 'S');
--
--INSERT INTO tb_DINOSSAUROS (Id_Dino, Id_Area, nome, nomeCientífico, especie, sexo, altura, peso, dieta, epoca, nascimento)
--VALUES (23, 40, 'Apolo', 'Basilosaurus', 'Basilossauro', 'M', 18, 36, 'C', 'Eoceno', TO_DATE('1993-08-26', 'YYYY-MM-DD'));
--
----VINE, ultimarevisao pode ser null, então para veículos novos não insere
--INSERT INTO tb_VEICULOS (placa, modelo, status, ano, cargamax, captanque, ultimarevisao)
--VALUES ('JP01', 'Jeep Turbo', 'A', 1999, 3, 100, TO_DATE('2016-08-26', 'YYYY-MM-DD'));
--
----As funcoes abaixo ja sao suficiente, se nao quiser nao precisa add mais nenhuma
--INSERT INTO tb_FUNCOES (id_funcao, funcao, salariobase)
--VALUES (100, 'Tratador', 4000);
--
--INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
--VALUES (200, 'Seguranca', 5000);
--
--INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
--VALUES (300, 'Capa_De_Chuva', 6500);
--
--INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
--VALUES (400, 'Guia', 5000);
--
--INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
--VALUES (500, 'Veterinario', 10000);
--
--INSERT INTO tb_Funcoes (id_funcao, funcao, salariobase)
--VALUES (600, 'Cientista', 15000);
--
----exemplo tb_FUNCIONARIOS
--INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
--VALUES(1610427, 300, 40, 'ISRA', 23, 'M', TO_DATE('2016-03-01', 'YYYY-MM-DD'), 1.11);
--
----exemplo tb_FUNCIONARIOSVEICULOS --exemplo sem devolucao
--INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada)
--VALUES (1610427, 'JP01', TO_DATE('2016-03-01', 'YYYY-MM-DD'));
--
----exemplo tb_ATRACOES
--INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
--VALUES(001, 'Dinos Fofinhosss', 'Kids', '90', 4);
--
----tb_AREASATRACOES
--INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
--VALUES(40, 001, 200, TO_DATE('2016-03-01 15:00', 'YYYY-MM-DD HH24:MI'));

