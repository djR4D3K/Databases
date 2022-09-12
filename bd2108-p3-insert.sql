/*
Asignatura: Bases de Datos
Curso: 2021/22
Convocatoria: junio

Practica: P3. Definicion y Modificacion de Datos en SQL

Equipo de practicas: bd2108
 Integrante 1: Radoslaw Krzysztof Krolikowski
 Integrante 2: JungPeng Jin
*/

-- EJERCICIO 1. 
-- a. Sentencias INSERT
-- INSERT DE REVISTA
ALTER TABLE REVISTA DISABLE CONSTRAINT rev_fk_coordinador;

INSERT INTO REVISTA(id, nombre, tema, web, periodicidad, coordinador) 
  VALUES ('R01', 'NATURALIZA', 'NATURALEZA', NULL, 'MENSUAL', '11223344P');
INSERT INTO REVISTA(id, nombre, tema, web, periodicidad, coordinador) 
  VALUES ('R02', 'FUENTE PRIMARIA', 'POLITICA', 'fuenteprimaria.com', 
          'SEMANAL', '44556677A');
INSERT INTO REVISTA(id, nombre, tema, web, periodicidad, coordinador) 
  VALUES ('R03', 'VIAJAR HOY', 'VIAJES', NULL, 'TRIMESTRAL', '66778899J');
INSERT INTO REVISTA(id, nombre, tema, web, periodicidad, coordinador) 
  VALUES ('R04', 'TECNOFIUM', 'TECNOLOGIA', 'tecnofium.um.es', 
          'MENSUAL', '55667788M');

-- PERIODISTAS CONTRATADOS
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('11223344P', 'PEPA BUENO', 'pbueno@mail.com', 1050.5, 'R01',
         TO_DATE('01/01/2001', 'dd/mm/yyyy'), NULL); --sin tutor
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('44556677A', 'ANA PASTOR', 'apastor@mail.com', 2000, 'R02', 
         TO_DATE('04/04/2004', 'dd/mm/yyyy'), NULL); -- sin tutor
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('66778899J', 'JULIA OTERO', 'jotero@mail.com', 1100.5, 'R03', 
         TO_DATE('06/06/1999', 'dd/mm/yyyy'), NULL); --sin tutor
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('55667788M', 'MARIA GONZALEZ', 'mgonzalez@mail.com', 2150.5, 'R04', 
         TO_DATE('05/05/2014', 'dd/mm/yyyy'), NULL); --sin tutor
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('33445566M', 'MAMEN MENDIZABAL', 'mmendizabal@mail.com', 1505, 'R02', 
         TO_DATE('03/03/2003', 'dd/mm/yyyy'), '44556677A'); 
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('22334455A', 'AIMAR BRETOS', 'abretos@mail.com', 1230, 'R01', 
         TO_DATE('02/02/2002','dd/mm/yyyy'), '11223344P');
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('77889900L', 'LAURA CAMACHO', 'lcamacho@mail.com', 1500.0, 'R04', 
         TO_DATE('07/07/2018', 'dd/mm/yyyy'), '55667788M'); 
INSERT INTO 
 PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('88990011J', 'JORDI PEREZ', 'jperez@mail.com', 1375.5, 'R04', 
         TO_DATE('07/07/2017', 'dd/mm/yyyy'), '77889900L');

ALTER TABLE REVISTA ENABLE CONSTRAINT rev_fk_coordinador;
-- INSERT NUMERO
-- numeros de revista R01 NATURALIZA mensual
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R01', 1, TO_DATE('01/01/2022', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R01', 2, TO_DATE('01/02/2022', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R01', 3, TO_DATE('01/03/2022', 'dd/mm/yyyy'));

-- numeros de revista R02 semanal
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R02', 1, TO_DATE('06/03/2022', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R02', 2, TO_DATE('13/03/2022', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R02', 3, TO_DATE('20/03/2022', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R02', 4, TO_DATE('27/03/2022', 'dd/mm/yyyy'));
  
-- numeros de revista R03 trimestral
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R03', 1, TO_DATE('15/12/2021', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R03', 2, TO_DATE('15/03/2022', 'dd/mm/yyyy'));

