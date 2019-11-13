-- MySQL Script generated by MySQL Workbench
-- Wed Nov 13 22:04:01 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering


-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS 'mydb' DEFAULT CHARACTER SET utf8 ;
USE 'mydb' ;

-- -----------------------------------------------------
-- Table 'mydb'.'Familia'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Familia' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Familia' (
  'nombre' VARCHAR(45) NOT NULL,
  'incompatible' VARCHAR(45) NULL,
  PRIMARY KEY ('nombre'))
;


-- -----------------------------------------------------
-- Table 'mydb'.'Enfermedad'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Enfermedad' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Enfermedad' (
  'nombre' VARCHAR(45) NOT NULL,
  'sintoma' VARCHAR(45) NULL,
  PRIMARY KEY ('nombre'))
;


-- -----------------------------------------------------
-- Table 'mydb'.'Familia_Enfermedad'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Familia_Enfermedad' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Familia_Enfermedad' (
  'nombre_enfermedad' VARCHAR(45) NOT NULL,
  'nombre_familia' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('nombre_enfermedad', 'nombre_familia'),
  INDEX 'fk_Familia_Enfermedad_2_idx' ('nombre_familia' ASC) VISIBLE,
  CONSTRAINT 'enfermedad'
    FOREIGN KEY ('nombre_enfermedad')
    REFERENCES 'mydb'.'Enfermedad' ('nombre')
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT 'familia'
    FOREIGN KEY ('nombre_familia')
    REFERENCES 'mydb'.'Familia' ('nombre')
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table 'mydb'.'Laboratorio'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Laboratorio' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Laboratorio' (
  'codigo' INT NOT NULL,
  'contacto' VARCHAR(45) NULL,
  'nombre' VARCHAR(45) NULL,
  'codigo_postal' INT NULL,
  'telefono' INT NULL,
  PRIMARY KEY ('codigo'))
;


-- -----------------------------------------------------
-- Table 'mydb'.'Medicamento'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Medicamento' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Medicamento' (
  'codigo' INT NOT NULL,
  'nombre' VARCHAR(45) NULL,
  'igic' INT NULL,
  'posologia' VARCHAR(45) NULL,
  'precio' FLOAT NULL,
  'tipo' VARCHAR(45) NOT NULL,
  'laboratorio' INT NOT NULL,
  PRIMARY KEY ('codigo'),
  INDEX 'fk_Medicamento_1_idx' ('laboratorio' ASC) VISIBLE,
  CONSTRAINT 'fk_Medicamento_1'
    FOREIGN KEY ('laboratorio')
    REFERENCES 'mydb'.'Laboratorio' ('codigo')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table 'mydb'.'Familia_medicamento'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Familia_medicamento' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Familia_medicamento' (
  'codigo_medicamento' INT NOT NULL,
  'nombre_familia' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('codigo_medicamento', 'nombre_familia'),
  INDEX 'fk_Familia_medicamento_2_idx' ('nombre_familia' ASC) VISIBLE,
  CONSTRAINT 'fk_Familia_medicamento_1'
    FOREIGN KEY ('codigo_medicamento')
    REFERENCES 'mydb'.'Medicamento' ('codigo')
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 'fk_Familia_medicamento_2'
    FOREIGN KEY ('nombre_familia')
    REFERENCES 'mydb'.'Familia' ('nombre')
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table 'mydb'.'Compra'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Compra' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Compra' (
  'Fecha' DATE NOT NULL,
  'Importe' FLOAT NULL,
  PRIMARY KEY ('Fecha'))
;


-- -----------------------------------------------------
-- Table 'mydb'.'Compra_Medicamento'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Compra_Medicamento' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Compra_Medicamento' (
  'codigo_medicamento' INT NOT NULL,
  'fecha_compra' DATE NOT NULL,
  'unidades' INT NULL,
  'igic' FLOAT NULL,
  'importe_linea' FLOAT GENERATED ALWAYS AS () VIRTUAL,
  PRIMARY KEY ('codigo_medicamento', 'fecha_compra'),
  INDEX 'fk_Compra_Medicamento_1_idx' ('fecha_compra' ASC) VISIBLE,
  CONSTRAINT 'fk_Compra_Medicamento_1'
    FOREIGN KEY ('fecha_compra')
    REFERENCES 'mydb'.'Compra' ('Fecha')
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT 'fk_Compra_Medicamento_2'
    FOREIGN KEY ('codigo_medicamento')
    REFERENCES 'mydb'.'Medicamento' ('codigo')
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table 'mydb'.'Cliente'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Cliente' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Cliente' (
  'codigo' INT NOT NULL,
  'nombre' VARCHAR(45) NULL,
  'dia_pago' INT NULL DEFAULT BETWEEN 1 AND 31,
  PRIMARY KEY ('codigo'))
;


-- -----------------------------------------------------
-- Table 'mydb'.'Pago_credito'
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'mydb'.'Pago_credito' ;

CREATE TABLE IF NOT EXISTS 'mydb'.'Pago_credito' (
  'año' INT NOT NULL,
  'fecha_compra' DATE NOT NULL,
  'fecha_pago' DATE NULL,
  'cantidad_abonada' FLOAT NULL,
  'codigo_cliente' INT NULL,
  'mes' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('año', 'fecha_compra', 'mes'),
  INDEX 'fk_Pago_credito_1_idx' ('fecha_compra' ASC) VISIBLE,
  INDEX 'fk_Pago_credito_2_idx' ('codigo_cliente' ASC) VISIBLE,
  CONSTRAINT 'fk_Pago_credito_1'
    FOREIGN KEY ('fecha_compra')
    REFERENCES 'mydb'.'Compra' ('Fecha')
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT 'fk_Pago_credito_2'
    FOREIGN KEY ('codigo_cliente')
    REFERENCES 'mydb'.'Cliente' ('codigo')
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

-- -----------------------------------------------------
-- Data for table 'mydb'.'Laboratorio'
-- -----------------------------------------------------
START TRANSACTION;
USE 'mydb';
INSERT INTO 'mydb'.'Laboratorio' ('codigo', 'contacto', 'nombre', 'codigo_postal', 'telefono') VALUES (1111, 'Mario', 'Italfarmaco', 38478, 698523478);
INSERT INTO 'mydb'.'Laboratorio' ('codigo', 'contacto', 'nombre', 'codigo_postal', 'telefono') VALUES (0000, 'Farmacia', 'Farmacia', 38795, );

COMMIT;


-- -----------------------------------------------------
-- Data for table 'mydb'.'Medicamento'
-- -----------------------------------------------------
START TRANSACTION;
USE 'mydb';
INSERT INTO 'mydb'.'Medicamento' ('codigo', 'nombre', 'igic', 'posologia', 'precio', 'tipo', 'laboratorio') VALUES (1121, 'Ibuprofeno', 6.5, 'pastillas', 4.55, 'libre', 0000);
INSERT INTO 'mydb'.'Medicamento' ('codigo', 'nombre', 'igic', 'posologia', 'precio', 'tipo', 'laboratorio') VALUES (2245, 'Lexxema', 6.5, 'crema', 6.98, 'Con receta', 1111);

COMMIT;


-- -----------------------------------------------------
-- Data for table 'mydb'.'Compra'
-- -----------------------------------------------------
START TRANSACTION;
USE 'mydb';
INSERT INTO 'mydb'.'Compra' ('Fecha', 'Importe') VALUES ('22/02/2019', 10.53);
INSERT INTO 'mydb'.'Compra' ('Fecha', 'Importe') VALUES ('12/10/2019', 6.98);

COMMIT;


-- -----------------------------------------------------
-- Data for table 'mydb'.'Compra_Medicamento'
-- -----------------------------------------------------
START TRANSACTION;
USE 'mydb';
INSERT INTO 'mydb'.'Compra_Medicamento' ('codigo_medicamento', 'fecha_compra', 'unidades', 'igic', 'importe_linea') VALUES (1121, '22/02/2019', 1, 6.5, 6.98);
INSERT INTO 'mydb'.'Compra_Medicamento' ('codigo_medicamento', 'fecha_compra', 'unidades', 'igic', 'importe_linea') VALUES (2245, '22/02/2019', 1, 6.5, 4.55);
INSERT INTO 'mydb'.'Compra_Medicamento' ('codigo_medicamento', 'fecha_compra', 'unidades', 'igic', 'importe_linea') VALUES (1121, DEFAULT, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table 'mydb'.'Cliente'
-- -----------------------------------------------------
START TRANSACTION;
USE 'mydb';
INSERT INTO 'mydb'.'Cliente' ('codigo', 'nombre', 'dia_pago') VALUES (1111, 'Carolina ', 25);
INSERT INTO 'mydb'.'Cliente' ('codigo', 'nombre', 'dia_pago') VALUES (2222, 'Silvia', 18);

COMMIT;



