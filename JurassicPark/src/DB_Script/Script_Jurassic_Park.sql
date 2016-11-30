DROP TABLE tb_AREAS;
DROP TABLE tb_DINOSSAUROS;
DROP TABLE tb_FUNCIONARIOS;
DROP TABLE tb_VEICULOS;
DROP TABLE tb_ATRACOES;
DROP TABLE tb_FUNCIONARIOSVEICULOS;
DROP TABLE tb_AREASATRACOES;

-- -----------------------------------------------------
-- Table tb_AREAS
-- -----------------------------------------------------
CREATE TABLE tb_AREAS(
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
CREATE TABLE tb_DINOSSAUROS(
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
CONSTRAINT PK_DINOSSAUROS PRIMARY KEY (idDino),
CONSTRAINT FK_ARE_DIN FOREIGN KEY (idArea) REFERENCES tb_AREAS (idArea),
CONSTRAINT CK_SEX CHECK (sexo IN ('M', 'F')),
CONSTRAINT CK_DIET CHECK (dieta IN ('C', 'H', 'O')),
CONSTRAINT CK_NASC CHECK (nascimento >= TO_DATE('1993-06-13', 'YYYY-MM-DD'))
);

-- -----------------------------------------------------
-- Table tb_FUNCIONARIOS
-- -----------------------------------------------------
CREATE TABLE tb_FUNCIONARIOS(
idFuncionario   NUMBER(7) NOT NULL,
idArea          NUMBER(7) NOT NULL, --VINCULADA AREA
placa		    CHAR(4) NULL, --VINCULADA VEÍCULOS --Pode ser nulo?
nome            VARCHAR(50) NOT NULL,
idade           NUMBER(3) NOT NULL,           
sexo            CHAR(1) NOT NULL,
dataIngresso    DATE NOT NULL,
funcao          VARCHAR(20) NOT NULL,
CONSTRAINT PK_DINOSSAUROS PRIMARY KEY (idFuncionario),
CONSTRAINT FK_ARE_FUNC FOREIGN KEY (idArea) REFERENCES tb_AREAS (idArea),
CONSTRAINT FK_VEI_FUNC FOREIGN KEY (placa) REFERENCES tb_VEICULOS (placa)
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
CONSTRAINT PK_VEICULOS PRIMARY KEY (placa),
);

-- -----------------------------------------------------
-- Table tb_FUNCIONARIOSVEICULOS
-- -----------------------------------------------------
CREATE TABLE tb_FUNCIONARIOSVEICULOS(
idEmprestimo	NUMBER(7) NOT NULL,
idFuncionario	NUMBER(7) NOT NULL,
placa			CHAR(4) NOT NULL
retirada		DATE NOT NULL,
devolucao		DATE,
CONSTRAINT PK_EMP PRIMARY KEY (idEmprestimo),
CONSTRAINT FK_FUN FOREIGN KEY (idFuncionario) REFERENCES tb_FUNCIONARIOS (idFuncionario),
CONSTRAINT FK_VEI FOREIGN KEY (placa) REFERENCES tb_VEICULOS (placa)
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
qtdPublico      NUMBER(6) NOT NULL,
CONSTRAINT PK_ PRIMARY KEY (atracao),
CONSTRAINT FK_ARE_ATR FOREIGN KEY (idArea) REFERENCES tb_AREAS (idArea),
);

-- -----------------------------------------------------
-- Table tb_AREASATRACOES
-- -----------------------------------------------------
CREATE TABLE tb_AREASATRACOES(
idEvento	NUMBER(7),
idArea		NUMBER(7) NOT NULL,
atracao		VARCHAR(50) NOT NULL,
CONSTRAINT PK_AREASATRACOES PRIMARY KEY (idEvento),
CONSTRAINT FK_ARE_AREATR FOREIGN KEY (idArea) REFERENCES tb_AREAS (idArea),
CONSTRAINT FK_ATR_AREATR FOREIGN KEY (atracao) REFERENCES tb_ATRACOES (atracao)
);



