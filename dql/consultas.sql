USE gimnasio_db;

-- Consulta detallada de inscripciones completas
SELECT
    CONCAT(s.nombre_socio, ' ', s.apellido_socio) AS nombre_completo_socio,
    p.nombre_plan AS plan_seleccionado,
    CONCAT(e.nombre_entrenador, ' ', e.apellido_entrenador) AS nombre_completo_entrenador,
    se.nombre_sede AS sede_inscripcion,
    i.fecha_registro_inscripcion
FROM inscripciones AS i
INNER JOIN socios AS s ON i.id_socio_inscrito = s.id_socio
INNER JOIN planes_entrenamiento AS p ON i.id_plan_seleccionado = p.id_plan
INNER JOIN entrenadores AS e ON i.id_entrenador_asignado = e.id_entrenador
INNER JOIN sedes AS se ON i.id_sede_inscripcion = se.id_sede;

-- Filtrado de socios por tipo de plan
SELECT
    s.id_socio,
    s.nombre_socio,
    s.apellido_socio,
    p.nombre_plan
FROM socios AS s
INNER JOIN inscripciones AS i ON s.id_socio = i.id_socio_inscrito
INNER JOIN planes_entrenamiento AS p ON i.id_plan_seleccionado = p.id_plan
WHERE p.nombre_plan IN ('Plan Basico', 'Plan VIP');