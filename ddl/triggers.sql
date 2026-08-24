use gimnasio_db;

DROP TRIGGER IF EXISTS before_inscripcion_insert;

DELIMITER //

-- Validación previa a la inserción

CREATE TRIGGER before_inscripcion_insert
BEFORE INSERT ON inscripciones
FOR EACH ROW
BEGIN
    DECLARE v_socio_existe INT DEFAULT 0;
    DECLARE v_entrenador_existe INT DEFAULT 0;

    SELECT COUNT(*) 
		INTO v_socio_existe 
        FROM socios 
        WHERE id_socio = NEW.id_socio_inscrito;
    
    IF v_socio_existe = 0 THEN
        SIGNAL SQLSTATE '45000' 	
        SET MESSAGE_TEXT = 'Error: el socio indicado no existe.';
    END IF;

    SELECT COUNT(*) 
    INTO v_entrenador_existe 
    FROM entrenadores 
    WHERE id_entrenador = NEW.id_entrenador_asignado;
    
    IF v_entrenador_existe = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: el entrenador indicado no existe.';
    END IF;
END//

DELIMITER ;



-- *************************************
-- pruevas y consultas.

DESCRIBE inscripciones;

INSERT INTO inscripciones (id_socio_inscrito, id_plan_seleccionado, id_entrenador_asignado, id_sede_inscripcion, fecha_registro_inscripcion) 
VALUES (10, 1, 2,1, '2026-08-24');

select * FROM inscripciones
order by id_inscripcion desc;
    
select s.nombre_socio
from socios s
where id_socio = 50;