/*/ CREACIÓN DE LA BASE DE DATOS Y SUS TABLAS/*/

DROP DATABASE IF EXISTS CESTASOLIDARIA;

CREATE DATABASE IF NOT EXISTS CESTASOLIDARIA;

USE CESTASOLIDARIA;

Create table SOCIOS (
DNI CHAR(9) PRIMARY KEY,
nombre varchar(20),
apellidos varchar(50),
direccion varchar (50),
telefono varchar(9),
fecha_nacimiento date,
ingresos float(4),
numfam tinyint unsigned,
ayuda enum('1','2','3'),
renta mediumint unsigned
);


Create table VOLUNTARIOS (
DNI CHAR(9) PRIMARY KEY,
nombre varchar(20),
apellidos varchar(50),
direccion varchar (50),
telefono varchar(9),
fecha_nacimiento date,
puntostotal smallint unsigned
);
Create table CESTA (
ID char(3) PRIMARY KEY,
valor_total float(4.2),
tipo enum ('basica','estandar','completa'),
puntos smallint unsigned,
fechaprepara date,
fecharecoge date,
DNIS CHAR(9),
DNIV CHAR(9),
FOREIGN KEY (DNIS) REFERENCES SOCIOS (DNI) on delete cascade on update cascade,
FOREIGN KEY (DNIV) REFERENCES VOLUNTARIOS (DNI) on delete cascade on update cascade
);
Create table PRODUCTOS (
referencia varchar(5) PRIMARY KEY,
nombre varchar(20),
valor float(4.2),
stock mediumint,
medida enum('L','Kg','Ud')
);

Create table DETALLE_CESTA(
numero_linea tinyint unsigned,
ID_cesta char(3),
cantidad tinyint unsigned,
ref_p varchar(5),
PRIMARY KEY (numero_linea, ID_cesta),
FOREIGN KEY (ID_cesta) REFERENCES CESTA (ID) on delete cascade on update cascade,
FOREIGN KEY (ref_p) REFERENCES PRODUCTOS (referencia) on delete cascade on update cascade
);


/*/ CARGA DE DATOS/*/

/*/ SOCIOS/*/

Insert into SOCIOS values('31642798G', 'Paco', 'Cano Gutierrez','Calle Sabinar 8','617478552','1987-01-31',600.5,6,'2',25836);
Insert into SOCIOS values('74819253B', 'Dario', 'Ferrer Martinez','Calle Alemania 11','678451947','2000-05-01',350.6,4,'2',18920);
Insert into SOCIOS values('55487914P', 'Lara', 'Martin Rubio','Calle Mandarina 7','642772771','1995-09-12',400.8,5,'2',32589);
Insert into SOCIOS values('27445115T', 'Alex', 'Perez  Hernandez','Calle Segovia 8','643600501','1999-12-04',604.25,6,'2',25846);
Insert into SOCIOS values('88544692S', 'Martirio', 'Batalla Salom','Calle Bilbao 2','666458123','1957-01-31',100,3,'1',25348);
Insert into SOCIOS values('22951645V', 'Custodia', 'Guardiola Conesa','Avenida Juan Carlos 7','674184601','1983-07-06',200,2,'2',25820);
Insert into SOCIOS values('27531479A', 'Isidro', 'Figueras Perez','Calle Limon 73','700284012','1977-11-26',100,3,'1',18000);
Insert into SOCIOS values('19311618X', 'Dimas', 'Cerdan Salinas','Calle Mares 14','792666320','1989-03-29',300,3,'2',60025);
Insert into SOCIOS values('98452175H', 'Eduardo', 'Lopez Lopez', 'Avenida Gato Siames 26', '620314785','1996-05-23',1500,3,'3',25000);
Insert into SOCIOS values('57934526R', 'Reyes', 'Mayoral Valero', 'Calle Miguel Segura 12', '724159043','1988-11-27',2000,2,'3',12546);
Insert into SOCIOS values('26354517K', 'Antonia', 'Vicente Prat', 'Calle Maracas 22', '658001200','1977-11-28',1300,2,'3',26358);
Insert into SOCIOS values('33123987C', 'David', 'Pardo Marquez', 'Calle San Miguel 31','654004221','1993-01-04',2000,4,'3',15000);
Insert into SOCIOS values('66225571H', 'Ulises', 'Garcia Sanz', 'Calle Fernando Alonso 33', '647412349','1986-10-18',1200,2,'3',13258);

