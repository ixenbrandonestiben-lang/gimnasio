# 📋 Requerimientos Técnicos del Proyecto

## 1. Introducción

Este documento describe los requerimientos técnicos implementados en la base de datos `gimnasio_db`.

El objetivo es documentar de manera sencilla qué objetos fueron creados, qué problema resuelven y cómo forman parte de la lógica del sistema.

---

# 2. Consultas SQL

## 2.1 INNER JOIN

Se creó una consulta utilizando `INNER JOIN` para obtener información relacionada de diferentes tablas.

La consulta permite mostrar:

* Nombre del socio.
* Plan seleccionado.
* Entrenador asignado.
* Sede de inscripción.
* Fecha de inscripción.

### Tablas utilizadas

```text
socios
inscripciones
planes_entrenamiento
entrenadores
sedes
```

### Objetivo

Demostrar cómo obtener información relacionada almacenada en diferentes tablas.

---

## 2.2 Operador IN

Se implementó una consulta utilizando:

```sql
IN
```

Permite buscar socios inscritos en determinados planes.

Por ejemplo:

```text
Plan Basico
Plan VIP
```

### Objetivo

Evitar escribir múltiples condiciones `OR` cuando se desean comparar varios valores.

---

# 3. Funciones almacenadas

## 3.1 `fn_obtener_nombre_completo_socio`

### Función

Recibe:

```text
p_id_socio_buscado
```

Devuelve:

```text
nombre + apellido
```

### Ejemplo

```sql
SELECT fn_obtener_nombre_completo_socio(1);
```

### Objetivo

Facilitar la obtención del nombre completo de un socio utilizando solamente su ID.

---

## 3.2 `fn_calcular_comision_entrenador`

### Función

Recibe:

```text
p_id_entrenador_buscado
```

Calcula una comisión basada en el costo mensual de los planes asociados al entrenador.

La lógica utiliza diferentes porcentajes dependiendo del monto acumulado.

### Reglas utilizadas

| Monto acumulado | Comisión |
| --------------: | -------: |
|      Hasta Q500 |       5% |
|     Más de Q500 |       8% |
|    Más de Q1000 |      10% |

### Objetivo

Demostrar el uso de:

* Variables locales.
* `SUM()`.
* `IF`.
* `ELSEIF`.
* Operaciones matemáticas.

---

## 3.3 `fn_sumar_numeros_hasta`

Esta función fue creada para demostrar el uso de un ciclo `WHILE`.

Recibe un número y suma todos los números desde `1` hasta ese límite.

### Ejemplo

```sql
SELECT fn_sumar_numeros_hasta(5);
```

Resultado esperado:

```text
15
```

### Objetivo

Demostrar el funcionamiento de ciclos dentro de una función MySQL.

---

## 3.4 `fn_obtener_dias_desde_inscripcion`

Esta función calcula la cantidad de días transcurridos desde la fecha de inscripción hasta el momento actual.

Utiliza:

```sql
NOW()
```

y:

```sql
DATEDIFF()
```

### Ejemplo

```sql
SELECT fn_obtener_dias_desde_inscripcion(1);
```

### Característica

La función es:

```text
NOT DETERMINISTIC
```

porque su resultado puede cambiar con el paso del tiempo.

---

# 4. Procedimiento almacenado

## `sp_registrar_nueva_inscripcion`

Se creó un procedimiento para registrar una nueva inscripción.

### Parámetros de entrada

```text
p_id_socio_buscado
p_id_plan_buscado
p_id_entrenador_buscado
p_id_sede_buscada
p_fecha_registro_buscada
```

### Parámetro de salida

```text
p_mensaje_resultado
```

### Manejo de errores

Se utiliza:

```sql
DECLARE ... HANDLER FOR SQLEXCEPTION
```

para detectar errores durante la inserción.

### Objetivo

Centralizar el proceso de registro de una inscripción.

En lugar de ejecutar directamente un `INSERT`, se puede utilizar:

```sql
CALL sp_registrar_nueva_inscripcion(...);
```

---

# 5. Trigger

## `before_inscripcion_insert`

Este trigger se ejecuta antes de insertar una nueva inscripción.

### Validaciones

Comprueba que:

1. El socio exista.
2. El entrenador exista.

Si alguno no existe, se utiliza:

```sql
SIGNAL SQLSTATE '45000'
```

para detener la operación y mostrar un mensaje.

### Objetivo

Agregar una validación adicional antes de registrar una inscripción.

---

# 6. Evento

## `evento_contar_socios_por_entrenador`

Se creó un evento programado para ejecutarse diariamente.

El evento:

