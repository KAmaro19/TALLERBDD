-- EJERCICIO BECA -- EJERCICIO 2

-- ELIMINA TABLA CUIDADO CON TENER REGISTROS

DROP TABLE Becas;

-- CREACION DE LA TABLA

CREATE TABLE Becas (
    IdAlumnoBeca INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nombre VARCHAR2(100) NOT NULL,
    -- NUMBER permite valores como 94.99
    Calificacion NUMBER(5,2) NOT NULL,
    Estado VARCHAR2(30) NOT NULL
);

-- CREACION DEL PROCEDIMIENTO

CREATE OR REPLACE PROCEDURE EvaluarBeca(
    p_nombre IN VARCHAR2,
    p_calificacion IN NUMBER
)
AS
    -- VARIABLE LOCAL PARA EL ESTADO DE LA BECA
    v_estado VARCHAR2(30);

BEGIN

    -- VALIDAR NOMBRE
    IF TRIM(p_nombre) IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,
            'El nombre no puede estar vacio');

    -- VALIDACION DE CALIFICACIONES
    ELSIF p_calificacion IS NULL
        OR p_calificacion < 0
        OR p_calificacion > 100 THEN
        RAISE_APPLICATION_ERROR(-20002,
            'Calificacion fuera de rango');

    ELSE
        -- DETERMINAR TIPO DE BECA
        IF p_calificacion >= 95 THEN
            v_estado := 'Beca completa';
        ELSIF p_calificacion >= 90 THEN
            v_estado := 'Media beca';
        ELSE
            v_estado := 'Sin beca';
        END IF;

        -- GUARDAR REGISTROS
        INSERT INTO Becas (Nombre, Calificacion, Estado)
        VALUES (p_nombre, p_calificacion, v_estado);
    END IF;

END;
/

-- PRUEBAS

CALL EvaluarBeca('Carlos Hernández García', 100);
CALL EvaluarBeca('María López Martínez', 94.99);
CALL EvaluarBeca('Pedro Sánchez Rodríguez', 89.99);
CALL EvaluarBeca('Andrea Ramírez Flores', 95);
CALL EvaluarBeca('Luis González Pérez', 1000);
CALL EvaluarBeca('Fernanda Torres Morales', 85);
CALL EvaluarBeca('Miguel Álvarez Romero', 68.49);
CALL EvaluarBeca('Valeria Mendoza Castillo', 92.50);

-- GUARDAR LOS CAMBIOS

COMMIT;

-- MOSTRAR REGISTROS

SELECT * FROM Becas;