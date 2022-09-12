-- Practica de Consultas en SQL 
-- SCRIPT de CREACION del esquema 'ALQUILERCOCHES' e INSERCION de datos 

-- ** NO ejecutar en la cuenta ORACLE, sino SOLO en vuestro PC **

-- Los DROP permiten la ejecucion repetida de este script
-- La primera vez que se ejecuta dan error (obviamente...)
DROP TABLE DETALLE_ALQUILER;
DROP TABLE GARAJE;
DROP TABLE ALQUILER;
DROP TABLE AGENCIA;
DROP TABLE COCHE;
DROP TABLE CLIENTE;

-- Creación de las tablas del esquema ALQUILERCOCHES
CREATE TABLE GARAJE (
 codigo		CHAR(2)		NOT NULL,		
 nombre		VARCHAR(15)	NOT NULL,
 direccion	VARCHAR(20),
 CONSTRAINT garaje_pk PRIMARY KEY(codigo), 
 CONSTRAINT garaje_ak UNIQUE(nombre)
);

CREATE TABLE COCHE (
 matricula	CHAR(7)		NOT NULL, 
 marca		VARCHAR(15)	NOT NULL,
 modelo		VARCHAR(15)	NOT NULL,
 color		VARCHAR(10)	NOT NULL,
 garaje		CHAR(2)		NOT NULL, 
 precio_alquiler NUMBER(5,2)	NOT NULL, -- max. 999,99
 CONSTRAINT coche_pk PRIMARY KEY(matricula), 
 CONSTRAINT coche_precioalquiler_ok CHECK (precio_alquiler>0),
 CONSTRAINT coche_fk_garaje FOREIGN KEY (garaje)
                             REFERENCES GARAJE(codigo)
);

CREATE TABLE CLIENTE(
 DNI		CHAR(9) 	NOT NULL,
 codigo		CHAR(4) 	NOT NULL,
 nombre		VARCHAR(20) NOT NULL,
 direccion	VARCHAR(20),
 ciudad		VARCHAR(20),
 telefono	CHAR(9) 	NOT NULL,
 CONSTRAINT cliente_pk PRIMARY KEY(codigo), 
 CONSTRAINT cliente_ak UNIQUE(DNI)
);

CREATE TABLE AGENCIA (
 codigo		CHAR(3)		NOT NULL,
 zona		VARCHAR(15)	NOT NULL,
 CONSTRAINT agencia_pk PRIMARY KEY(codigo)
);

CREATE TABLE ALQUILER (
 id				CHAR(3)	NOT NULL,
 fecha_inicio	DATE 		DEFAULT SysDate NOT NULL,
 fecha_fin		DATE		NOT NULL,
 cliente		CHAR(4)	NOT NULL,
 agencia		CHAR(3)	NOT NULL,
 coste_total	NUMBER(6,2)	NOT NULL , -- max. 9.999,99
 cerrado		CHAR(1) 	DEFAULT 'N' NOT NULL,
 CONSTRAINT alquiler_pk PRIMARY KEY(id), 
 CONSTRAINT alquiler_periodo_ok CHECK ( fecha_fin >= fecha_inicio ),
 CONSTRAINT alquiler_coste_total_ok CHECK (coste_total>0),
 CONSTRAINT alquiler_cerrado_ok CHECK (cerrado IN ('S', 'N')),
 CONSTRAINT alquiler_fk_cliente FOREIGN KEY(cliente) 
                                 REFERENCES CLIENTE(codigo),
 CONSTRAINT alquiler_fk_agencia FOREIGN KEY(agencia) 
                                 REFERENCES AGENCIA(codigo) );

CREATE TABLE DETALLE_ALQUILER (
 alquiler	CHAR(3),
 coche		CHAR(7),
 litros_inicio	NUMBER(3)	NOT NULL, --max. 999
 coste_coche	NUMBER(6,2)	NOT NULL, --max. 9.999,99
 CONSTRAINT detalle_alquiler_pk PRIMARY KEY (alquiler, coche),
 CONSTRAINT detalle_alquiler_coste_ok CHECK (coste_coche>0),
 CONSTRAINT detalle_alquiler_fk_alquiler FOREIGN KEY(alquiler)
                                          REFERENCES ALQUILER(id)
                                          ON DELETE CASCADE,
 CONSTRAINT lista_alquiler_coche FOREIGN KEY (coche)
                                          REFERENCES COCHE(matricula)
);

