/*
Asignatura: Bases de Datos
Curso: 2021/22
Convocatoria: junio

Practica: P3. Definicion y Modificacion de Datos en SQL

Equipo de practicas: bd2108
 Integrante 1: Radoslaw Krzysztof Krolikowski
 Integrante 2: JungPeng Jin
*/

--------------------------------------------------------------------------------------
-- EJERCICIO 2. Insertar comentarios de tabla y de columna en el Diccionario de Datos
-- a)
COMMENT ON TABLE ARTICULO IS 'Tabla donde definimos los artículos. Donde tendrá el título, el tipo, autor del artículo, la revista, el número y la sección que pertenezca.';

COMMENT ON COLUMN PERIODISTA_FREELANCE.dni IS 'Clave principal de la tabla, sirve para identificar el periodista freelance.';
COMMENT ON COLUMN PERIODISTA_FREELANCE.nombre IS 'Nombre del periodista freelance.';
COMMENT ON COLUMN PERIODISTA_FREELANCE.email IS 'Clave secundaria de la tabla,también sirve para identificar el periodista freelance.';
COMMENT ON COLUMN PERIODISTA_FREELANCE.especialidad IS 'Campo en el que esta el periodista especializado.';

-- b)
SELECT * 
FROM USER_TAB_COMMENTS;

SELECT * 
FROM USER_COL_COMMENTS;

-- c)
-- El uso de la sentencia COMMENT si pertenece al LDD

--------------------------------------------------------------------------------------
-- EJERCICIO 3. Modificar valores de una columna
-- a)
SELECT nombre, freelance, revista, pago_articulo
FROM COLABORACION C JOIN PERIODISTA_FREELANCE P ON freelance = dni 
WHERE freelance IN (SELECT freelance
                FROM COLABORACION
                GROUP BY freelance
                HAVING COUNT(*) > 2);
-- b)
UPDATE COLABORACION C SET C.pago_articulo = C.pago_articulo*1.03
WHERE C.freelance in (SELECT freelance
                      FROM COLABORACION
                      GROUP BY freelance
                      HAVING COUNT(*) > 2);
-- c)
SELECT nombre, freelance, revista, pago_articulo
FROM COLABORACION C JOIN PERIODISTA_FREELANCE P ON freelance = dni 
WHERE freelance IN (SELECT freelance
                FROM COLABORACION
                GROUP BY freelance
                HAVING COUNT(*) > 2);
-- d)
ROLLBACK;

-- e)
SELECT nombre, freelance, revista, pago_articulo
FROM COLABORACION C JOIN PERIODISTA_FREELANCE P ON freelance = dni 
WHERE freelance IN (SELECT freelance
                FROM COLABORACION
                GROUP BY freelance
                HAVING COUNT(*) > 2);

--------------------------------------------------------------------------------------
-- EJERCICIO 4. Modificar una clave primaria de manera ordenada: cambiar el DNI de un periodista contratado
-- a)
ALTER TABLE PERIODISTA_CONTRATADO DISABLE CONSTRAINT per_contratado_fk_tutor;
ALTER TABLE ARTICULO DISABLE CONSTRAINT art_fk_contratado;
ALTER TABLE REVISTA DISABLE CONSTRAINT rev_fk_coordinador;
UPDATE PERIODISTA_CONTRATADO SET DNI = '99001122P'
WHERE DNI = (SELECT DNI
             FROM PERIODISTA_CONTRATADO
             WHERE DNI = '11223344P');
UPDATE PERIODISTA_CONTRATADO SET TUTOR = '99001122P'
WHERE TUTOR = (SELECT TUTOR
               FROM PERIODISTA_CONTRATADO
               WHERE TUTOR = '11223344P');
UPDATE ARTICULO SET PERIODISTA = '99001122P'
WHERE PERIODISTA = (SELECT PERIODISTA
                    FROM ARTICULO
                    WHERE PERIODISTA = '11223344P');
UPDATE REVISTA SET COORDINADOR = '99001122P'
WHERE COORDINADOR = (SELECT COORDINADOR
                     FROM REVISTA
                     WHERE COORDINADOR = '11223344P');
