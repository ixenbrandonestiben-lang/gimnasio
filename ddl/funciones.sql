USE gimnasio_db;

DELIMITER //

DROP FUNCTION IF EXISTS fn_obtener_nombre_completo_socio//
CREATE FUNCTION fn_obtener_nombre_completo_socio(p_id_socio_buscado INT)
RETURNS VARCHAR(201)
READS SQL DATA
BEGIN
    DECLARE v_nombre_completo_socio VARCHAR(201);

    SELECT CONCAT(nombre_socio, ' ', apellido_socio)
    INTO v_nombre_completo_socio
    FROM socios
    WHERE id_socio = p_id_socio_buscado;

    RETURN v_nombre_completo_socio;
END//

-- Cálculo de comisión según reglas de negocio
DROP FUNCTION IF EXISTS fn_calcular_comision_entrenador//
CREATE FUNCTION fn_calcular_comision_entrenador(p_id_entrenador_buscado INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_monto_total_planes DECIMAL(10,2);
    DECLARE v_porcentaje_comision DECIMAL(5,2);

    SELECT COALESCE(SUM(p.costo_mensual_plan), 0)
    INTO v_monto_total_planes
    FROM inscripciones AS i
    INNER JOIN planes_entrenamiento AS p ON i.id_plan_seleccionado = p.id_plan
    WHERE i.id_entrenador_asignado = p_id_entrenador_buscado;

    IF v_monto_total_planes > 1000 THEN
        SET v_porcentaje_comision = 10.00;
    ELSEIF v_monto_total_planes > 500 THEN
        SET v_porcentaje_comision = 8.00;
    ELSE
        SET v_porcentaje_comision = 5.00;
    END IF;

    RETURN (v_monto_total_planes * v_porcentaje_comision / 100);
END//

-- Función no determinística basada en la fecha actual
DROP FUNCTION IF EXISTS fn_obtener_dias_desde_inscripcion//
CREATE FUNCTION fn_obtener_dias_desde_inscripcion(p_id_inscripcion_buscada INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_fecha_registro_inscripcion DATE;

    SELECT fecha_registro_inscripcion
    INTO v_fecha_registro_inscripcion
    FROM inscripciones
    WHERE id_inscripcion = p_id_inscripcion_buscada;

    RETURN DATEDIFF(NOW(), v_fecha_registro_inscripcion);
END//

DELIMITER ;