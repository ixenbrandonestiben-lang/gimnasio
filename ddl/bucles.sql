USE gimnasio_db;

DELIMITER //

DROP FUNCTION IF EXISTS fn_sumar_numeros_hasta//
CREATE FUNCTION fn_sumar_numeros_hasta(p_numero_limite INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_numero_actual INT DEFAULT 1;
    DECLARE v_suma_total INT DEFAULT 0;

    WHILE v_numero_actual <= p_numero_limite DO
        SET v_suma_total = v_suma_total + v_numero_actual;
        SET v_numero_actual = v_numero_actual + 1;
    END WHILE;

    RETURN v_suma_total;
END//

DELIMITER ;