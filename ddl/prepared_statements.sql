USE gimnasio_db;

-- Consulta dinámica parametrizada por nombre de socio
SET @nombre_socio_buscado = 'Juan';

SET @consulta_busqueda_socios = '
    SELECT id_socio, nombre_socio, apellido_socio, numero_telefono_socio
    FROM socios
    WHERE nombre_socio LIKE ?
';

PREPARE consulta_socios FROM @consulta_busqueda_socios;

SET @nombre_socio_completo_buscado = CONCAT('%', @nombre_socio_buscado, '%');

EXECUTE consulta_socios USING @nombre_socio_completo_buscado;

DEALLOCATE PREPARE consulta_socios;