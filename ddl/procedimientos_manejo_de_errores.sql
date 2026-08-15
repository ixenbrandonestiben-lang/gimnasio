USE gimnasio_db;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_registrar_nueva_inscripcion//
CREATE PROCEDURE sp_registrar_nueva_inscripcion(
    IN p_id_socio INT,
    IN p_id_plan INT,
    IN p_id_entrenador INT,
    IN p_id_sede INT,
    IN p_fecha_registro DATE,
    OUT p_mensaje_resultado VARCHAR(255)
)
BEGIN
    DECLARE v_error_ocurrido BOOLEAN DEFAULT FALSE;

    -- Manejador de excepciones SQL
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET v_error_ocurrido = TRUE;
    END;

    INSERT INTO inscripciones (
        id_socio_inscrito,
        id_plan_seleccionado,
        id_entrenador_asignado,
        id_sede_inscripcion,
        fecha_registro_inscripcion
    )
    VALUES (p_id_socio, p_id_plan, p_id_entrenador, p_id_sede, p_fecha_registro);

    IF v_error_ocurrido THEN
        SET p_mensaje_resultado = 'Error: no fue posible registrar la inscripcion.';
    ELSE
        SET p_mensaje_resultado = 'Inscripcion registrada correctamente.';
    END IF;
END//

DELIMITER ;