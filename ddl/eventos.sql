use gimnasio_db;

-- Programación del reporte diario de socios
DROP EVENT IF EXISTS evento_contar_socios_por_entrenador;
create event evento_contar_socios_por_entrenador
on schedule every 1 day 
starts '2026-08-24 23:59:00'
do
	insert into resumen_socios_entrenadores (id_entrenador, cantidad_socios_asignados, fecha_resumen)
    select 
		e.id_entrenador,
        count(i.id_socio_incrito),
        curdate()
	from entrendares e
    inner join incripciones i on e.id_entrenador = i.id_entrenador_asignado
    group by e.id_entrenador;

show variables like 'event_scheduler';
