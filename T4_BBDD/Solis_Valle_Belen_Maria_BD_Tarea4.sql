/**************************************************************************
*								APARTADO A:							      *
***************************************************************************/
use cestasolidaria;

-- 1.- Obtener un listado de todos los productos que pueden ir en las cestas.
select P.nombre 
from productos P;

-- 2.- Listar el nombre y apellidos de los socios que tengan de renta más de 
--     15000 y ordenados descendentemente por apellido desde la Z hasta la A.
select S.nombre, S.apellidos
from socios S
where S.renta>15000
order by apellidos desc;

-- 3.- Mostrar la fecha de nacimiento, nombre y apellidos de los voluntarios 
--     que nacieron a partir de 1986.
select V.nombre, V.apellidos, V.fecha_nacimiento
from voluntarios V 
where year(V.fecha_nacimiento)>=1986;

-- 4.- Obtener las cestas en las que haya pasado, entre la fecha de preparación
--  y la fecha de recogida menos de 5 días. Además su valor total sea menor que 30.
select C.ID
from cesta C
where datediff(C.fecharecoge,C.fechaprepara)<5
and C.valor_total<30;

/**************************************************************************
*								APARTADO B:							      *
***************************************************************************/

-- 5.- Mostrar el código de cesta, nombre y apellidos (concatenados) del Socio que ha 
--     recogido la cesta así como el nombre y apellidos (concatenados) del voluntario 
--     que ha preparado la cesta.
select C.ID, concat(S.nombre, " ",S.apellidos) as Socio,
             concat(V.nombre, " ",V.apellidos) as Voluntario
from cesta C, socios S, voluntarios V
where C.DNIS = S.DNI
and   C.DNIV = V.DNI;

-- 6.- Obtener el producto con el stock mínimo y el producto con el stock máximo.
select P.nombre
from productos P 
where P.stock = (select max(stock) from productos)
   or P.stock = (select min(stock) from productos);

-- 7.- Obtener el código y el valor total de las cestas, que sea mayor a la media 
--     de todas las cestas.
select C.ID, C.valor_total
from cesta C
where C.valor_total> (select avg(C.valor_total) from cesta C); 

-- 8.-Listar por cada mes las cestas que han preparado los voluntarios (con el 
--    formato de nombre y no de número ej. Noviembre), ordenadas de menor a mayor.
select monthname(C.fechaprepara) as mes, count(C.ID) as cantidad
from Cesta C 
group by mes
order by cantidad asc;

-- 9.- Obtener un histórico de todas las cestas y su detalle mostrando el código de cesta, 
--     el número de línea, la cantidad, la referencia del producto y su nombre dónde se ha 
--     incluido el producto A0004 y que las haya recogido Dimas Cerdán Salinas.
select C.ID, D.numero_linea, D.cantidad, D.ref_p, P.nombre
from Cesta C, detalle_cesta D, Productos P, Socios S 
where C.ID = D.ID_cesta
  and D.ref_p = P.referencia
  and C.DNIS = S.DNI
  and D.ref_p = "A0004"
  and S.nombre = "Dimas"
  and S.apellidos = "Cerdán Salinas";
  
-- 10.- Listar todos los voluntarios que tienen más de 200 puntos y menos de 700, indicando 
--      en qué fecha nacieron en formato DD/MM/AAAA y que en su dni no tengan la letra X.

select V.DNI, V.nombre, V.apellidos, V.direccion, V.telefono, 
		date_format(V.fecha_nacimiento,'%d/%m/%Y') as fechaNacimiento, V.puntostotal
from voluntarios V
where V.puntostotal>200
  and V.puntostotal<700
  and DNI not like "%X%";
  
-- 11.- Obtener un listado con la fecha de la última cesta que se recogió además del 
--      nombre del producto, la referencia, la cantidad y el valor de los productos 
--      que se incluyeron.
select C.fecharecoge, P.referencia, P.nombre,  D.cantidad, P.valor
from Cesta C, detalle_cesta D, productos P
where C.ID = D.ID_cesta
  and D.ref_p = P.referencia
  and C.fecharecoge in (select max(C.fecharecoge) from Cesta C);
  
