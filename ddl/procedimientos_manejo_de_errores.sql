USE gimnasio_db;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_registrar_nueva_inscripcion//
CREATE PROCEDURE sp_registrar_nueva_inscripcion(
    IN p_id_socio_buscado INT,
    IN p_id_plan_buscado INT,
    IN p_id_entrenador_buscado INT,
    IN p_id_sede_buscada INT,
    IN p_fecha_registro_buscada DATE,
    OUT p_mensaje_resultado VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_mensaje_resultado = 'Error: no fue posible registrar la inscripcion.';
    END;

    INSERT INTO inscripciones (
        id_socio_inscrito,
        id_plan_seleccionado,
        id_entrenador_asignado,
        id_sede_inscripcion,
        fecha_registro_inscripcion
    )
    VALUES (p_id_socio_buscado, p_id_plan_buscado, p_id_entrenador_buscado, p_id_sede_buscada, p_fecha_registro_buscada);

    SET p_mensaje_resultado = 'Inscripcion registrada correctamente.';
END//

DELIMITER ;