/*1.- Insertar los siguientes datos en la tabla CESTA teniendo en cuenta 
que debes insertar sólo los valores necesarios en los campos correspondientes.*/

-- Tienes que crear el voluntario con DNI 11111479P para poder crear la cesta 012, 
-- los datos son: Nombre: Pablo, Apellidos: Rodríguez Díaz, Dirección: calle poeta juan n 24, Teléfono: 666555444.

-- 1 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 1 -- -- -- -- -- -- 
insert into voluntarios values
('11111479P','Pablo','Rodríguez Díaz','Calle poeta juan n 24','666555444',null,null);

insert into cesta values
('011', null, 'básica', 7, '2024-01-10', '2024-02-10', '27445115T', '22447896V'),
('012',	50.20, 'completa', 8, '2024-01-29',	null, null, '11111479P'),
('013',	19.23,	'básica', 4, '2024-02-02', '2024-02-03', '27531479A', '56497230K');
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/*2.- Incrementar en 10 puntos todos los voluntarios que han nacido desde el año 1990 
hasta el año 2024 .(Debes hacerlo con una única sentencia).*/

-- Voluntarios que han nacido desde el año 1990 hasta el año 2024
select *
from voluntarios
where fecha_nacimiento between "1990-01-01" and "2023-12-31";

-- 2 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 2 -- -- -- -- -- -- 
update voluntarios
set puntostotal = puntostotal + 10
where fecha_nacimiento between "1990-01-01" and "2023-12-31";
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/*3.- Eliminar los productos que nunca han sido utilizados en ninguna línea del 
detalle de cesta. (Debes hacerlo con una única sentencia)*/

-- Productos que si han sido utilizados
select distinct ref_p
from detalle_cesta;

-- Productos que no han sido utilizados
select *
from productos
where referencia not in (select distinct ref_p
						 from detalle_cesta);
                         
-- 3 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 3 -- -- -- -- -- --                         
-- Eliminamos los productos que nunca han sido utilizados
delete
from productos
where referencia not in (select distinct ref_p
						 from detalle_cesta);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/*4.- Decrementa en 100 los ingresos para aquellos socios que han recogido 
más de una cesta en el mes de mayo de 2023 . (Debes hacerlo con una única sentencia)*/

-- Detectamos que socios han recogido mas de una cesta
select  dnis, count(id)
from cesta
where dnis is not null
group by dnis
having count(id)>1;

-- Comprobamos los ingresos de aquellos socios que han recogido 
-- mas de una cesta
select dni, ingresos
from socios
where DNI in (select  dnis
			  from cesta
			  where dnis is not null
			  group by dnis
			  having count(id)>1);

-- 4 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 4 -- -- -- -- -- --
-- Decrementamos en 100 los ingresos para los socios que hayan recogido 
-- mas de una cesta
update socios
set ingresos = ingresos - 100
where DNI in (select  dnis
			  from cesta
			  where dnis is not null
			  group by dnis
			  having count(id)>1);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/*5.- Actualiza el campo "puntostotal" de la tabla VOLUNTARIOS sumándole los puntos 
obtenidos por éstos en la preparación de las cestas.(Debes hacerlo con una única sentencia)*/

-- Comprobamos los puntos totales que tienen los voluntarios antes
-- de sumarles los puntos obtenidos por estos en la preparacion de las cestas

select dni, puntostotal
from voluntarios;

-- comprobamos los puntos obtenidos por los voluntarios en la elaboración
-- de las cestas
select dniv, sum(puntos)
from cesta
group by dniv;

-- Actualizamos los puntos obtenidos por los voluntarios sumandoles los puntos
-- obtenidos en la elaboración de cestas
START TRANSACTION;

-- 5 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 5 -- -- -- -- -- --								
update voluntarios v, (select dniv, sum(puntos) as puntos
					  from cesta
					  group by dniv) as temp
set v.puntostotal = v.puntostotal + temp.puntos
where v.dni=temp.dniv;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 
COMMIT;

/*6.- Decrementar el stock en 5 unidades de aquellos productos que han sido 
asignados a más de dos lineas de distintas cestas (Debes hacerlo con una única sentencia).*/

-- Comprobamos que productos han sido asignados a mas de dos líneas de cesta de distintas cestas

select ref_p, count(ID_cesta)
from detalle_cesta
group by ref_p
having count(ID_cesta)>2;

-- 6 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 6 -- -- -- -- -- --	
-- Decrementamos el stock en 5 unidades
update productos
set stock = stock -5
where referencia in (select ref_p
					 from detalle_cesta
					 group by ref_p
					 having count(ID_cesta)>2);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
                    
/*7.- Insertar en la tabla RANKING_PRODUCTOS por cada producto, su referencia, su nombre y la cantidad 
total de las cestas, siempre y cuando se hayan utilizado más de 15 unidades del producto. 
(Debes hacerlo con una única sentencia).*/

-- Comprobamos que productos serían insertados en el ranking de productos
-- siempre y cuando se hayan utilizado más de 15 unidades del producto
select P.nombre, D.ref_p, count(D.ID_cesta), sum(D.cantidad)
from Productos P, detalle_cesta D
where P.referencia = D.ref_p
group by D.ref_p
having sum(D.cantidad)>15;

-- 7 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 7 -- -- -- -- -- --
-- Insertamos en la tabla ranking_productos por cada producto su referencia nombre y cantidad total
-- de cestas siempre y cuando se hayan utilizado mas de 15 unidades de producto 
insert into ranking_productos
select D.ref_p, P.nombre, count(D.ID_cesta)
from Productos P, detalle_cesta D
where P.referencia = D.ref_p
group by D.ref_p
having sum(D.cantidad)>15;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/*8.- Bloquear la tabla cesta en modo lectura y seguidamente intenta actualizar el tipo de la cesta 003 
por completa. Muestra la captura de pantalla dónde muestre el mensaje resultante.*/

-- 8 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 8 -- -- -- -- -- --
lock table cesta read;
update cesta
set tipo = "completa"
where id = "003";
unlock table;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

/*9.- Inicia una transacción. Elimina todas las líneas de la cesta cuya referencia a producto es A0002. 
Deshacer la transacción y comprobar que los registros no han sido eliminados.*/

-- 9 -- -- -- -- SENTENCIA QUE RESUELVE EL ENUNCIADO 9 -- -- -- -- -- --
start transaction;

delete
from detalle_cesta
where ref_p ="A0002";

rollback;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