-- Introduccion de datos en las tablas del esquema:
/* Vaciado de las tablas:
DELETE FROM DETALLE_ALQUILER;
DELETE FROM ALQUILER;
DELETE FROM COCHE;
DELETE FROM GARAJE;
DELETE FROM CLIENTE;
DELETE FROM AGENCIA;
*/

INSERT INTO GARAJE(codigo, nombre, direccion) VALUES ('G2', 'VISTABELLA', 'ROBLES, 7' );
INSERT INTO GARAJE(codigo, nombre, direccion) VALUES ('G5', 'VISTALEGRE', 'ALAMOS, 10' );
INSERT INTO GARAJE(codigo, nombre, direccion) VALUES ('G3', 'LA FLOTA', 'ENEBROS, 4' );
INSERT INTO GARAJE(codigo, nombre, direccion) VALUES ('G6', 'RONDA SUR', 'SAUCES, 2' );
INSERT INTO GARAJE(codigo, nombre, direccion) VALUES ('G1', 'SAN ANTON', 'OLMOS, 23' );
INSERT INTO GARAJE(codigo, nombre, direccion) VALUES ('G4', 'EL CARMEN', 'ALERCES, 8' );

INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('0765BBC', 'SEAT', 'CORDOBA', 'PLATA', 'G1', 82);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('1234XPQ', 'VOLKSWAGEN', 'POLO', 'BLANCO', 'G2', 63 );
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('2426CBM', 'AUDI', 'A3', 'AZUL', 'G4', 71);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('4636XPQ', 'SEAT', 'TOLEDO', 'VERDE', 'G1', 70 );
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('2832BDD', 'SEAT', 'TOLEDO', 'PLATA', 'G3', 70);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('2132FPJ', 'VOLKSWAGEN', 'PASSAT', 'AZUL', 'G5', 83 );
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('1523BBD', 'VOLKSWAGEN', 'POLO', 'VERDE', 'G2', 60);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('8867GBC', 'AUDI', 'A3', 'ROJO', 'G1', 75);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('9495HBC', 'FORD', 'FIESTA', 'AZUL', 'G3', 35 );
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('2018CBS', 'FORD', 'FOCUS', 'PLATA', 'G5', 70);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('4152CBM', 'OPEL', 'CORSA', 'VERDE', 'G4', 50);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('7425CNT', 'SEAT', 'PANDA', 'NEGRO', 'G4', 30);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('3030TNT', 'OPEL', 'CORSA', 'BLANCO', 'G1', 55);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('1520CBM', 'AUDI', 'A3', 'NEGRO', 'G3', 75);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('2494TNT', 'FORD', 'FOCUS', 'PLATA', 'G5', 73);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('1010BBC', 'AUDI', 'A4', 'NEGRO', 'G2', 90);
INSERT INTO COCHE(matricula, marca, modelo, color, garaje, precio_alquiler) 
  VALUES ('2495TNT', 'FORD', 'FOCUS', 'ROJO', 'G5', 73);


INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '11223344A', 'C01', 'ARCADIO ROMANCERO', 'PAZ, 161', 'SANTOMERA', '512345678');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '54321234P', 'C04', 'ELISENDA NARANJO', 'JARDIN, 31', 'BENIEL', '587654321');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '14421875D', 'C16', 'ANASTASIA GRIS', 'AIRES, 17', 'YECLA', '516516516');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '99001122E', 'C09', 'HORTENSIO AZULETE', 'PAJAROS, 54', 'LA ALBERCA', '511122212');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '12345678Z', 'C02', 'RIGOBERTA ROJAS', 'TEJERA, 11', 'YECLA', '522334455');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '14253647F', 'C07', 'ESMERALDO MONTERO', 'LIBERTAD, 36', 'MURCIA', '555667788');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '11122233C', 'C10', 'MARGARITO FLORES', 'PASEO ROSALES, 3', 'MOLINA DE SEGURA', '522233323');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '26073442E', 'C14', 'ABUNDIO ROMERO', 'GAUDI, 14', 'MURCIA', '533221100');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '15103048M', 'C03', 'RODOLFO MONTES', 'ROCASA, 2', 'BENIEL', '588990099');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '55667788B', 'C06', 'SEGISMUNDA MORA', 'HUERTOS, 28', 'YECLA', '511223344');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '18171615L', 'C15', 'AGAPITO SAURA', 'ROCIO, 43', 'SANTOMERA', '599887766');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '87654321D', 'C08', 'FLORINDO ROMERO', 'CAMINANTE, 46', 'MOLINA DE SEGURA', '555566656');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '28123112F', 'C12', 'TEOFILO AGUAS', 'TOBOSO, 5', 'MURCIA', '543210987');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '44261472G', 'C05', 'CARMELO CUADRADO', 'PINOS, 27', 'LA ALBERCA', '566677767');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ('52741624C', 'C13', 'EUFRASIA BLANCO', 'AZUCENAS, 28', 'SANTOMERA', '544455545');
INSERT INTO CLIENTE(dni, codigo, nombre, direccion, ciudad, telefono) 
  VALUES ( '23201731G', 'C11', 'FERMIN ALEGRE', 'AIRE, 33', 'MOLINA DE SEGURA', '567890123');

