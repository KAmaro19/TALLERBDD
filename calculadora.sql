SET SERVEROUTPUT ON;

DECLARE
    num1 NUMBER := 15;
    num2 NUMBER := 20;
    resultado NUMBER;

BEGIN
    resultado := num1 + num2; --SUMA
    DBMS_OUTPUT.PUT_LINE('Suma: ' || resultado);

    resultado := num1 - num2; --RESTA
    DBMS_OUTPUT.PUT_LINE('Resta: ' || resultado);

    resultado := num1 * num2; --MULTIPLICACION
    DBMS_OUTPUT.PUT_LINE('Multiplicacion: ' || resultado);

    IF num2 != 0 THEN --CREAMOS UN IF PARA QUE NO SE PUEDA DIVIDIR ENTRE CEROS, DONDE DAMOS UNA ORDEN DE QUE HACER SI EL NUMERO 2 ES CERO
       resultado := num1 / num2; 
       DBMS_OUTPUT.PUT_LINE('Division: ' || resultado); --EN CASO DE QUE NO SEA CERO NOS DARA EL RESULTADO
    ELSE
       DBMS_OUTPUT.PUT_LINE('No se puede dividir entre ceros'); --SI ES CERO NOS SALDRA EL MENSAJE DE QUE NO SE PUEDE DIVIDIR
    END IF; --CERRAMOS EL IF 

END;
/