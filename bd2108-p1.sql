/*Equipo bd2108
Radoslaw Krzysztof Krolikowski X8799447S
JungPeng Jin X4745127C*/


--borrar las tablas
DROP TABLE COLAB;
DROP TABLE ARTICULO;
DROP TABLE PERIODISTA_FREELANCE;
DROP TABLE SECCION;
DROP TABLE NUMERO;
ALTER TABLE PERIODISTA_CONTRATADO DROP CONSTRAINT per_contratado_fk_revista CASCADE;
DROP TABLE REVISTA;
DROP TABLE PERIODISTA_CONTRATADO;

CREATE TABLE REVISTA (
idr             CHAR(3)         NOT NULL,
nombre          CHAR(15)        NOT NULL,
web             VARCHAR2(15)    NULL,
tema            CHAR(10)        NOT NULL,
periodicidad    CHAR(10)        NOT NULL,
coordinador     CHAR(9)         NOT NULL,--COORDINADOR SE IDENTIFICA CON DNI
CONSTRAINT rev_pk       PRIMARY KEY(idr),
CONSTRAINT rev_ak1      UNIQUE(nombre),
CONSTRAINT rev_ak2      UNIQUE(coordinador),
CONSTRAINT rev_perio_ok CHECK(periodicidad IN ('semanal', 'quincenal', 'mensual', 'bimestral', 'trimestral', 'anual'))
);

CREATE TABLE PERIODISTA_CONTRATADO (
dni             CHAR(9)         NOT NULL,
nombre          VARCHAR2(15)    NOT NULL,
email           VARCHAR2(15)    NOT NULL,
sueldo          NUMBER(5)       NOT NULL,
fecha_contrato  DATE            NOT NULL,
revista         CHAR(3)         NOT NULL,
tutor           CHAR(9)         NULL,
CONSTRAINT per_contratado_pk            PRIMARY KEY(dni),
CONSTRAINT per_contratado_ak            UNIQUE(email),
CONSTRAINT per_contratado_fk_revista FOREIGN KEY (revista) REFERENCES REVISTA(idr),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE                       
CONSTRAINT per_contratado_fk_tutor FOREIGN KEY (tutor) REFERENCES PERIODISTA_CONTRATADO(dni)
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
                                        
);

CREATE TABLE PERIODISTA_FREELANCE (
dni             CHAR(9)         NOT NULL,
nombre          VARCHAR2(15)    NOT NULL,
email           VARCHAR2(15)    NOT NULL,
especialidad    CHAR(10)        NOT NULL,
CONSTRAINT per_freelance_pk     PRIMARY KEY(dni),
CONSTRAINT per_freelance_ak     UNIQUE(email)
);

CREATE TABLE NUMERO (
fecha           DATE            NOT NULL,
numero          NUMBER(9)       NOT NULL,
revista         CHAR(3)         NOT NULL,
CONSTRAINT numero_pk            PRIMARY KEY (numero,revista),
CONSTRAINT numero_fk_revista FOREIGN KEY (revista) REFERENCES REVISTA(idr) ON DELETE CASCADE
                                        -- ON UPDATE CASCADE 
);

CREATE TABLE SECCION (
nombre          CHAR(10)        NOT NULL,
num_articulos   NUMBER(20)      NOT NULL,
revista         CHAR(3)         NOT NULL,
numero          NUMBER(9)       NOT NULL,
CONSTRAINT seccion_pk                   PRIMARY KEY (nombre,revista,numero),
CONSTRAINT seccion_fk_revista_numero FOREIGN KEY (revista,numero) REFERENCES NUMERO(revista,numero) ON DELETE CASCADE
                                        -- ON UPDATE CASCADE
);

CREATE TABLE ARTICULO (
ida             CHAR(5)         NOT NULL,
tipo            CHAR(10)        NOT NULL,
titulo          VARCHAR2(15)    NOT NULL,
contratado      CHAR(9)         NULL, --CONTRATADO SE IDENTIFICA CON DNI
freelance       CHAR(9)         NULL, --FREELANCE SE IDENTIFICA CON DNI
seccion         CHAR(10)        NULL,
revista         CHAR(3)         NULL, --REVISTA SE IDENTIFICA CON UN IDR DE 3 LETRAS
numero          NUMBER(9)     NULL,
CONSTRAINT art_pk       PRIMARY KEY(ida),
CONSTRAINT art_tipo_ok  CHECK(tipo IN ('informacion', 'opinion', 'info+opinion')),
CONSTRAINT art_noigual_dni CHECK(freelance <> contratado),
CONSTRAINT art_fk_freelance FOREIGN KEY (freelance) REFERENCES PERIODISTA_FREELANCE(dni),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
CONSTRAINT art_fk_contratado FOREIGN KEY (contratado) REFERENCES PERIODISTA_CONTRATADO(dni),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE                                        
CONSTRAINT art_fk_seccion_revista_numero FOREIGN KEY (seccion,revista,numero) REFERENCES SECCION(nombre,revista,numero) ON DELETE SET NULL
                                        -- ON UPDATE CASCADE
);

CREATE TABLE COLAB (
freelance        CHAR(9)     NOT NULL,
revista                     CHAR(3)     NOT NULL,
pago_articulo               NUMBER(5)   NOT NULL,
CONSTRAINT colaboracion_pk              PRIMARY KEY (freelance,revista),
CONSTRAINT colaboracion_fk_freelance FOREIGN KEY (freelance) REFERENCES PERIODISTA_FREELANCE(dni),
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
CONSTRAINT colaboracion_fk_revista FOREIGN KEY (revista) REFERENCES REVISTA(idr)
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE
);

--claves ajenas
ALTER TABLE REVISTA ADD CONSTRAINT rev_fk_coordinador FOREIGN KEY (coordinador) REFERENCES PERIODISTA_CONTRATADO(dni);
                                        -- ON DELETE NO ACTION
                                        -- ON UPDATE CASCADE


                                    


















