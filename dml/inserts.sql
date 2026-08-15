USE gimnasio_db;

INSERT INTO ciudades (nombre_ciudad) VALUES
    ('Guatemala'),
    ('Quetzaltenango'),
    ('Escuintla');

INSERT INTO sedes (nombre_sede, id_ciudad_pertenece) VALUES
    ('Sede Zona 10', 1),
    ('Sede Centro Xela', 2),
    ('Sede Centro Escuintla', 3);

INSERT INTO especialidades (nombre_especialidad) VALUES
    ('Musculacion'),
    ('Crossfit'),
    ('Yoga'),
    ('Cardio');

INSERT INTO entrenadores (nombre_entrenador, apellido_entrenador, id_especialidad_entrenador) VALUES
    ('Carlos', 'Mendez', 1),
    ('Andrea', 'Lopez', 2),
    ('Miguel', 'Hernandez', 3),
    ('Sofia', 'Ramirez', 4);

INSERT INTO planes_entrenamiento (nombre_plan, costo_mensual_plan) VALUES
    ('Plan Basico', 200.00),
    ('Plan Medio', 300.00),
    ('Plan VIP', 450.00);

INSERT INTO socios (nombre_socio, apellido_socio, numero_telefono_socio) VALUES
    ('Juan', 'Perez', '5551-1001'),
    ('Maria', 'Gonzalez', '5551-1002'),
    ('Luis', 'Martinez', '5551-1003'),
    ('Daniela', 'Castillo', '5551-1004'),
    ('Pedro', 'Morales', '5551-1005'),
    ('Valeria', 'Ramirez', '5551-1006');

INSERT INTO inscripciones (id_socio_inscrito, id_plan_seleccionado, id_entrenador_asignado, id_sede_inscripcion, fecha_registro_inscripcion) VALUES
    (1, 1, 1, 1, '2026-08-01'),
    (2, 2, 2, 1, '2026-08-02'),
    (3, 3, 3, 2, '2026-08-03'),
    (4, 1, 4, 3, '2026-08-04'),
    (5, 2, 1, 2, '2026-08-05'),
    (6, 3, 2, 3, '2026-08-06');