/*/ VOLUNTARIOS/*/

Insert into VOLUNTARIOS values('22447896V', 'Patricia', 'Fernandez Ruiz','Calle Japon 1','624752004','1997-07-14',1500);
Insert into VOLUNTARIOS values('77421335E', 'David', 'Gonzalez Azcona','Calle Madrid 17','634008222','1998-10-25',400);
Insert into VOLUNTARIOS values('10942404Y','Cosme','Nogueira Rebollo','Calle del Motor 33','605203665','1973-06-16',650);
Insert into VOLUNTARIOS values('40139191X','Francisca','Becerra Zapata','Calle de la Rosa 12','667884221', '1992-12-13',200);
Insert into VOLUNTARIOS values('56497230K','Jose Luis','Arce Navarro','Calle Berlin 12','742851002','1986-02-28',500);
Insert into VOLUNTARIOS values('79512435F','Juan','Moreno Fernandez','Calle Salamanca 77','621325079','1974-10-30',100);
Insert into VOLUNTARIOS values('52413279I','Amaia','Valverde Lopez','Avenida Marco Polo 32','657035042','1990-09-13',500);
Insert into VOLUNTARIOS values('91471235B','Jesus','Cruz Cobo','Avenida Calvo Sotelo 27','649651036','1995-04-27',800);
Insert into VOLUNTARIOS values('55976143M','Maria Isabel','Beltran Lopez','Calle Perro 56','691023456','1979-12-05',200);
Insert into VOLUNTARIOS values('27555115T', 'Alejandra', 'Collado  Hernandez','Calle Solaz 9','643600701','1999-11-04',1001);

/*/PRODUCTOS/*/

Insert into PRODUCTOS values('A0001','Pan',0.50,500,'Ud');
Insert into PRODUCTOS values('A0002','Leche',0.85,200,'L');
Insert into PRODUCTOS values('A0003','Patatas',1.70,100,'Kg');
Insert into PRODUCTOS values('A0004','Azucar',1.05,100,'Kg');
Insert into PRODUCTOS values('A0005','Harina',1.00,300,'Kg');
Insert into PRODUCTOS values('A0006','Latas de conserva',2.20,100,'Ud');
Insert into PRODUCTOS values('A0007','Aceite Oliva',4.50,70,'L');
Insert into PRODUCTOS values('A0008','Aceite Girasol',3.20,80,'L');
Insert into PRODUCTOS values('A0009','Pasta',1.15,100,'Kg');
Insert into PRODUCTOS values('A0010','Arroz',1.30,200,'Kg');


/*/ CESTA/*/

Insert into CESTA values('001',16.95,'basica',13,'2023-04-01','2023-04-02','55487914P','52413279I' );
Insert into CESTA values('002',45.2,'completa',30,'2023-01-01','2023-01-10','88544692S', '56497230K');
Insert into CESTA values('003',36, 'estandar',20,'2023-02-15','2023-02-18','26354517K','22447896V');
Insert into CESTA values('004',21.1, 'estandar',10,'2023-03-01','2023-03-09','26354517K','55976143M');
Insert into CESTA values('005',16.8, 'basica', 12,'2023-11-02','2023-11-22','66225571H','79512435F');
Insert into CESTA values('006',26.6, 'estandar', 3, '2023-04-05','2023-04-25','98452175H','91471235B');
Insert into CESTA values('007',50.1, 'completa', 10,'2023-02-10','2023-02-12','19311618X','91471235B');
Insert into CESTA values('008',21.8,'basica', 8,'2023-05-01','2023-05-11','19311618X','91471235B');
Insert into CESTA values('009',45.95,'completa',8,'2023-05-01','2023-05-08','19311618X','79512435F');
Insert into CESTA values('010',19.2,'estandar' ,7,'2023-04-01','2023-04-07','98452175H','56497230K');


/*/ DETALLE DE CESTA/*/

