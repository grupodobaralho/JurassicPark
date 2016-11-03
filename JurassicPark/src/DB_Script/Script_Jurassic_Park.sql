DROP TABLE tb_DINOSSAUROS;
DROP TABLE tb_AREA;
DROP TABLE tb_FUNCIONARIO;
DROP TABLE tb_VEICULOS;
DROP TABLE tb_ATRACOES;

-- -----------------------------------------------------
-- Table tb_AREA
-- -----------------------------------------------------
CREATE TABLE tb_AREA(
idArea         NUMBER(7) NOT NULL,
nome           VARCHAR(50) NOT NULL,
tipoTerreno    VARCHAR(20) NOT NULL,
metragem       NUMBER(6) NOT NULL,
populacao      NUMBER(6) NOT NULL,
capacidadeMax  NUMBER(6) NOT NULL,
coberta        CHAR(1) NOT NULL,
setor          VARCHAR(2) NOT NULL,
CONSTRAINT PK_AREA PRIMARY KEY (idArea)
);

-- -----------------------------------------------------
-- Table DINOSSAUROS
-- -----------------------------------------------------
CREATE TABLE tb_DINOSSAUROS
(
idDino         NUMBER(7) NOT NULL,
idArea         NUMBER(7) NOT NULL,
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
CONSTRAINT PK_DINOSSAUROS PRIMARY KEY (id),
CONSTRAINT FK_DIN_ARE FOREIGN KEY (idArea) REFERENCES MEDICOS (idArea),
CONSTRAINT CK_AnoIng CHECK (Nascimento >= 1993),
CONSTRAINT CK_sexo CHECK (sexo IN ('M', 'F')),
CONSTRAINT CK_dieta CHECK (dieta IN ('C', 'H', 'O'))
constraint CK_nascimento check (nascimento >= '1993-06-13')
);

-- -----------------------------------------------------
-- Table tb_FUNCIONARIO
-- -----------------------------------------------------
CREATE TABLE tb_FUNCIONARIO(
idFuncionario   NUMBER(7) NOT NULL,
idArea          NUMBER(7) NOT NULL, --VINCULADA AREA
placaVeículo    CHAR(4) NOT NULL --VINCULADA VEÍCULOS --Pode ser nulo?
nome            VARCHAR(50) NOT NULL,
idade           NUMBER(3) NOT NULL,           
sexo            CHAR(1) NOT NULL,
dataIngresso    DATE NOT NULL,
funcao          VARCHAR(20) NOT NULL         
);

-- -----------------------------------------------------
-- Table tb_VEÍCULOS
-- -----------------------------------------------------
CREATE TABLE tb_VEÍCULOS(
placa           CHAR(4) NOT NULL,
modelo          VARCHAR(20) NOT NULL,
status          CHAR(1) NOT NULL,
ano             NUMBER(4) NOT NULL,
cargaMax        NUMBER(7) NOT NULL,
capTanque       NUMBER(4) NOT NULL,
ultimaRevisao   DATE NULL
);


-- -----------------------------------------------------
-- Table tb_ATRACOES
-- -----------------------------------------------------
CREATE TABLE tb_ATRACOES(
atracao         VARCHAR(50) NOT NULL,
idArea          NUMBER(7) NOT NULL, --VINCULADA AREA
placaVeículo    CHAR(4) NOT NULL, --VINCULADA VEÍCULOS
tipo            VARCHAR(20) NOT NULL,
duracao         NUMBER(3) NOT NULL,
equipeFunc      NUMBER(3) NOT NULL,
horarios        VARCHAR(10) NOT NULL,
qtdPublico      NUMBER(6) NOT NULL
);