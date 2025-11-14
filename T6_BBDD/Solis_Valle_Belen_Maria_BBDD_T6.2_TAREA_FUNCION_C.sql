--------------------------------------------------------------------------------

//Salida por pantalla
SET SERVEROUTPUT ON;

-------------------------------- FUNCION C -------------------------------------
/*Crear una  función que reciba como parámetro el nombre de un producto y 
devuelva la cantidad total de ese producto que se ha repartido entre todas 
las cestas.*/

CREATE OR REPLACE FUNCTION sumaTotalProductos (v_nombreProducto VARCHAR2) 
          RETURN NUMBER
          IS
     -- Declaramos la variable en la que almacenaremos la suma total de productos      
    v_sumaTotalProductos NUMBER;

BEGIN
    -- Realizamos una consulta para calcular la suma total de productos del 
    -- del producto especificado en el parámetro v_nombreProducto de la función
        select sum(d.cantidad)
        into v_sumaTotalProductos
        from productos P, detalle_cesta D
        where p.referencia = d.ref_p
        -- Convertimos ambos nombres a mayúsculas para la comparación
        and upper(p.nombre) = upper(v_nombreProducto);
     
    -- Devolvemos la suma total de productos  
        RETURN v_sumaTotalProductos;
END;