Insert into DETALLE_CESTA values(001, '001', 4,'A0001'); 
Insert into DETALLE_CESTA values(003, '001', 2,'A0003'); 
Insert into DETALLE_CESTA values(004, '001', 4,'A0002'); 
Insert into DETALLE_CESTA values(002, '001', 5,'A0005');
Insert into DETALLE_CESTA values(005, '001', 3,'A0004'); 
/*Total cesta 1 = 16.95*/

Insert into DETALLE_CESTA values(001, '002', 4,'A0004');
Insert into DETALLE_CESTA values(003, '002', 2,'A0007');
Insert into DETALLE_CESTA values(004, '002', 10,'A0006');
Insert into DETALLE_CESTA values(002, '002', 5,'A0003');
Insert into DETALLE_CESTA values(005, '002', 3,'A0001');
/*Total cesta 2 = 45.2*/

Insert into DETALLE_CESTA values(001, '003', 4,'A0008');
Insert into DETALLE_CESTA values(003, '003', 2,'A0006');
Insert into DETALLE_CESTA values(004, '003', 9,'A0004');
Insert into DETALLE_CESTA values(002, '003', 5,'A0002');
Insert into DETALLE_CESTA values(005, '003', 3,'A0003');
/*Total cesta 3 = 36*/

Insert into DETALLE_CESTA values(001, '004', 4,'A0003');
Insert into DETALLE_CESTA values(003, '004', 2,'A0004');
Insert into DETALLE_CESTA values(004, '004', 4,'A0009');
Insert into DETALLE_CESTA values(002, '004', 5,'A0001');
Insert into DETALLE_CESTA values(005, '004', 3,'A0003');
/*Total cesta 4 = 21.1*/

Insert into DETALLE_CESTA values(001, '005', 4,'A0002');
Insert into DETALLE_CESTA values(003, '005', 2,'A0003');
Insert into DETALLE_CESTA values(004, '005', 1,'A0007');
Insert into DETALLE_CESTA values(002, '005', 5,'A0001');
Insert into DETALLE_CESTA values(005, '005', 3,'A0005');
/*Total cesta 5 = 16.8*/

Insert into DETALLE_CESTA values(001, '006', 4,'A0004');
Insert into DETALLE_CESTA values(003, '006', 2,'A0005');
Insert into DETALLE_CESTA values(004, '006', 4,'A0008');
Insert into DETALLE_CESTA values(002, '006', 5,'A0001');
Insert into DETALLE_CESTA values(005, '006', 3,'A0003');
/*Total cesta 6 = 26.6*/

Insert into DETALLE_CESTA values(001, '007', 4,'A0004');
Insert into DETALLE_CESTA values(003, '007', 2,'A0001');
Insert into DETALLE_CESTA values(004, '007', 4,'A0008');
Insert into DETALLE_CESTA values(002, '007', 5,'A0007');
Insert into DETALLE_CESTA values(005, '007', 3,'A0006');
/*Total cesta 7 = 50.1*/

Insert into DETALLE_CESTA values(001, '008', 4,'A0002');
Insert into DETALLE_CESTA values(003, '008', 2,'A0009');
Insert into DETALLE_CESTA values(004, '008', 9,'A0001');
Insert into DETALLE_CESTA values(002, '008', 5,'A0005');
Insert into DETALLE_CESTA values(005, '008', 3,'A0006');
/*Total cesta 8 = 21.8*/

Insert into DETALLE_CESTA values(001, '009', 4,'A0007');
Insert into DETALLE_CESTA values(003, '009',7 ,'A0006');
Insert into DETALLE_CESTA values(004, '009', 4,'A0003');
Insert into DETALLE_CESTA values(002, '009', 5,'A0002');
Insert into DETALLE_CESTA values(005, '009', 3,'A0001');
/*Total cesta 9 = 45.95*/

Insert into DETALLE_CESTA values(001, '010', 4,'A0001');
Insert into DETALLE_CESTA values(003, '010', 2,'A0009');
Insert into DETALLE_CESTA values(004, '010', 4,'A0002');
Insert into DETALLE_CESTA values(002, '010', 5,'A0003');
Insert into DETALLE_CESTA values(005, '010', 3,'A0005');
/*Total cesta 10 = 19.2*/