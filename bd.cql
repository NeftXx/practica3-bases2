CREATE KEYSPACE sist_practica3_201504420 WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1'};
describe keyspaces

use sist_practica3_201504420;

CREATE TABLE temporal_carga(
  Nombre_1 TEXT,
  Apellido_1 TEXT,
  CUI_1 TEXT,
  Email_1 TEXT,
  FechaRegistro_1 DATE,
  Genero_1 TEXT,
  InstitucionBancaria_1 TEXT,
  AbreviacionInstitucion_1 TEXT,
  TipoCuenta_1 TEXT,
  SaldoInicial_1 DECIMAL,
  Nombre_2 TEXT,
  Apellido_2 TEXT,
  CUI_2 TEXT,
  Email_2 TEXT,
  FechaRegistro_2 DATE,
  Genero_2 TEXT,
  InstitucionBancaria_2 TEXT,
  AbreviacionInstitucion_2 TEXT,
  TipoCuenta_2 TEXT,
  SaldoInicial_2 DECIMAL,
  MontoTransferencia DECIMAL,
  FechaTransferencia TIMESTAMP,
  PRIMARY KEY (
    (CUI_1, CUI_2),
    InstitucionBancaria_1,
    TipoCuenta_1,
    InstitucionBancaria_2,
    TipoCuenta_2,
    FechaTransferencia
  )
) WITH CLUSTERING ORDER BY (
  InstitucionBancaria_1 ASC,
  TipoCuenta_1 ASC,
  InstitucionBancaria_2 ASC,
  TipoCuenta_2 ASC,
  FechaTransferencia DESC
);

describe tables;

COPY temporal_carga(
  Nombre_1,
  Apellido_1,
  CUI_1,
  Email_1,
  FechaRegistro_1,
  Genero_1,
  InstitucionBancaria_1,
  AbreviacionInstitucion_1,
  TipoCuenta_1,
  SaldoInicial_1,
  Nombre_2,
  Apellido_2,
  CUI_2,
  Email_2,
  FechaRegistro_2,
  Genero_2,
  InstitucionBancaria_2,
  AbreviacionInstitucion_2,
  TipoCuenta_2,
  SaldoInicial_2,
  MontoTransferencia,
  FechaTransferencia
) FROM './practica3-bases2/ArchivoEntrada.csv' WITH HEADER = TRUE AND DELIMITER=';';

CREATE TABLE instituciones (
  nombre TEXT,
  abreviacion TEXT,
  PRIMARY KEY ((nombre), abreviacion)
) WITH CLUSTERING ORDER BY(abreviacion asc);

COPY instituciones FROM './practica3-bases2/Instituciones1.csv' WITH HEADER = TRUE AND DELIMITER=',';
COPY instituciones FROM './practica3-bases2/Instituciones2.csv' WITH HEADER = TRUE AND DELIMITER=',';

select * from instituciones;

CREATE TABLE cuentas (
  nombre TEXT,
  apellido TEXT,
  cui TEXT,
  institucion TEXT,
  abreviacion TEXT,
  tipo_cuenta TEXT,
  saldo_inicial DECIMAL,
  PRIMARY KEY ((cui, institucion, tipo_cuenta), nombre, apellido)
) WITH CLUSTERING ORDER BY (nombre asc, apellido asc);

COPY cuentas (
  nombre,
  apellido,
  cui,
  institucion,
  abreviacion,
  tipo_cuenta,
  saldo_inicial
) FROM './practica3-bases2/CuentaHabientes1.csv' WITH HEADER = TRUE AND DELIMITER=',';
COPY cuentas (
  nombre,
  apellido,
  cui,
  institucion,
  abreviacion,
  tipo_cuenta,
  saldo_inicial
) FROM './practica3-bases2/CuentaHabientes2.csv' WITH HEADER = TRUE AND DELIMITER=',';