-- 12.- Muestra el DNI y también el nombre y apellidos en una única columna de los 
--      voluntarios, junto al nombre del mes y año de aquellos que han preparado una 
--      cesta en el primer trimestre de 2023.

select V.DNI, concat(V.nombre," ",V.Apellidos) as nombre_Voluntario, 
	   monthname(C.fechaprepara) as mes, year(C.fechaprepara) as año
from Voluntarios V, Cesta C
where V.DNI = C.DNIV
  and C.fechaprepara between "2023-01-01" and "2023-03-31";
  
-- 13.- Obtener el id de la cesta y la cantidad de líneas que tiene de aquellas cestas 
--      que no contienen el producto azúcar en ninguna de sus líneas. Ordenarlo de 
--      mayor a menor por id de cesta.
select C.ID, count(D.numero_linea) as cantidad_lineas
from cesta C, detalle_cesta D, productos P
where C.ID = D.ID_cesta
  and D.ref_p = P.referencia
  and C.ID not in (select C.ID
				     from cesta C, detalle_cesta D, productos P
					where C.ID = D.ID_cesta
					  and D.ref_p = P.referencia
					  and P.nombre = "azucar")
group by C.ID
order by C.ID desc;

-- 14.- Listar la cantidad de cestas que han obtenido los socios mayores de 40 años. 
--      Debe mostrar el número de cestas, así como el nombre , apellidos y edad del socio .

select count(C.ID) as cantidad_cestas, S.nombre, S.apellidos, 
       truncate(datediff(CURDATE(),S.fecha_nacimiento)/365,0) as edad
from cesta C, socios S
where C.DNIS = S.DNI
  and truncate(datediff(CURDATE(),S.fecha_nacimiento)/365,0) > 40
group by S.DNI;

-- 15.- Obtener un listado con el nombre de los productos que no se incluyan en ninguna cesta.
select P.nombre
from productos P 
where P.referencia not in (select distinct P.referencia
						   from productos P, detalle_cesta D
						   where P.referencia = D.ref_p);
                           
-- 16.- Mostrar el listado de todos aquellos voluntarios que han preparado una cesta con el 
-- producto ‘Leche’ y que en su teléfono tenga un 0 obteniendo el nombre completo del voluntario 
-- en un mismo campo y el código de cesta preparada.

select concat(V.nombre," ",V.apellidos) as Voluntario, C.ID
from voluntarios V, Cesta C, Detalle_Cesta D, Productos P
where V.DNI = C.DNIV 
  and C.ID = D.ID_cesta
  and D.ref_p = P.referencia
  and P.nombre= "leche"
  and V.telefono like "%0%";
  
/**************************************************************************
*								APARTADO C:							      *
***************************************************************************/  

-- 17.- Mostrar las cestas que se recogieron en el mes de enero de 2023, siempre que la suma 
-- de la cantidad de productos que la componen sea mayor que 20.
select C.ID
from cesta C, Detalle_Cesta D
where C.ID = D.ID_cesta
  and C.fecharecoge between "2023-01-01" and "2023-01-31"
group by C.ID
having sum(D.cantidad)>20;

-- 18.- Mostrar el ID de cesta, junto con los nombres , cantidad e importe de los productos, 
--      de cada una de las líneas que forman cada cesta , de todas las cestas cuyo valor total 
--      sea mayor a la media del valor total de todas las cestas.Ordena las cestas de valor 
--      total menor a mayor.

select C.ID, P.nombre, D.cantidad, P.valor
from Cesta C, Productos P, Detalle_cesta D
where C.ID = D.ID_cesta
  and D.ref_p = P.referencia
  and C.valor_total > (select avg(C.valor_total) from Cesta C)
order by C.valor_total asc;


						


