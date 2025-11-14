
//Script para permitir la creación del usuario
alter session set "_oracle_script"=true;

//Crear usuario BBDD Tarea 6
create user belen_bdtarea6 identified by "1234";
grant connect to belen_bdtarea6;

/*Todos los permisos exepto los siguientes: ‘administer resource manager’, 
‘keep date time’, ‘keep sysguid’, ‘sysbackup’, ‘sysdba’, ‘sysdg’
‘syskm’, sysoper’ y ‘sysrac’*/
--------------------------------------------------------------------------------

//Salida por pantalla
SET SERVEROUTPUT ON;

----------------------------- PROCEDIMIENTO A ----------------------------------
/*Crear un procedimiento que reciba como parámetro el número de cesta y muestre 
  por pantalla un listado con la información referente a la propia cesta 
  (ID, nombre y apellidos del voluntario que la prepara, fecha de preparación, 
  tipo de cesta y valor total de la misma). 
  
  Cada uno de estos datos aparecerá en una línea diferente. A continuación, 
  hay que mostrar el detalle de lo que contiene la cesta con el nombre del 
  producto, la cantidad y la unidad de medida.
  
  Para formatear la salida en cada una de las líneas se utiliza la función 
  DBMS_OUTPUT.PUT_LINE que imprime en cada línea la información que se pasa 
  como parámetros concatenando si es necesario varios valores o literales.
  
  Para proporcionar espacios en blanco a la derecha o a la izquierda se puede 
  utilizar las funciones RPAD y LPAD respectivamente. Puedes encontrar 
  más información en los contenidos de la unidad 4 de este módulo donde se 
  explican estas funciones en el apartado 5.2. Funciones de cadena de 
  caracteres para Oracle.
  */
  
  CREATE OR REPLACE PROCEDURE info_cesta (v_numCesta char)
  is
      -- Declaramos las variables en las que almacenaremos la información
      -- de la cesta consultada
      v_idcesta CHAR(3);
      v_nombreVoluntario VARCHAR2 (60);
      v_fechaPrepara DATE;
      v_tipo VARCHAR2 (10);
      v_valorTotal NUMBER(4,2);
      
      -- Declaramos el cursor para obtener los detalles de la cesta
      cursor  c_detalleCesta
      is
          select P.nombre, D.cantidad, P.medida
          from productos P, detalle_cesta D
          where p.referencia = d.ref_p
          and d.id_cesta = v_numCesta;
          
      -- Declaramos la variable para almacenar los detalles de la cesta
         v_detalleCesta c_detalleCesta%ROWTYPE;
  
  begin
      -- Obtenemos la información de la cesta consultada
      select c.id,v.nombre ||' '||v.apellidos as nombreVoluntario, c.fechaprepara,
             c.tipo,c.valor_total
             into v_idcesta,  v_nombreVoluntario, v_fechaPrepara, v_tipo,
                  v_valorTotal
        from cesta C,voluntarios V
       where c.dniv = v.dni
       and c.id = v_numCesta;
       
       -- Imprimimos información general de la cesta consultada
       DBMS_OUTPUT.PUT_LINE(RPAD('-', 47,'-'));
       DBMS_OUTPUT.PUT_LINE('ID CESTA: '||v_idcesta);
       DBMS_OUTPUT.PUT_LINE(RPAD('-', 47,'-'));
       DBMS_OUTPUT.PUT_LINE('Voluntario que prepara: '||v_nombreVoluntario);
       DBMS_OUTPUT.PUT_LINE('Fecha de preparación: '|| v_fechaPrepara);
       DBMS_OUTPUT.PUT_LINE('Tipo de la cesta: '||v_tipo);
       DBMS_OUTPUT.PUT_LINE('Valor de la cesta: '||v_valorTotal);
       DBMS_OUTPUT.PUT_LINE('');
       
       -- Imprimimos la cabecera de los detalles de la cesta
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 47,'-'));
        DBMS_OUTPUT.PUT_LINE(RPAD('PRODUCTO', 26)||
                             LPAD('CANTIDAD', 8)||
                             '  '||
                             RPAD('MEDIDA', 6));
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 47,'-'));
        
         -- Filas formateadas --
         -- Iteramos los detalles de la cesta e imprimimos cada fila
        FOR v_detalleCesta IN c_detalleCesta LOOP
        -- Procesamos las filas accediendo a v_detalleCesta.(nombreCampo)
          DBMS_OUTPUT.PUT_LINE(RPAD( v_detalleCesta.nombre, 26,' ')||
                               LPAD( v_detalleCesta.cantidad, 8,' ')||
                               '  '||
                               RPAD(v_detalleCesta.medida, 6,' '));
    END LOOP;
  
  end;
  
  