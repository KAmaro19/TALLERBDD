
SET SERVEROUTPUT ON;

DECLARE
    calif1 NUMBER := 85;
    calif2 NUMBER := 90;
    calif3 NUMBER := 80;
    calif4 NUMBER := 95;
    promedio NUMBER;

BEGIN
    promedio := (calif1 + calif2 + calif3 + calif4) / 4; --AQUI HACEMOS LA SUMA DE LAS 4 CALIFICACIONES PARA DESPUES DIVIRLOS ENTRE EL MISMO NUMERO PARA CALCULAR EL PROMEDIO

    DBMS_OUTPUT.PUT_LINE('Calificacion 1: ' || calif1);
    DBMS_OUTPUT.PUT_LINE('Calificacion 2: ' || calif2);
    DBMS_OUTPUT.PUT_LINE('Calificacion 3: ' || calif3);
    DBMS_OUTPUT.PUT_LINE('Calificacion 4: ' || calif4);
    DBMS_OUTPUT.PUT_LINE('Promedio: ' || promedio);
END;
/
