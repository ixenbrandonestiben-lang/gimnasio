# Evidencias del Proyecto — gimnasio_db

Este documento contiene las pruebas principales realizadas para verificar el funcionamiento de la base de datos `gimnasio_db`.

Las capturas de cada prueba se encuentran almacenadas en la carpeta:

```text
/evidencias/img
```

---

## 1. Creación de la base de datos

```sql
DROP DATABASE IF EXISTS gimnasio_db;
CREATE DATABASE gimnasio_db;
USE gimnasio_db;
```


---

## 2. Creación de las tablas

```sql
SHOW TABLES;
```


---

## 3. Verificación de los datos

```sql
SELECT * FROM ciudades;
SELECT * FROM sedes;
SELECT * FROM especialidades;
SELECT * FROM entrenadores;
SELECT * FROM planes_entrenamiento;
SELECT * FROM socios;
SELECT * FROM inscripciones;
```

---

## 4. Consulta con INNER JOIN

```sql
SELECT
    CONCAT(s.nombre_socio, ' ', s.apellido_socio) AS socio,
    p.nombre_plan AS plan,
    CONCAT(e.nombre_entrenador, ' ', e.apellido_entrenador) AS entrenador,
    se.nombre_sede AS sede
FROM inscripciones i
INNER JOIN socios s
    ON i.id_socio_inscrito = s.id_socio
INNER JOIN planes_entrenamiento p
    ON i.id_plan_seleccionado = p.id_plan
INNER JOIN entrenadores e
    ON i.id_entrenador_asignado = e.id_entrenador
INNER JOIN sedes se
    ON i.id_sede_inscripcion = se.id_sede;
```

---

## 5. Consulta con IN

```sql
SELECT
    s.nombre_socio,
    s.apellido_socio,
    p.nombre_plan
FROM socios s
INNER JOIN inscripciones i
    ON s.id_socio = i.id_socio_inscrito
INNER JOIN planes_entrenamiento p
    ON i.id_plan_seleccionado = p.id_plan
WHERE p.nombre_plan IN ('Plan Basico', 'Plan VIP');
```
---

## 8. Triggers y eventos

```sql
SHOW TRIGGERS;

SHOW EVENTS;
```

---

## 9. Diagrama de la base de datos

El diagrama de relaciones fue generado utilizando MySQL Workbench.

---

Estas evidencias permiten comprobar de forma sencilla la creación, funcionamiento y estructura de la base de datos `gimnasio_db`.
