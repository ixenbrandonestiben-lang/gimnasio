DROP DATABASE IF EXISTS gimnasio_db;
CREATE DATABASE gimnasio_db;
USE gimnasio_db;

CREATE TABLE ciudades (
    id_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL
);

CREATE TABLE sedes (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    id_ciudad_pertenece INT NOT NULL,
    FOREIGN KEY (id_ciudad_pertenece) REFERENCES ciudades(id_ciudad)
);

CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_especialidad VARCHAR(100) NOT NULL
);

CREATE TABLE entrenadores (
    id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
    nombre_entrenador VARCHAR(100) NOT NULL,
    apellido_entrenador VARCHAR(100) NOT NULL,
    id_especialidad_entrenador INT NOT NULL,
    FOREIGN KEY (id_especialidad_entrenador) REFERENCES especialidades(id_especialidad)
);

CREATE TABLE planes_entrenamiento (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plan VARCHAR(100) NOT NULL,
    costo_mensual_plan DECIMAL(10,2) NOT NULL
);

CREATE TABLE socios (
    id_socio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_socio VARCHAR(100) NOT NULL,
    apellido_socio VARCHAR(100) NOT NULL,
    numero_telefono_socio VARCHAR(20) NOT NULL
);

CREATE TABLE inscripciones (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_socio_inscrito INT NOT NULL,
    id_plan_seleccionado INT NOT NULL,
    id_entrenador_asignado INT NOT NULL,
    id_sede_inscripcion INT NOT NULL,
    fecha_registro_inscripcion DATE NOT NULL,
    FOREIGN KEY (id_socio_inscrito) REFERENCES socios(id_socio),
    FOREIGN KEY (id_plan_seleccionado) REFERENCES planes_entrenamiento(id_plan),
    FOREIGN KEY (id_entrenador_asignado) REFERENCES entrenadores(id_entrenador),
    FOREIGN KEY (id_sede_inscripcion) REFERENCES sedes(id_sede)
);

CREATE TABLE resumen_socios_entrenadores (
    id_resumen INT AUTO_INCREMENT PRIMARY KEY,
    id_entrenador INT NOT NULL,
    cantidad_socios_asignados INT NOT NULL,
    fecha_resumen DATE NOT NULL,
    UNIQUE KEY uq_resumen_entrenador_fecha (id_entrenador, fecha_resumen),
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores(id_entrenador)
);