1. Consulta los entrenadores.
2. Cuenta los socios asignados.
3. Guarda el resultado.
4. Registra la fecha del resumen.

La información se almacena en:

```text
resumen_socios_entrenadores
```

### Objetivo

Automatizar la generación de un resumen diario.

---

# 7. Prepared Statement

Se implementó una consulta SQL dinámica utilizando:

```sql
PREPARE
EXECUTE
DEALLOCATE PREPARE
```

La consulta permite buscar socios utilizando un nombre proporcionado dinámicamente.

### Flujo

```text
Variable
   ↓
PREPARE
   ↓
EXECUTE
   ↓
Resultado
   ↓
DEALLOCATE
```

### Objetivo

Demostrar el uso básico de SQL dinámico en MySQL.

---

# 8. Particionamiento

Se incluyeron ejemplos conceptuales de particionamiento.

## Particionamiento por año

La tabla podría dividirse según el año de la fecha de inscripción.

Por ejemplo:

```text
inscripciones_2025
inscripciones_2026
inscripciones_futuras
```

## Particionamiento por sede

También se puede analizar una distribución utilizando:

```sql
HASH(id_sede_inscripcion)
```

### Importante

Los ejemplos de particionamiento no se ejecutan directamente sobre la tabla actual.

Esto se debe a restricciones de MySQL relacionadas con tablas particionadas y claves foráneas.

Por esta razón, el particionamiento queda documentado como una posible mejora arquitectónica futura.

---

# 9. DCL — Usuarios y permisos

Se crearon dos usuarios:

```text
admin_gym
operador_gym
```

---

## 9.1 Usuario administrador

```text
admin_gym
```

Tiene permisos completos sobre:

```text
gimnasio_db
```

Se utiliza:

```sql
GRANT ALL PRIVILEGES
```

### Objetivo

Permitir la administración completa de la base de datos.

---

## 9.2 Usuario operador

```text
operador_gym
```

Tiene permisos para:

```text
SELECT
INSERT
UPDATE
```

No se le asignan permisos administrativos completos.

### Objetivo

Aplicar el principio de mínimo privilegio.

---

# 10. Permiso a nivel de columna

Se agregó un permiso específico para consultar:

```text
numero_telefono_socio
```

de la tabla:

```text
socios
```

Ejemplo:

```sql
GRANT SELECT (numero_telefono_socio)
ON gimnasio_db.socios
TO 'operador_gym'@'localhost';
```

### Objetivo

Demostrar que MySQL permite asignar permisos específicos sobre determinadas columnas.

---

# 11. Resumen de objetos creados

| Tipo           | Nombre                                | Función                    |
| -------------- | ------------------------------------- | -------------------------- |
| Función        | `fn_obtener_nombre_completo_socio`    | Obtiene nombre completo    |
| Función        | `fn_calcular_comision_entrenador`     | Calcula comisión           |
| Función        | `fn_sumar_numeros_hasta`              | Demuestra `WHILE`          |
| Función        | `fn_obtener_dias_desde_inscripcion`   | Calcula días transcurridos |
| Procedure      | `sp_registrar_nueva_inscripcion`      | Registra inscripciones     |
| Trigger        | `before_inscripcion_insert`           | Valida socio y entrenador  |
| Event          | `evento_contar_socios_por_entrenador` | Genera resumen diario      |
| Tabla auxiliar | `resumen_socios_entrenadores`         | Guarda resultados diarios  |
| DCL            | `admin_gym`                           | Usuario administrador      |
| DCL            | `operador_gym`                        | Usuario operador           |

---

# 12. Conceptos SQL aplicados

El proyecto permite demostrar conocimientos básicos e intermedios de MySQL:

* `CREATE DATABASE`
* `CREATE TABLE`
* `PRIMARY KEY`
* `FOREIGN KEY`
* `INSERT`
* `SELECT`
* `INNER JOIN`
* `IN`
* `CONCAT`
* `SUM`
* `IF`
* `WHILE`
* `NOW`
* `DATEDIFF`
* `CREATE FUNCTION`
* `CREATE PROCEDURE`
* `CREATE TRIGGER`
* `CREATE EVENT`
* `SIGNAL`
* `PREPARE`
* `EXECUTE`
* `DEALLOCATE PREPARE`
* `GRANT`
* `SHOW GRANTS`
* Particionamiento

---

# 13. Conclusión

Los requerimientos fueron implementados utilizando soluciones sencillas y fáciles de entender.

El proyecto mantiene una estructura apropiada para un nivel Junior y permite agregar posteriormente funcionalidades más avanzadas sin necesidad de cambiar completamente la arquitectura inicial.