ALTER TABLE REVISTA ENABLE CONSTRAINT rev_fk_coordinador;
ALTER TABLE ARTICULO ENABLE CONSTRAINT art_fk_contratado;
ALTER TABLE PERIODISTA_CONTRATADO ENABLE CONSTRAINT per_contratado_fk_tutor;

--------------------------------------------------------------------------------------
-- EJERCICIO 5. Intercambiar los periodistas contratados de dos revistas diferentes
-- a)
SELECT dni, nombre, revista
FROM PERIODISTA_CONTRATADO
WHERE REVISTA = 'R01'
    OR REVISTA = 'R02';

-- b)
ALTER TABLE PERIODISTA_CONTRATADO DISABLE CONSTRAINT per_contratado_fk_revista;
UPDATE PERIODISTA_CONTRATADO P SET REVISTA = 'R07'
WHERE REVISTA = 'R01';

UPDATE PERIODISTA_CONTRATADO P SET REVISTA = 'R01'
WHERE REVISTA = 'R02';

UPDATE PERIODISTA_CONTRATADO P SET REVISTA = 'R02'
WHERE REVISTA = 'R07';

ALTER TABLE PERIODISTA_CONTRATADO ENABLE CONSTRAINT per_contratado_fk_revista;

-- c)
SELECT dni, nombre, revista
FROM PERIODISTA_CONTRATADO
WHERE REVISTA = 'R01'
    OR REVISTA = 'R02';

-- d)
ROLLBACK; -- No se ha vuelto al estado original ya que al final la transacción se obtuvo un COMMIT que ha hecho que la información se almacene permanentemente
ALTER TABLE PERIODISTA_CONTRATADO DISABLE CONSTRAINT per_contratado_fk_revista;
UPDATE PERIODISTA_CONTRATADO P SET REVISTA = 'R07'
WHERE REVISTA = 'R02';

UPDATE PERIODISTA_CONTRATADO P SET REVISTA = 'R02'
WHERE REVISTA = 'R01';

UPDATE PERIODISTA_CONTRATADO P SET REVISTA = 'R01'
WHERE REVISTA = 'R07';

ALTER TABLE PERIODISTA_CONTRATADO ENABLE CONSTRAINT per_contratado_fk_revista;

--------------------------------------------------------------------------------------
-- EJERCICIO 6. Borrar algunos artículos
-- a)
DELETE FROM ARTICULO A
WHERE ( revista, numero)  in (SELECT revista,numero
             FROM NUMERO N
             WHERE N.fecha < '31/12/2021')
  AND periodista IN (SELECT dni
                     FROM PERIODISTA_CONTRATADO
                     WHERE dni NOT IN (SELECT COORDINADOR
                                       FROM REVISTA));
COMMIT;

--------------------------------------------------------------------------------------
-- EJERCICIO 7. Borrar una revista
DELETE FROM ARTICULO
WHERE revista = 'R01';

DELETE FROM COLABORACION
WHERE revista = 'R01';

DELETE FROM SECCION
WHERE revista = 'R01';

DELETE FROM NUMERO
WHERE revista = 'R01';

ALTER TABLE REVISTA DISABLE CONSTRAINT rev_fk_coordinador;
ALTER TABLE PERIODISTA_CONTRATADO DISABLE CONSTRAINT per_contratado_fk_revista;
DELETE FROM PERIODISTA_CONTRATADO
WHERE revista = 'R01';
DELETE FROM REVISTA
WHERE id = 'R01';
ALTER TABLE PERIODISTA_CONTRATADO ENABLE CONSTRAINT per_contratado_fk_revista;
ALTER TABLE REVISTA ENABLE CONSTRAINT rev_fk_coordinador;

--------------------------------------------------------------------------------------
-- EJERCICIO 8. Eliminar algunas columnas
-- a)
ALTER TABLE REVISTA
DROP COLUMN web;
ALTER TABLE REVISTA
DROP COLUMN periodicidad;
-- b) Sí es posible borrar las dos columnas en una sola sentencia
ALTER TABLE REVISTA
DROP (web, periodicidad);

