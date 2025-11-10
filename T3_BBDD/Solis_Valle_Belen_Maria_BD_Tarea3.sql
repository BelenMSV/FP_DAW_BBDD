/*-----  APARTADO A  -----*/
/*Eliminamos la BBDD si ya esta creada una con este nombre*/
drop database if exists clinicas;

/*Creamos la BBDD con nombre clinicas*/
create database if not exists clinicas;

/*Ponemos la BBDD como por defecto*/
use clinicas;

/*Creamos las tablas de la BBDD, primero hacemos
las que no tienen Clave foranea/foreing Key FK para que primero 
se creen las Claves primarias/Primary Key PK que se 
basaran despues las Foreing Key FK.*/

/*Creamos la tabla medico*/
create table if not exists MEDICO (
/*El campo n_colegiado debe almacenar valores entre 1 y 999999999.*/
n_colegiado varchar(9) primary key check (n_colegiado between 1 and 999999999),
nombre varchar(50),
especialidad varchar(25)
);

/*Creamos la tabla ciudad*/
create table if not exists CIUDAD (
/*El campo cp almacena un valor que puede estar entre 00240 y 90007.*/
cp char(5) primary key check (cp between 240 and 90007),
nombre varchar(25),
/*La ciudad más habitada del mundo es Tokio, Japón, con una población total de 37.340.000
el tipo de dato mediumint unsigned se queda en  16777215 por lo que no alcanzaría este tipo
es por ello que establecemos como dato el tipo int y unsigned */
num_habitantes int unsigned
);

/*Creamos la tabla paciente*/
create table if not exists PACIENTE(
nif char(9),
nombre varchar(50),
/*La fecha_nacimiento no puede quedarse sin valor.*/
fecha_nacimiento date not null,
/*El número de historial es único por cada paciente, no se puede repetir.*/
/*Le he puesto una longitud fija porque muchos expedientes tienen el siguiente formato:'0000001' */
numero_historial char(7) unique,
fecha_operacion date,
n_colegiado varchar(9),
constraint pac_nif_fope primary key (nif,fecha_operacion),
/*La fecha_operacion debe ser mayor o igual que la fecha_nacimiento.*/
constraint pac_fnac_fope check (fecha_operacion>=fecha_nacimiento),
constraint pac_ncol_FK foreign key (n_colegiado) references MEDICO (n_colegiado)
on delete cascade on update cascade
);

/*Creamos la tabla clinica*/
create table if not exists CLINICA (
codigo char (10) primary key,
nombre varchar (25),
/*El numero_especialidades tendrá como valor predeterminado 1*/
numero_especialidades tinyint unsigned default 1,
es_privada enum ('si','no'),
cp char(5),
constraint cli_cp_FK foreign key (cp) references CIUDAD (cp)
);

/*Creamos la tabla trabaja*/
create table if not exists TRABAJA (
n_colegiado varchar(9),
codigo char (10),
constraint tra_PK primary key (n_colegiado, codigo),
constraint tra_ncol_FK foreign key (n_colegiado) references MEDICO (n_colegiado)
on delete cascade on update cascade,
constraint tra_cod_FK foreign key (codigo) references CLINICA (codigo)
on delete cascade on update cascade
);

/*-----  APARTADO B  -----*/
/*Crear una vista llamada CLINICAS_PRIVADAS para obtener todas las clínicas que sean privadas.*/
create view CLINICAS_PRIVADAS as select nombre, es_privada from CLINICA where es_privada='si';

/*Cambiar el nombre del campo numero_historial por: n_historial_clinico*/
alter table PACIENTE change column numero_historial n_historial_clinico char(7);

/*Añadir en la tabla MEDICO el campo email para almacenar el correo electrónico del médico.*/
alter table MEDICO add column email varchar (200);

/*Crear un índice en el campo n_historial_clinico de la tabla PACIENTE.*/
alter table PACIENTE add index idx_hist(n_historial_clinico);

/*-----  APARTADO C  -----*/
/*Crear el usuario "auxiliar" con la contraseña "auxilio345" para que se pueda conectar desde cualquier equipo.*/
create user auxiliar@'%' identified by 'auxilio345';

/*Conceder el privilegio al usuario creado en el apartado anterior para que pueda consultar datos en la tabla PACIENTE.*/
grant select on PACIENTE to auxiliar;
