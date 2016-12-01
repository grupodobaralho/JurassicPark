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
CONSTRAINT PK_AREAS PRIMARY KEY (id_Area)
);


-- -----------------------------------------------------
-- Table DINOSSAUROS
-- -----------------------------------------------------
CREATE TABLE tb_DINOSSAUROS(
id_Dino        NUMBER(7) NOT NULL,
id_Area        NUMBER(7) NOT NULL,
nome           VARCHAR(50) NOT NULL,
nomeCientífico VARCHAR(50) NOT NULL,
especie        VARCHAR(50) NOT NULL,
sexo           CHAR(1) NOT NULL,
altura         NUMBER(6,2) NOT NULL,
comprimento    NUMBER(6,2) NOT NULL,
peso           NUMBER(8,2) NOT NULL,
dieta          CHAR(1) NOT NULL,
epoca          VARCHAR(30) NOT NULL,
nascimento     DATE NOT NULL,
CONSTRAINT PK_DINOSSAUROS PRIMARY KEY (id_Dino),
CONSTRAINT FK_ARE_DIN FOREIGN KEY (id_Area) REFERENCES tb_AREAS (id_Area),
CONSTRAINT CK_SEX CHECK (sexo IN ('M', 'F')),
CONSTRAINT CK_DIET CHECK (dieta IN ('C', 'H', 'O')),
CONSTRAINT CK_NASC CHECK (nascimento >= TO_DATE('1993-06-13', 'YYYY-MM-DD'))
);


-- -----------------------------------------------------
-- Table tb_VEÍCULOS
-- -----------------------------------------------------
CREATE TABLE tb_VEICULOS(
placa           CHAR(4) NOT NULL,
modelo          VARCHAR(20) NOT NULL,
status          CHAR(1) NOT NULL,
ano             NUMBER(4) NOT NULL,
cargaMax        NUMBER(7) NOT NULL,
capTanque       NUMBER(4) NOT NULL,
ultimaRevisao   DATE NULL,
CONSTRAINT PK_VEICULOS PRIMARY KEY (placa)
);

--------------------------------------------------------
--Table tb_FUNCOES
--------------------------------------------------------
CREATE TABLE tb_FUNCOES(
id_Funcao		    NUMBER(7) NOT NULL,
funcao		      VARCHAR(20) NOT NULL,
salariobase  	  NUMBER(7,2) NOT NULL,
CONSTRAINT PK_FUNCOES PRIMARY KEY (id_Funcao)
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
CONSTRAINT FK_VEI_FUNCIOVEI FOREIGN KEY (placa) REFERENCES tb_VEICULOS (placa)
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
CONSTRAINT PK_Atracoes PRIMARY KEY (id_Atracao)
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


--VINI, seguem exemplos pra tu te basear 
INSERT INTO tb_AREAS (id_Area,nomearea, tipoTerreno, metragem, populacao, capacidadeMax, coberta, setor)
VALUES (40,'Cavernola', 'Arenoso', 2500, 13, 20,'N', 'S');

INSERT INTO tb_DINOSSAUROS (Id_Dino, Id_Area, nome, nomeCientífico, especie, sexo, altura, comprimento, peso, dieta, epoca, nascimento)
VALUES (23, 40, 'Apolo', 'Basilosaurus', 'Basilossauro', 'M', 18, 50, 36, 'C', 'Eoceno', TO_DATE('1993-08-26', 'YYYY-MM-DD'));

--VINE, ultimarevisao pode ser null, então para veículos novos não insere
INSERT INTO tb_VEICULOS (placa, modelo, status, ano, cargamax, captanque, ultimarevisao)
VALUES ('JP01', 'Jeep Turbo', 'A', 1999, 3, 100, TO_DATE('2016-08-26', 'YYYY-MM-DD'));

--As funcoes abaixo ja sao suficiente, se nao quiser nao precisa add mais nenhuma
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

--exemplo tb_FUNCIONARIOS
INSERT INTO tb_FUNCIONARIOS(id_funcionario, id_funcao, id_area, nome, idade, sexo, dataingresso, multipsal)
VALUES(1610427, 300, 40, 'ISRA', 23, 'M', TO_DATE('2016-03-01', 'YYYY-MM-DD'), 1.11);

--exemplo tb_FUNCIONARIOSVEICULOS --exemplo sem devolucao
INSERT INTO tb_FUNCIONARIOSVEICULOS(id_funcionario, placa, retirada)
VALUES (1610427, 'JP01', TO_DATE('2016-03-01', 'YYYY-MM-DD'));

--exemplo tb_ATRACOES
INSERT INTO tb_ATRACOES(id_atracao, nome, tipo, duracao, equipefunc)
VALUES(001, 'Dinos Fofinhosss', 'Kids', '90', 4);

--tb_AREASATRACOES
INSERT INTO tb_AREASATRACOES(id_area, id_atracao, qtdPublico, dataHoraEvento)
VALUES(40, 001, 200, TO_DATE('2016-03-01 15:00', 'YYYY-MM-DD HH24:MI'));