--------------------------------------------------------------------------------------
-- EJERCICIO 9. Crear y manipular una vista
-- a)
CREATE VIEW CONTRATO 
AS SELECT R.nombre revista, C.nombre periodista, C.sueldo, C.fecha_contrato contrato, ROUND((SYSDATE - C.fecha_contrato) / 365) años, NVL(num, 0) articulos
FROM PERIODISTA_CONTRATADO C LEFT JOIN (SELECT  A.periodista, COUNT(*) num
                                        FROM ARTICULO A 
                                        GROUP BY A.periodista
                                        HAVING A.periodista IS NOT NULL) A
ON A.periodista = C.dni, REVISTA R 
WHERE c.revista = r.id;
-- b)
SELECT *
FROM CONTRATO
ORDER BY revista, periodista;

-- c)
CREATE OR REPLACE VIEW CONTRATO 
AS SELECT R.nombre revista, C.nombre periodista,(sueldo - (sueldo * 0.21)) sueldo, ROUND((SYSDATE - C.fecha_contrato) / 365) años, NVL(num, 0) articulos
FROM PERIODISTA_CONTRATADO C LEFT JOIN (SELECT  A.periodista, COUNT(*) num
                                        FROM ARTICULO A 
                                        GROUP BY A.periodista
                                        HAVING A.periodista IS NOT NULL) A
ON A.periodista = C.dni, REVISTA R 
WHERE c.revista = r.id;

-- d)
SELECT *
FROM CONTRATO
ORDER BY revista, periodista;

-- e)
INSERT INTO PERIODISTA_CONTRATADO (DNI, nombre, email, sueldo, revista, fecha_contrato, tutor) 
 VALUES ('12332112G', 'PEPE MALO', 'pmalo@mail.com', 1000, 'R03', TO_DATE('01/01/2015', 'dd/mm/yyyy'), NULL); --sin tutor
-- el sueldo en la vista si se ha cambiado

--------------------------------------------------------------------------------------
-- EJERCICIO 10. Crear y cargar una tabla, y modificar (alterar) su estructura
-- a)
CREATE TABLE PUBLICACION (id_revista, nombre_revista, cuantos_contratado, cuantos_freelance)
AS SELECT id, nombre, num_contratados, NVL(num_freelance, 0)
FROM (REVISTA R LEFT JOIN (SELECT P.revista, COUNT (*) num_contratados
                            FROM PERIODISTA_CONTRATADO P
                            GROUP BY P.revista
                            HAVING P.revista IS NOT NULL) A ON R.id = A.revista) LEFT JOIN (SELECT revista, COUNT(*) num_freelance
                                                                                            FROM COLABORACION 
                                                                                            GROUP by revista) C ON id = C.revista;

-- b)
SELECT *
FROM PUBLICACION
ORDER BY id_revista;

-- c)
ALTER TABLE PUBLICACION
ADD cuantos_articulos number(5) default 0 not null;

-- d)
UPDATE PUBLICACION P SET cuantos_articulos = (SELECT COUNT(*)
                                              FROM ARTICULO A
                                              WHERE A.revista = P.id_revista);
-- e)
SELECT *
FROM PUBLICACION
ORDER BY id_revista;

--------------------------------------------------------------------------------------
-- EJERCICIO 11. Restricciones de integridad
-- RI1
-- CREATE ASSERTION RI1_revista_contratado
-- CHECK (NOT EXISTS 
                    (SELECT *
                     FROM PERIODISTA_CONTRATADO
                     WHERE revista NOT IN (SELECT id
                                           FROM REVISTA)));      
                                         
-- RI2
-- CREATE ASSERTION RI2_seccion_articulo
-- CHECK (NOT EXISTS 
                    (SELECT *
                     FROM SECCION
                     WHERE num_articulos < 0));

-- RI3
-- CREATE ASSERTION RI3_periodista_contratado
-- CHECK (NOT EXISTS 
                    (SELECT *
                     FROM REVISTA
                     WHERE (id,coordinador) NOT IN (SELECT revista, dni
                                                    FROM PERIODISTA_CONTRATADO)));

                   









