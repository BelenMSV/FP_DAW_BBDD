--------------------------------------------------------------------------------

//Salida por pantalla
SET SERVEROUTPUT ON;

----------------------------- PROCEDIMIENTO B ----------------------------------
/*Crear un procedimiento que reciba como parámetros el nombre y los apellidos 
  de un socio y se actualice el tipo de ayuda que recibirá pudiendo ser un 
  valor entre 1, 2 ó 3 según el cálculo entre su renta y el número de 
  familiares que tenga a su cargo.
  
  El procedimiento tendrá que comparar el valor obtenido de la división entre 
  la renta y el número de familiares que tiene a su cargo y realizar la 
  siguiente actualización:
  
  - Si el valor es inferior a 5000 entonces el tipo de ayuda que le pertenece 
    a ese socio es 1.
  
  - Si el valor está entre 5000 y 10000 entonces el tipo de ayuda que le 
    pertenece a ese socio es 2.
  
  - Si el valor es superior a 10000 entonces el tipo de ayuda que le pertenece 
    a ese socio es 3.
    
  El procedimiento debe mostrar por pantalla el DNI del socio, su nombre 
  completo, la renta, el número de familiares a su cargo, el valor calculado 
  respecto a la renta y número de familiares y por último el tipo de ayuda 
  que recibirá.
  
  Para formatear la salida en cada una de las líneas se utiliza la función 
  DBMS_OUTPUT.PUT_LINE que imprime en cada línea la información que se pasa 
  como parámetros concatenando si es necesario varios valores o literales.
  */
  
CREATE OR REPLACE PROCEDURE tipo_ayuda (v_nombre varchar2, v_apellidos varchar2)
    IS
    
      -- Declaramos las variables en las que almacenaremos la información
      -- del socio consultado
      v_DNISocio CHAR(9);
      v_nombreCompleto VARCHAR2(60);
      v_renta NUMBER(10,2);
      v_numFamiliares NUMBER(2,0);
      v_indiceCalculado NUMBER(10,2);
      v_tipoAyuda CHAR(1);
    
BEGIN
    -- Realizamos una consulta para obtener la información del socio
     select S.dni, S.nombre||' '||S.apellidos as nombreCompleto, S.renta,
            S.numfam
       into v_DNISocio, v_nombreCompleto, v_renta, v_numFamiliares
       from socios S
       where upper(S.nombre) = upper(v_nombre)
       and upper(S.apellidos) = upper(v_apellidos);
       
    -- Calculamos el índice (renta / número de familiares)
    v_indiceCalculado := v_renta/v_numFamiliares;
    
    -- Determinamos el tipo de ayuda en función del índice calculado
        IF (v_indiceCalculado>=10000) THEN
        v_tipoAyuda :='3';
        
        ELSIF (v_indiceCalculado>=5000) THEN
        v_tipoAyuda :='2';
        
        ELSE
        v_tipoAyuda :='1';
        
        END IF;
        
    -- Mostramos la información del socio y el tipo de ayuda que se ha asignado
    DBMS_OUTPUT.PUT_LINE('El socio con DNI '||v_DNISocio||
                         ' se llama '||v_nombreCompleto);
    DBMS_OUTPUT.PUT_LINE('Tiene una renta de '||v_renta||
                         ' y tiene '||v_numFamiliares||
                         ' familiares a su cargo.');
    DBMS_OUTPUT.PUT_LINE('Según el índice calculado es '||v_indiceCalculado||
                         ' y se actualiza el tipo de ayuda a '||v_tipoAyuda||'.');
    
    -- Actualizamos el tipo de ayuda del socio en la tabla socios
    -- Solamente si el tipo de ayuda actual es diferente del tipo que había 
    -- o bien el valor era nulo
    update socios
    set ayuda = v_tipoAyuda
    where upper(nombre) = upper(v_nombre)
    and upper(apellidos) = upper(v_apellidos)
    and (ayuda != v_tipoAyuda
    or ayuda is null);
    
END;

