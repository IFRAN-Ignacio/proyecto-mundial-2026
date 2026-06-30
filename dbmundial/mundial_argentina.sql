DROP DATABASE IF EXISTS mundial_argentina;

CREATE DATABASE mundial_argentina
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE mundial_argentina;

CREATE TABLE paises_anfi (
  id INT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  UNIQUE KEY uk_paises_anfi_nombre (nombre)
) ENGINE=InnoDB;

CREATE TABLE ciudad (
  id INT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  pais_id INT NOT NULL,
  UNIQUE KEY uk_ciudad_nombre_pais (nombre, pais_id),
  CONSTRAINT fk_ciudad_paises_anfi
    FOREIGN KEY (pais_id) REFERENCES paises_anfi(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE estadio (
  id INT PRIMARY KEY,
  capacidad INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  ciudad_id INT NOT NULL,
  latitud DECIMAL(10,6) NULL,
  longitud DECIMAL(10,6) NULL,
  UNIQUE KEY uk_estadio_nombre_ciudad (nombre, ciudad_id),
  CONSTRAINT fk_estadio_ciudad
    FOREIGN KEY (ciudad_id) REFERENCES ciudad(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE partidos (
  id INT PRIMARY KEY,
  rival VARCHAR(80) NOT NULL,
  amonestaciones INT NOT NULL DEFAULT 0,
  goles_arg INT NOT NULL DEFAULT 0,
  goles_rival INT NOT NULL DEFAULT 0,
  estadio_id INT NULL,
  CONSTRAINT fk_partidos_estadio
    FOREIGN KEY (estadio_id) REFERENCES estadio(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO paises_anfi (id, nombre) VALUES
  (1, 'Canada'),
  (2, 'Mexico'),
  (3, 'Estados Unidos');

INSERT INTO ciudad (id, nombre, pais_id) VALUES
  (1, 'Toronto', 1),
  (2, 'Vancouver', 1),
  (3, 'Ciudad de Mexico', 2),
  (4, 'Guadalajara', 2),
  (5, 'Monterrey', 2),
  (6, 'Atlanta', 3),
  (7, 'Boston', 3),
  (8, 'Dallas', 3),
  (9, 'Houston', 3),
  (10, 'Kansas City', 3),
  (11, 'Los Angeles', 3),
  (12, 'Miami', 3),
  (13, 'Nueva Jersey', 3),
  (14, 'Filadelfia', 3),
  (15, 'San Francisco', 3),
  (16, 'Seattle', 3);

INSERT INTO estadio (id, capacidad, nombre, ciudad_id, latitud, longitud) VALUES
  (1, 45736, 'BMO Field', 1, 43.633300, -79.418600),
  (2, 54500, 'BC Place', 2, 49.277800, -123.111900),
  (3, 87523, 'Estadio Azteca', 3, 19.302900, -99.150500),
  (4, 49850, 'Estadio Akron', 4, 20.681100, -103.462600),
  (5, 53500, 'Estadio BBVA', 5, 25.669800, -100.244700),
  (6, 68239, 'Mercedes-Benz Stadium', 6, 33.755400, -84.400800),
  (7, 64146, 'Gillette Stadium', 7, 42.090900, -71.264300),
  (8, 70649, 'AT&T Stadium', 8, 32.747300, -97.094500),
  (9, 68777, 'NRG Stadium', 9, 29.684700, -95.410700),
  (10, 69045, 'Arrowhead Stadium', 10, 39.048900, -94.483900),
  (11, 70492, 'SoFi Stadium', 11, 33.953500, -118.339200),
  (12, 64478, 'Hard Rock Stadium', 12, 25.958000, -80.238900),
  (13, 80663, 'MetLife Stadium', 13, 40.813500, -74.074500),
  (14, 68324, 'Lincoln Financial Field', 14, 39.900800, -75.167500),
  (15, 68827, 'Levi''s Stadium', 15, 37.403000, -121.970000),
  (16, 66925, 'Lumen Field', 16, 47.595200, -122.331600);

INSERT INTO partidos (
  id,
  rival,
  amonestaciones,
  goles_arg,
  goles_rival,
  estadio_id
) VALUES
  (0, 'Irak', 2, 3, 0, NULL);

DROP USER IF EXISTS 'mundial_read'@'localhost';
DROP USER IF EXISTS 'mundial_admin'@'localhost';

CREATE USER 'mundial_read'@'localhost'
  IDENTIFIED BY 'Mvnd1al2026!Lectura#74';

CREATE USER 'mundial_admin'@'localhost'
  IDENTIFIED BY 'Mvnd1al2026!Admin#91';

GRANT SELECT
  ON mundial_argentina.*
  TO 'mundial_read'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
  ON mundial_argentina.*
  TO 'mundial_admin'@'localhost';

FLUSH PRIVILEGES;