INSERT INTO AGENCIA(codigo, zona) VALUES ( 'A3', 'SAN ANDRES');
INSERT INTO AGENCIA(codigo, zona) VALUES ( 'A1', 'LA FLOTA');
INSERT INTO AGENCIA(codigo, zona) VALUES ( 'A4', 'GRAN VIA');
INSERT INTO AGENCIA(codigo, zona) VALUES ( 'A2', 'EL CARMEN');

-- Solicitudes de alquiler de coches realizadas por los clientes 
-- (coste_total=suma de coste_coche de cada coche alquilado [ver DETALLE_ALQUILER])
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q16', TO_DATE('02/03/2017','DD/MM/YYYY'), TO_DATE('04/03/2017','DD/MM/YYYY'), 'C07', 'A1', 246, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q23', TO_DATE('10/05/2017','DD/MM/YYYY'), TO_DATE('15/05/2017','DD/MM/YYYY'), 'C07', 'A2', 780, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q03', TO_DATE('08/06/2018','DD/MM/YYYY'), TO_DATE('11/06/2018','DD/MM/YYYY'), 'C07', 'A3', 252, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q30', TO_DATE('20/02/2018','DD/MM/YYYY'), TO_DATE('26/02/2018','DD/MM/YYYY'), 'C07', 'A4', 490, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q05', TO_DATE('07/05/2018','DD/MM/YYYY'), TO_DATE('09/05/2018','DD/MM/YYYY'), 'C14', 'A1', 681, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q11', TO_DATE('20/05/2018','DD/MM/YYYY'), TO_DATE('21/05/2018','DD/MM/YYYY'), 'C14', 'A2', 140, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q17', TO_DATE('28/07/2018','DD/MM/YYYY'), TO_DATE('31/07/2018','DD/MM/YYYY'), 'C14', 'A3', 332, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q22', TO_DATE('14/12/2018','DD/MM/YYYY'), TO_DATE('19/12/2018','DD/MM/YYYY'), 'C14', 'A4', 726, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q09', TO_DATE('18/11/2017','DD/MM/YYYY'), TO_DATE('20/11/2017','DD/MM/YYYY'), 'C07', 'A2', 270, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q20', TO_DATE('03/04/2018','DD/MM/YYYY'), TO_DATE('07/04/2018','DD/MM/YYYY'), 'C07', 'A2', 300, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q06', TO_DATE('10/12/2018','DD/MM/YYYY'), TO_DATE('15/12/2018','DD/MM/YYYY'), 'C02', 'A4', 492, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q12', TO_DATE('04/04/2018','DD/MM/YYYY'), TO_DATE('20/04/2018','DD/MM/YYYY'), 'C08', 'A1', 3536, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q13', TO_DATE('02/08/2018','DD/MM/YYYY'), TO_DATE('22/09/2018','DD/MM/YYYY'), 'C06', 'A4', 1155, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q14', TO_DATE('05/02/2018','DD/MM/YYYY'), TO_DATE('15/02/2018','DD/MM/YYYY'), 'C08', 'A2', 770, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q15', TO_DATE('03/01/2018','DD/MM/YYYY'), TO_DATE('07/01/2018','DD/MM/YYYY'), 'C05', 'A1', 355, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q01', TO_DATE('26/12/2018','DD/MM/YYYY'), TO_DATE('31/12/2018','DD/MM/YYYY'), 'C06', 'A3', 438, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q07', TO_DATE('03/12/2018','DD/MM/YYYY'), TO_DATE('07/12/2018','DD/MM/YYYY'), 'C05', 'A3', 860, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q18', TO_DATE('11/10/2018','DD/MM/YYYY'), TO_DATE('13/10/2018','DD/MM/YYYY'), 'C11', 'A4', 189, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q19', TO_DATE('12/01/2018','DD/MM/YYYY'), TO_DATE('16/01/2018','DD/MM/YYYY'), 'C03', 'A3', 1220, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q10', TO_DATE('29/08/2017','DD/MM/YYYY'), TO_DATE('04/09/2017','DD/MM/YYYY'), 'C08', 'A2', 490, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q21', TO_DATE('14/11/2017','DD/MM/YYYY'), TO_DATE('15/11/2017','DD/MM/YYYY'), 'C01', 'A1', 126, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q08', TO_DATE('19/12/2018','DD/MM/YYYY'), TO_DATE('28/12/2018','DD/MM/YYYY'), 'C02', 'A3', 630, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q02', TO_DATE('04/01/2018','DD/MM/YYYY'), TO_DATE('10/01/2018','DD/MM/YYYY'), 'C04', 'A2', 490, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q24', TO_DATE('20/05/2018','DD/MM/YYYY'), TO_DATE('23/05/2018','DD/MM/YYYY'), 'C09', 'A3', 492, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q25', TO_DATE('09/01/2018','DD/MM/YYYY'), TO_DATE('12/01/2018','DD/MM/YYYY'), 'C05', 'A3', 292, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q26', TO_DATE('10/05/2017','DD/MM/YYYY'), TO_DATE('15/05/2017','DD/MM/YYYY'), 'C10', 'A1', 426, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q27', TO_DATE('04/02/2018','DD/MM/YYYY'), TO_DATE('10/02/2018','DD/MM/YYYY'), 'C04', 'A2', 581, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q28', TO_DATE('04/04/2018','DD/MM/YYYY'), TO_DATE('10/04/2018','DD/MM/YYYY'), 'C12', 'A4', 525, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q29', TO_DATE('13/03/2018','DD/MM/YYYY'), TO_DATE('14/03/2018','DD/MM/YYYY'), 'C13', 'A2', 164, 'S');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q04', TO_DATE('20/02/2018','DD/MM/YYYY'), TO_DATE('23/02/2018','DD/MM/YYYY'), 'C09', 'A3', 852, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q31', TO_DATE('19/01/2018','DD/MM/YYYY'), TO_DATE('25/01/2018','DD/MM/YYYY'), 'C15', 'A4', 490, 'N');
INSERT INTO ALQUILER(id, fecha_inicio, fecha_fin, cliente, agencia, coste_total, cerrado) 
  VALUES ('Q32', TO_DATE('20/12/2018','DD/MM/YYYY'), TO_DATE('24/12/2018','DD/MM/YYYY'), 'C08', 'A2', 365, 'N');


