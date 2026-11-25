-- CREACION DE LA BASE DE DATOS

CREATE DATABASE IF NOT EXISTS Edades;

USE Edades;

-- DROP TABLE CUIDADO CON TENER REGISTROS 

DROP TABLE IF EXISTS Edad;

--CREAMOS TABLA 
CREATE TABLE Edad (
    -- ID DE LA PERSONA, INCREMENTA AUTOMATICAMENTE Y LLAVE PRIMARIA 
    IdPerson INT AUTO_INCREMENT PRIMARY KEY,
    -- NOMBRE COMPLETO, NO PUEDE SER NULO
    Nombre VARCHAR(100) NOT NULL,
    -- EDAD DE LA PERSONA, NO PUEDE SER NULA
    Edad INT NOT NULL,
    -- CLASIFICACION CALCULADA
    Clasificacion VARCHAR(30) NOT NULL
);

-- MUCHO CUIDADO SI TENEMOS REGISTROS
DROP PROCEDURE IF EXISTS RegistrarPersona;

DELIMITER //

CREATE PROCEDURE RegistrarPersona(
    IN p_nombre VARCHAR(100),
    IN p_edad INT
)
BEGIN

    -- VARIABLE LOCAL PARA LA CLASIFICACION
    DECLARE v_clasificacion VARCHAR(30);

    -- VALIDAR NOMBRE
    IF p_nombre IS NULL OR TRIM(p_nombre) = '' THEN
        SIGNAL SQLSTATE '0919'
        SET MESSAGE_TEXT = 'El nombre no puede estar vacio';

    -- VALIDAR EDAD
    ELSEIF p_edad IS NULL OR p_edad < 0 THEN
        SIGNAL SQLSTATE '0929'
        SET MESSAGE_TEXT = 'La edad no es valida';

    ELSE
        -- CLASIFICAR EDAD
        IF p_edad < 18 THEN
            SET v_clasificacion = 'Menor de edad';
        ELSIF p_edad BETWEEN 18 AND 59 THEN
            SET v_clasificacion = 'Adulto';
        ELSE
            SET v_clasificacion = 'Adulto mayor';
        END IF;

        -- GUARDAR REGITROS
        INSERT INTO Edad (Nombre, Edad, Clasificacion)
        VALUES (p_nombre, p_edad, v_clasificacion);
    END IF;

END //

DELIMITER ;

-- PRUEBAS 7 REGISTROS 
CALL RegistrarPersona('Luis Calderon', 15);
CALL RegistrarPersona('Ana Luisa Ortiz', 18);
CALL RegistrarPersona('Marta Munoz', 29);
CALL RegistrarPersona('Jose Rafel Huerta', 10);
CALL RegistrarPersona('Carlos Daniel Perez', 30);
CALL RegistrarPersona('Maria Flores Sanchez', 76);
CALL RegistrarPersona('Santiago Munoz', 22);

SELECT * FROM Edad;

-- EJERCICIO BECA -- EJERCICIO 2

DROP TABLE IF EXISTS Becas;

CREATE TABLE Becas (
    IdAlumnoBeca INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    -- DECIMAL permite valores como 94.99
    Calificacion DECIMAL(5,2) NOT NULL,
    Estado VARCHAR(30) NOT NULL
);

DROP PROCEDURE IF EXISTS EvaluarBeca;

DELIMITER //

CREATE PROCEDURE EvaluarBeca(
    IN p_nombre VARCHAR(100),
    IN p_calificacion DECIMAL(5,2)
)
BEGIN

    DECLARE v_estado VARCHAR(30);

    -- VALIDAR NOMBRE
    IF p_nombre IS NULL OR TRIM(p_nombre) = '' THEN
        SIGNAL SQLSTATE '1001'
        SET MESSAGE_TEXT = 'El nombre no puede estar vacio';

    -- VALIDACION DE CALIFICACIONES
    ELSEIF p_calificacion IS NULL
        OR p_calificacion < 0
        OR p_calificacion > 100 THEN
        SIGNAL SQLSTATE '1011'
        SET MESSAGE_TEXT = 'Calificacion fuera de rango';

    ELSE
        -- DETERMINAR TIPO DE BECA
        IF p_calificacion >= 95 THEN
            SET v_estado = 'Beca completa';
        ELSEIF p_calificacion >= 90 THEN
            SET v_estado = 'Media beca';
        ELSE
            SET v_estado = 'Sin beca';
        END IF;

        INSERT INTO Becas (Nombre, Calificacion, Estado)
        VALUES (p_nombre, p_calificacion, v_estado);
    END IF;

END //

DELIMITER ;

-- Pruebas

CALL EvaluarBeca('Carlos Hernández García', 100);
CALL EvaluarBeca('María López Martínez', 94.99);
CALL EvaluarBeca('Pedro Sánchez Rodríguez', 89.99);
CALL EvaluarBeca('Andrea Ramírez Flores', 95);
CALL EvaluarBeca('Luis González Pérez', 1000);
CALL EvaluarBeca('Fernanda Torres Morales', 85);
CALL EvaluarBeca('Miguel Álvarez Romero', 68.49);
CALL EvaluarBeca('Valeria Mendoza Castillo', 92.50);

SELECT * FROM Becas;

