/*
Asignatura: Bases de datos
Curso: 2021/2022
Convocatoria: Junio

Practica: P2. Consultas en SQL

Equipo de practicas: bd2108
 Integrante 1: Radoslaw Krzysztof Krolikowski
 Integrante 2: JungPeng Jin
*/

-- EJERCICIOS
/* 1)Solicitudes de alquiler de coches del garaje con código 'G1' realizadas a través de la
    agencia con código 'A4', ordenado por identificador de alquiler.
    Columnas: (id, fecha_inicio, fecha_fin, coche, marca, modelo). */
SELECT id, fecha_inicio, fecha_fin, matricula, marca, modelo
FROM ALQUILER, COCHE C
WHERE agencia = 'A4'
    AND (id, C.matricula) IN (SELECT alquiler, coche
                                FROM DETALLE_ALQUILER
                                WHERE coche IN (SELECT matricula
                                                FROM COCHE
                                                WHERE garaje = 'G1'))
ORDER BY id;

/* 2)Primera solicitud de alquiler que se inició y período de duración. La columna
    cuantos_dias ha de contener el número de días que duró el alquiler.
    Columnas: (id, fecha_inicio, fecha_fin, cuantos_dias)*/
SELECT id, fecha_inicio, fecha_fin, (fecha_fin-fecha_inicio)+1 cuantos_dias
FROM ALQUILER
WHERE fecha_inicio IN (SELECT MIN(fecha_inicio)
                       FROM ALQUILER);
                       
/* 3)Garajes de los que nunca se ha alquilado ningún coche. Columnas: (codigo, nombre).*/
SELECT codigo, nombre
FROM GARAJE
WHERE codigo NOT IN(SELECT garaje
                    FROM coche);

/* 4)Clientes que hayan alquilado algún coche de la marca ‘Volkswagen’ más de 2 veces. Se
    debe considerar los alquileres individuales de los coches, es decir, si una misma
    solicitud de alquiler consiste en el alquiler de varios coches de esta marca, debe
    contabilizarse cada uno de ellos. Columnas: (dni, nombre).*/
SELECT dni, nombre
FROM CLIENTE
WHERE codigo IN (SELECT cliente
                     FROM ALQUILER Q
                     WHERE id IN (SELECT alquiler
                                     FROM DETALLE_ALQUILER
                                     WHERE coche IN (SELECT matricula
                                                        FROM COCHE
                                                        WHERE marca = 'VOLKSWAGEN'))
                     GROUP BY Q.cliente
                     HAVING COUNT(*) >= 2);

/* 5)Coche que más veces ha sido alquilado por el mismo cliente, indicando cuántas veces
    ha sido alquilado. Columnas: (coche, cliente, cuantos_alquileres).*/
SELECT coche, cliente, COUNT(*) cuantos_alquileres
FROM (DETALLE_ALQUILER D JOIN ALQUILER Q ON D.alquiler = Q.id)
GROUP BY cliente,coche
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                  FROM (DETALLE_ALQUILER D JOIN ALQUILER Q ON D.alquiler = Q.id)
                  GROUP BY cliente,coche);
                  
/* 6)Para cada cliente (codigo, nombre), mostrar su último alquiler (id, fecha_inicio).
    También deben aparecer los clientes que no han solicitado ningún alquiler, mostrando
    en la columna id la cadena de caracteres ‘---’ y en fecha_inicio un NULL (o vacío).
    Ordenado por código de cliente. Columnas: (codigo, nombre, id, fecha_inicio).*/
SELECT T.codigo, T.nombre, NVL(Z.id, '---'), Z.fecha_inicio
FROM (CLIENTE T LEFT JOIN (SELECT codigo, nombre, fecha_inicio, id
                            FROM CLIENTE , ALQUILER 
                            WHERE cliente = codigo 
                                AND fecha_inicio = (SELECT MAX(fecha_inicio)
                                                    FROM ALQUILER 
                                                    WHERE codigo = cliente)) Z ON T.codigo = Z.codigo);
                                            
/* 7)Alquileres (id) que incluyen dos coches (coche), es decir, con sólo dos coches en el
    detalle de los alquileres individuales (por coche) en que consiste, y mediante qué
    agencia se ha contratado (agencia)*/
SELECT D.alquiler, D.coche, Q.agencia
FROM (DETALLE_ALQUILER D JOIN ALQUILER Q ON Q.id = D.alquiler)
WHERE D.alquiler IN (SELECT alquiler
                     FROM DETALLE_ALQUILER
                     GROUP BY alquiler
                     HAVING COUNT(*) = 2)
ORDER BY alquiler;

/* 8)Clientes que sólo han solicitado alquileres [una o muchas veces] a través de una única
    agencia, indicando qué agencia es, por orden de código de cliente.
    Columnas: (cliente, agencia)*/
SELECT Z.cliente, Q.agencia
FROM ALQUILER Q JOIN (SELECT cliente
                      FROM (SELECT cliente, agencia
                            FROM ALQUILER
                            GROUP BY cliente, agencia)
                      GROUP BY cliente
                      HAVING COUNT(*) = 1) Z ON Q.cliente = Z.cliente
GROUP BY Z.cliente, Q.agencia
ORDER BY Z.cliente;

/* 9)Clientes (dni, nombre) que han solicitado alquileres por medio de todas las agencias.*/                                   
SELECT dni, nombre
FROM CLIENTE T
WHERE NOT EXISTS (SELECT *
                  FROM AGENCIA
                  WHERE codigo NOT IN
                    (SELECT agencia
                     FROM ALQUILER
                     WHERE T.codigo = cliente));
                  
/* *****10)Identificador y coste del alquiler más caro realizado para cada marca y modelo de
    coche (alquiler, marca, modelo, coste_coche). Obviamente, se debe considerar los
    alquileres individuales de los coches.*/                          



                   
                       
                       