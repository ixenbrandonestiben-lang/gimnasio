USE gimnasio_db;

-- Referencia conceptual: Particionamiento por Rango de Año
/*
CREATE TABLE inscripciones_particionadas (
    id_inscripcion INT NOT NULL,
    id_socio_inscrito INT NOT NULL,
    id_plan_seleccionado INT NOT NULL,
    id_entrenador_asignado INT NOT NULL,
    id_sede_inscripcion INT NOT NULL,
    fecha_registro_inscripcion DATE NOT NULL,
    PRIMARY KEY (id_inscripcion, fecha_registro_inscripcion)
)
PARTITION BY RANGE (YEAR(fecha_registro_inscripcion)) (
    PARTITION inscripciones_2025 VALUES LESS THAN (2026),
    PARTITION inscripciones_2026 VALUES LESS THAN (2027),
    PARTITION inscripciones_futuras VALUES LESS THAN MAXVALUE
);
*/

-- Referencia conceptual: Particionamiento por Hash de Sede
/*
CREATE TABLE inscripciones_por_sede (
    id_inscripcion INT NOT NULL,
    id_socio_inscrito INT NOT NULL,
    id_plan_seleccionado INT NOT NULL,
    id_entrenador_asignado INT NOT NULL,
    id_sede_inscripcion INT NOT NULL,
    fecha_registro_inscripcion DATE NOT NULL,
    PRIMARY KEY (id_inscripcion, id_sede_inscripcion)
)
PARTITION BY HASH (id_sede_inscripcion)
PARTITIONS 3;
*/