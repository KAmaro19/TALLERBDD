-- ELIMINA TABLA, CUIDADO SI HAY REGISTROS 

DROP TABLE Edad;

-- CREAMOS TABLA

CREATE TABLE Edad (
    -- ID DE LA PERSONA, INCREMENTA AUTOMATICAMENTE Y LLAVE PRIMARIA
    IdPerson INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    -- NOMBRE COMPLETO, NO PUEDE SER NULO
    Nombre VARCHAR2(100) NOT NULL,
    -- EDAD DE LA PERSONA, NO PUEDE SER NULA
    Edad INT NOT NULL,
    -- CLASIFICACION CALCULADA
    Clasificacion VARCHAR2(30) NOT NULL
);

-- CREACION DEL PROCEDIMIENTO

CREATE OR REPLACE PROCEDURE RegistrarPersona(
    p_nombre IN VARCHAR2,
    p_edad IN INT
)
AS
    -- VARIABLE LOCAL PARA LA CLASIFICACION
    v_clasificacion VARCHAR2(30);

BEGIN

    -- VALIDAR NOMBRE
    IF TRIM(p_nombre) IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'El nombre no puede estar vacio');

    -- VALIDAR EDAD
    ELSIF p_edad IS NULL OR p_edad < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'La edad no es valida');

    ELSE
        -- CLASIFICAR EDAD
        IF p_edad < 18 THEN
            v_clasificacion := 'Menor de edad';
        ELSIF p_edad BETWEEN 18 AND 59 THEN
            v_clasificacion := 'Adulto';
        ELSE
            v_clasificacion := 'Adulto mayor';
        END IF;

        -- GUARDAR REGISTROS
        INSERT INTO Edad (Nombre, Edad, Clasificacion)
        VALUES (p_nombre, p_edad, v_clasificacion);
    END IF;

END;
/

-- PRUEBAS 7 REGISTROS

CALL RegistrarPersona('Luis Calderon', 15);
CALL RegistrarPersona('Ana Luisa Ortiz', 18);
CALL RegistrarPersona('Marta Munoz', 29);
CALL RegistrarPersona('Jose Rafel Huerta', 10);
CALL RegistrarPersona('Carlos Daniel Perez', 30);
CALL RegistrarPersona('Maria Flores Sanchez', 76);
CALL RegistrarPersona('Santiago Munoz', 22);

-- GUARDAR LOS CAMBIOS
COMMIT;

-- MOSTRAR REGISTROS
SELECT * FROM Edad;