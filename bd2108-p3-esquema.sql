/*
Asignatura: Bases de Datos
Curso: 2021/22
Convocatoria: junio

Practica: P3. Definicion y Modificacion de Datos en SQL

Equipo de practicas: bd2108
 Integrante 1: Radoslaw Krzysztof Krolikowski 
 Integrante 2: JungPeng Jin
*/

-- EJERCICIO 0. Sentencias CREATE definitivas
DROP TABLE COLABORACION;
DROP TABLE ARTICULO;
DROP TABLE PERIODISTA_FREELANCE;
DROP TABLE SECCION;
DROP TABLE NUMERO;
ALTER TABLE PERIODISTA_CONTRATADO DROP CONSTRAINT per_contratado_fk_revista CASCADE;
DROP TABLE REVISTA;
DROP TABLE PERIODISTA_CONTRATADO;

CREATE TABLE REVISTA (
id              CHAR(3)         NOT NULL,
nombre          CHAR(15)        NOT NULL,
tema            CHAR(10)        NOT NULL,
web             VARCHAR2(20)    NULL,
periodicidad    CHAR(10)        NOT NULL,
coordinador     CHAR(9)         NOT NULL,   --COORDINADOR SE IDENTIFICA CON DNI
CONSTRAINT rev_pk       PRIMARY KEY(id),
CONSTRAINT rev_ak1      UNIQUE(nombre),
CONSTRAINT rev_ak2      UNIQUE(coordinador),
CONSTRAINT rev_perio_ok CHECK(periodicidad IN ('SEMANAL', 'QUINCENAL', 'MENSUAL', 'BIMESTRAL', 'TRIMESTRAL', 'ANUAL'))
);

CREATE TABLE NUMERO (
revista         CHAR(3)           NOT NULL,
numero          NUMBER(9)         NOT NULL,
fecha           DATE              NOT NULL,
CONSTRAINT numero_pk              PRIMARY KEY (numero,revista),
CONSTRAINT numero_fk_revista FOREIGN KEY (revista) REFERENCES REVISTA(id) 
                                        -- ON DELETE CASCADE
                                        -- ON UPDATE CASCADE 
);

CREATE TABLE SECCION (
revista         CHAR(3)         NOT NULL,
numero          NUMBER(9)       NOT NULL,
nombre          CHAR(20)        NOT NULL,
num_articulos   NUMBER(20)      NOT NULL,
CONSTRAINT seccion_pk           PRIMARY KEY (nombre,revista,numero),
CONSTRAINT seccion_fk_revista_numero FOREIGN KEY (revista,numero) REFERENCES NUMERO(revista,numero) 
                                        -- ON DELETE CASCADE
                                        -- ON UPDATE CASCADE
);

CREATE TABLE PERIODISTA_CONTRATADO (
dni             CHAR(9)         NOT NULL,
nombre          VARCHAR2(30)    NOT NULL,
email           VARCHAR2(20)    NOT NULL,
sueldo          NUMBER(5,1)       NOT NULL,
revista         CHAR(3)         NOT NULL,
fecha_contrato  DATE            NOT NULL,
tutor           CHAR(9)         NULL,
CONSTRAINT per_contratado_pk            PRIMARY KEY(dni),
CONSTRAINT per_contratado_ak            UNIQUE(email),
CONSTRAINT per_contratado_tutor_ok CHECK (dni <> tutor),
CONSTRAINT per_contratado_sueldo_ok CHECK (sueldo > 0),
CONSTRAINT per_contratado_fk_revista FOREIGN KEY (revista) REFERENCES REVISTA(id),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE                       
CONSTRAINT per_contratado_fk_tutor FOREIGN KEY (tutor) REFERENCES PERIODISTA_CONTRATADO(dni)
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
);

CREATE TABLE PERIODISTA_FREELANCE (
dni             CHAR(9)         NOT NULL,
nombre          VARCHAR2(20)    NOT NULL,
email           VARCHAR2(20)    NOT NULL,
especialidad    CHAR(10)        NOT NULL,
CONSTRAINT per_freelance_pk     PRIMARY KEY(dni),
CONSTRAINT per_freelance_ak     UNIQUE(email)
);

CREATE TABLE COLABORACION (
freelance        CHAR(9)     NOT NULL,
revista          CHAR(3)     NOT NULL,
pago_articulo    NUMBER(5,2)   NOT NULL,
CONSTRAINT colaboracion_pk              PRIMARY KEY (freelance,revista),
CONSTRAINT colaboracion_fk_freelance FOREIGN KEY (freelance) REFERENCES PERIODISTA_FREELANCE(dni),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
CONSTRAINT colaboracion_fk_revista FOREIGN KEY (revista) REFERENCES REVISTA(id)
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
);

CREATE TABLE ARTICULO (
id              CHAR(5)         NOT NULL,
titulo          VARCHAR2(60)    NOT NULL,
tipo            CHAR(20)        NOT NULL,
periodista      CHAR(9)         NULL, --CONTRATADO SE IDENTIFICA CON DNI
freelance       CHAR(9)         NULL, --FREELANCE SE IDENTIFICA CON DNI
revista         CHAR(3)         NULL, --REVISTA SE IDENTIFICA CON UN IDR DE 3 LETRAS
numero          NUMBER(9)       NULL,
seccion         CHAR(20)        NULL,
CONSTRAINT art_pk       PRIMARY KEY(id),
CONSTRAINT art_tipo_ok  CHECK(tipo IN ('INFORMACION', 'OPINION', 'INFO+OPINION')),
CONSTRAINT art_noigual_dni CHECK (freelance <> periodista),
CONSTRAINT art_freelance_or_contratado CHECK ((freelance = NULL AND periodista <> NULL) OR (freelance <> NULL AND periodista = NULL)),
CONSTRAINT art_fk_freelance FOREIGN KEY (freelance) REFERENCES PERIODISTA_FREELANCE(dni),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
CONSTRAINT art_fk_contratado FOREIGN KEY (periodista) REFERENCES PERIODISTA_CONTRATADO(dni),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE                                        
CONSTRAINT art_fk_seccion_revista_numero FOREIGN KEY (seccion,revista,numero) REFERENCES SECCION(nombre,revista,numero), 
                                        -- ON DELETE SET NULL
                                        -- ON UPDATE CASCADE
CONSTRAINT art_valores_seccion_ok CHECK ((seccion = NULL AND revista = NULL AND numero = NULL) OR (seccion <> NULL AND revista <> NULL AND numero <> NULL)));

ALTER TABLE REVISTA ADD CONSTRAINT rev_fk_coordinador FOREIGN KEY (coordinador) REFERENCES PERIODISTA_CONTRATADO(dni)
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
;