-- numeros de revista R04 mensual
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R04', 1, TO_DATE('14/11/2021', 'dd/mm/yyyy'));
INSERT INTO NUMERO (revista, numero, fecha) 
  VALUES ('R04', 2, TO_DATE('14/12/2021', 'dd/mm/yyyy'));


-- SECCIONES
-- *** Ponemos un 0 como valor de la columna "num_articulos"        ***  
-- *** Como se indica el enunciado, al final de este script se debe *** 
-- *** incluir una sentencia UPDATE que calcule el valor correcto   *** 
-- *** para cada fila de SECCION (ejercicio 1.b)                    ***   
-- secciones revista R01 NATURALIZA
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',1, 'VIDA ANIMAL', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',1, 'ECOLOGIA', 0);
  
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',2, 'VIDA ANIMAL', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',2, 'ECOLOGIA', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',2, 'NATURALISMO', 0);

INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',3, 'ECOLOGIA', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R01',3, 'AGRICULTURA', 0);

-- secciones revista R02 FUENTE PRIMARIA
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',1, 'ACTUALIDAD', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',1, 'EDITORIAL', 0);

INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',2, 'ACTUALIDAD', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',2, 'EDITORIAL', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',2, 'EUROPA', 0);

INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',3, 'ACTUALIDAD', 0);
  
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R02',4, 'ACTUALIDAD', 0);  

-- secciones revista R03 VIAJAR HOY
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R03',1, 'AVENTURAS', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R03',1, 'VIAJES SOLIDARIOS', 0);
  
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R03',2, 'AVENTURAS', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R03',2, 'LIBROS SOBRE VIAJES', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R03',2, 'VIAJES SOLIDARIOS', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R03',2, 'FOTOGALERIA', 0);
  
-- secciones revista R04

INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R04',1, 'SEGURIDAD', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R04',1, 'GAMING', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R04',2, 'SEGURIDAD', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R04',2, 'GAMING', 0);
INSERT INTO SECCION (revista, numero, nombre, num_articulos)
  VALUES ('R04',2, 'CLOUD', 0);
  
-- PERIODISTAS FREELANCE

INSERT INTO PERIODISTA_FREELANCE (DNI, nombre, email, especialidad) 
  VALUES ('01234567G', 'JOSEFINA CARABIAS', 'jcarabias@mail.com', 'POLITICA');
INSERT INTO PERIODISTA_FREELANCE (DNI, nombre, email, especialidad) 
  VALUES ('12345678A', 'ANTONIO PAMPLIEGA', 'apampliega@mail.com', 'GUERRA');
INSERT INTO PERIODISTA_FREELANCE (DNI, nombre, email, especialidad) 
  VALUES ('23456789G', 'XAVIER ALDEKOA', 'xaldekoa@mail.com', 'AVENTURA');
INSERT INTO PERIODISTA_FREELANCE (DNI, nombre, email, especialidad) 
  VALUES ('45678901J', 'JON SISTIAGA', 'jsistiaga@mail.com', 'GUERRA');
INSERT INTO PERIODISTA_FREELANCE (DNI, nombre, email, especialidad) 
  VALUES ('78901234R', 'ROSA M CALAF','rcalaf@mail.com', 'VIAJES');

-- ARTICULOS 

-- articulos de la revista R03
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A001', 'RUTA POR EL OKAVANGO', 'INFORMACION', NULL, '01234567G', 
          'R03', 1, 'AVENTURAS');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A002', 'FALSOS GUIAS DE VIAJE', 'INFO+OPINION', NULL, '78901234R', 
          'R03', 1, 'AVENTURAS');          
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A003', 'PERDIDO EN ZAMBIA', 'INFORMACION', '66778899J', NULL, 
          'R03', 1, 'VIAJES SOLIDARIOS');          
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A004', 'ALEMANIA EN PRIMAVERA', 'INFORMACION', NULL, '78901234R', 
          'R03', 2, 'FOTOGALERIA');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A005', 'BRASIL DESCONOCIDO', 'INFO+OPINION', '66778899J', NULL,
          'R03', 2, 'AVENTURAS');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A006', 'APOYO A SOMALIA', 'INFORMACION', NULL, '01234567G',
          'R03', 2, 'VIAJES SOLIDARIOS'); 
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A007', 'HIJOS DEL NILO', 'INFO+OPINION', NULL, '01234567G',
          'R03', 2, 'LIBROS SOBRE VIAJES');          
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A008', 'RUTAS POR ISLANDIA', 'INFORMACION', NULL, '45678901J',
          'R03', 2, 'FOTOGALERIA');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A009', 'RUTAS POR EL LONDRES SOLIDARIO', 'INFORMACION', NULL, 
          '78901234R', 'R03', 1, 'VIAJES SOLIDARIOS');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A010', 'SER DENTISTA EN AFRICA', 'INFO+OPINION', NULL, '01234567G',
          'R03', 2, 'VIAJES SOLIDARIOS');
          