-- Detalle de cada alquiler (coste_coche = diasalquiler * precio_alquiler)
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q16', '0765BBC', 40, 246);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q23', '2832BDD', 35, 420);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q23', '1523BBD', 25, 360);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q03' , '1234XPQ', 20, 252);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q30', '4636XPQ', 35, 490);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q05', '2832BDD', 40, 210);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q05', '8867GBC', 40, 225);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q05', '0765BBC', 45, 246);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q11', '2018CBS', 30, 140);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q17', '2132FPJ', 45, 332);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q22', '4152CBM', 15, 300);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q22', '2426CBM', 40, 426);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q09', '1010BBC', 30, 270);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q20', '1523BBD', 20, 300);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q06', '0765BBC', 35, 492);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q12', '4636XPQ', 40, 1190);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q12', '2132FPJ', 45, 1411);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q12', '3030TNT', 15, 935);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q13', '3030TNT', 15, 1155);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q14', '2832BDD', 40, 770);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q15', '2426CBM', 30, 355);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q01', '2495TNT', 25, 438);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q07', '1010BBC', 40, 450);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q07', '0765BBC', 30, 410);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q18', '1234XPQ', 25, 189);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q19', '2132FPJ', 30, 415);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q19', '2426CBM', 35, 355);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q19', '1010BBC', 30, 450);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q10', '2832BDD', 40, 490);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q21', '1234XPQ', 25, 126);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q08', '1234XPQ', 25, 630);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q02', '4636XPQ', 40, 490);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q24', '1234XPQ', 20, 252);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q24', '1523BBD', 25, 240);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q25', '2494TNT', 45, 292);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q26', '2426CBM', 40, 426);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q27', '2132FPJ', 45, 581);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q28', '8867GBC', 40, 525);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q29', '0765BBC', 40, 164);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q04', '8867GBC', 45, 300);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q04', '1234XPQ', 20, 252);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q04', '1520CBM', 40, 300);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q31', '4636XPQ', 35, 490);
INSERT INTO DETALLE_ALQUILER(alquiler, coche, litros_inicio, coste_coche)
  VALUES ( 'Q32', '2495TNT', 20, 365);

-- confirmacion de las operaciones realizadas
COMMIT;
