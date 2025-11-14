--------------------------------------------------------------------------------

//Salida por pantalla
SET SERVEROUTPUT ON;

-------------------------------- TRIGGER D -------------------------------------
/*Crear un disparador (trigger) que se dispare cada vez que se prepare una 
  nueva cesta para que se actualice los puntos acumulados del voluntario que la 
  ha preparado con el valor de los puntos de dicha cesta.

  En este caso se deberá comprobar el funcionamiento del trigger y para ello 
  deberás insertar algunos registros en la tabla CESTA (puedes dejar algunos 
  valores a NULL pero es necesario que indiques los puntos de la cesta y el 
  DNI del voluntario que la prepara). Posteriormente debes consultar la tabla 
  VOLUNTARIOS para comprobar que se ha actualizado el campo PuntosTotal.*/
  
CREATE OR REPLACE TRIGGER actualiza_puntos_acumulados
-- Disparador que se activa después de insertar una nueva fila en la tabla cesta
    AFTER INSERT ON cesta
    
--Indica que el trigger se ejecuta para cada fila insertada    
    FOR EACH ROW
    
BEGIN
 /* Actualizamos la tabla voluntarios incrementando los puntos en la cantidad 
    de puntos que lleva acumulados el voluntario.*/
     UPDATE voluntarios 
     SET PUNTOSTOTAL=PUNTOSTOTAL + :new.PUNTOS
     WHERE DNI=:new.DNIV;
END;

--Insertamos nuevas cestas

Insert into CESTA values('011',21.80,'basica', 13,'01/04/2024','01/05/2024','19311618X','52413279I');
Insert into CESTA values('012',45.95,'completa',12,'01/04/2024','02/05/2024','19311618X','79512435F');
Insert into CESTA values('013',19.20,'estandar' ,9,'01/04/2024','01/04/2024','98452175H','56497230K');