-- articulos de la revista R02
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A011', 'DEBATE ELECTORAL', 'INFO+OPINION', '44556677A', NULL,
          'R02', 1, 'ACTUALIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A012', 'POLEMICAS INVENTADAS', 'OPINION', '33445566M', NULL, 
          'R02', 1, 'EDITORIAL');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A013', 'CONFERENCIA DE PRESIDENTES EUROPEOS', 'INFO+OPINION', NULL, 
          '01234567G', 'R02', 2, 'EUROPA');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A014', 'LAS TERTULIAS EN TV COMO ARMA ELECTORAL', 'OPINION',
          '44556677A', NULL, 'R02', 2, 'EDITORIAL');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A015', 'DESINFORMACION POLITICA', 'OPINION', '44556677A', NULL, 
          'R02', 2, 'EDITORIAL');   
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A016', 'CONFLICTOS OLVIDADOS', 'INFORMACION', NULL, '12345678A', 
          'R02', 2, 'ACTUALIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A017', 'LA GUERRA MAS LARGA', 'INFORMACION', NULL, '12345678A',
          'R02', 3, 'ACTUALIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A018', 'ACUERDOS DIPLOMATICOS EUROPA-JAPON', 'INFO+OPINION', NULL, 
          '78901234R', 'R02', 4, 'ACTUALIDAD');  
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A019', 'PROMESAS ELECTORALES INCUMPLIDAS', 'INFORMACION', 
          '33445566M', NULL, 'R02', 4, 'ACTUALIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A020', 'CONFLICTOS ARMADOS SILENCIADOS', 'INFO+OPINION', NULL, 
          '12345678A', 'R02', 3, 'ACTUALIDAD');  
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A021', 'FAKE NEWS', 'INFO+OPINION', '44556677A', NULL, 
          'R02', 1, 'ACTUALIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A022', 'UN DIA CON EL PRESIDENTE', 'OPINION', '33445566M', NULL,
          'R02', 4, 'ACTUALIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A023', 'DIALOGOS DE BESUGOS', 'INFO+OPINION', '44556677A', NULL, 
          'R02', 2, 'EUROPA');

-- Articulos de la revista R01
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A024', 'LA RAPAZ GIGANTE DE LA AMAZONIA', 'INFORMACION', NULL, 
           '78901234R', 'R01', 1, 'VIDA ANIMAL');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A025', 'LA REGENERACION DE PORTMAN', 'INFORMACION', NULL, '01234567G',
          'R01', 1, 'ECOLOGIA');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A026', 'QUE SON LAS TECNOLOGIAS VERDES', 'INFORMACION', NULL,
          '78901234R', 'R01', 2, 'ECOLOGIA');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A027', 'NATURALISMO VS ECOLOGISMO', 'OPINION', NULL, '45678901J',
          'R01', 2, 'NATURALISMO');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A028', 'DESCUBRE LAS ISLAS MAURICIO', 'INFORMACION', NULL, 
          '78901234R', 'R01', 2, 'VIDA ANIMAL');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A029', 'QUE PASARIA SI SE EXTINGUIERAN LAS ABEJAS', 'INFO+OPINION', 
          NULL, '01234567G', 'R01', 2, 'NATURALISMO');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A030', 'TOXICOS EN EL AGUA', 'INFORMACION', '11223344P', NULL, 
          'R01', 3, 'AGRICULTURA'); 
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A031', 'RECUPERAR EL SUELO AGRARIO', 'INFORMACION', '22334455A', NULL, 
          'R01', 3, 'AGRICULTURA');           
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A032', 'DIA MUNDIAL DEL AGUA', 'INFORMACION', '22334455A', NULL, 
          'R01', 3, 'ECOLOGIA');           

