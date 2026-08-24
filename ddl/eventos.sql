use gimnasio_db;

-- Programación del reporte diario de socios
DROP EVENT IF EXISTS evento_contar_socios_por_entrenador;

delimiter //

CREATE EVENT evento_contar_socios_por_entrenador
ON SCHEDULE EVERY 1 DAY
STARTS '2026-08-15 23:59:00'
DO
BEGIN
    INSERT INTO resumen_socios_entrenadores (id_entrenador, cantidad_socios_asignados, fecha_resumen)
    SELECT
        e.id_entrenador,
        COUNT(i.id_socio_inscrito),
        CURDATE()
    FROM entrenadores AS e
    LEFT JOIN inscripciones AS i ON e.id_entrenador = i.id_entrenador_asignado
    GROUP BY e.id_entrenador
    ON DUPLICATE KEY UPDATE
        cantidad_socios_asignados = VALUES(cantidad_socios_asignados);
        
END //

delimiter ;


show variables like 'event_scheduler';