-- articulos de la revista R04       
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A033', 'LANZAMIENTO DE RETURN TO MONKEY ISLAND', 'OPINION', 
          '55667788M', NULL, 'R04', 1, 'GAMING');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A034', 'POKEMON GO FEST 2022', 'INFO+OPINION', '55667788M', NULL,
          'R04', 1, 'GAMING');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A035', 'GUERRA TECNOLOGICA', 'INFO+OPINION', '77889900L', NULL, 
          'R04', 1, 'SEGURIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A036', 'FORNITE: SKINS BASADAS EN ASSASSINS CREED', 'INFORMACION', 
          '55667788M', NULL, 'R04', 2, 'GAMING');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A037', 'MALWARE EN GOOGLE PLAY', 'INFORMACION', '77889900L', NULL, 
          'R04', 1, 'SEGURIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A038', 'LOS MEJORES MOODS DE ELDEN RING', 'INFO+OPINION', 
          '55667788M', NULL, 'R04', 2, 'GAMING');

INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A039', 'CIBERATAQUE EN IBERDROLA', 'INFORMACION', '77889900L', NULL,  
          'R04', 2, 'SEGURIDAD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A040', 'EL MAYOR ROBO DE CRIPTOMONEDA DE LA HISTORIA', 'INFORMACION',
          '77889900L', NULL, 'R04', 2, 'SEGURIDAD');          
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A041', 'TELEFONICA MIGRA SUS BASES DE DATOS A LA NUBE DE ORACLE',
          'INFORMACION', '88990011J', NULL, 'R04', 2, 'CLOUD');
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A042', 'EL 30% DE LAS EMPRESAS NO TIENE UNA ESTRATEGIA CLOUD',
          'INFORMACION', '88990011J', NULL, 'R04', 2, 'CLOUD');          
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A043', 'VIAJAR CON SENTIDO COMUN', 'INFORMACION', '66778899J', NULL,
          NULL, NULL, NULL);   
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A044', 'PAC-MAN REVISITED', 'INFORMACION', '55667788M', NULL,
          NULL, NULL, NULL);  
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A045', 'COMO PROTEGER TU MOVIL', 'INFORMACION', '77889900L', NULL,  
          'R04', 2, 'SEGURIDAD');          
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A046', 'EL SUEÑO DE AFRICA', 'INFO+OPINION', NULL, '01234567G',
          'R03', 2, 'LIBROS SOBRE VIAJES');   
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A047', 'SALVAJE', 'INFO+OPINION','66778899J', NULL, 
          'R03', 2, 'LIBROS SOBRE VIAJES'); 
INSERT INTO
  ARTICULO (id, titulo, tipo, periodista, freelance, revista, numero, seccion)
  VALUES ('A048', 'EN LAS ANTIPODAS', 'INFO+OPINION', NULL, '45678901J',
          'R03', 2, 'LIBROS SOBRE VIAJES'); 
          
-- COLABORACIONES entre freelances y revistas

INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('12345678A', 'R01', 100);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('12345678A', 'R02', 120);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)

  VALUES ('45678901J', 'R01', 200);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('45678901J', 'R03', 250);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)

  VALUES ('78901234R', 'R01', 400);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('78901234R', 'R02', 450);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('78901234R', 'R03', 475);

INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('01234567G', 'R01', 500);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('01234567G', 'R02', 550);
INSERT INTO COLABORACION (freelance, revista, pago_articulo)
  VALUES ('01234567G', 'R03', 575);
--------------------------------------------------------------------------------------
-- b. Calculo de valores de la columna SECCION.num_articulos
UPDATE SECCION S SET num_articulos = (SELECT COUNT(*)
                                      FROM ARTICULO A
                                      WHERE A.revista = S.revista
                                         AND A.numero = S.numero
                                         AND A.seccion = S.nombre);

-- confirmar todos los datos introducidos
COMMIT;  
