# 🏋️ Sistema de Gestión de Gimnasio

## 1. Descripción general

Este proyecto consiste en el desarrollo de una base de datos relacional para administrar la información básica de un gimnasio.

La base de datos permite almacenar y relacionar información sobre:

* Ciudades.
* Sedes del gimnasio.
* Especialidades de entrenamiento.
* Entrenadores.
* Planes de entrenamiento.
* Socios.
* Inscripciones.

El proyecto fue desarrollado utilizando **MySQL** y está organizado en diferentes etapas para facilitar su desarrollo, ejecución, pruebas y mantenimiento.

---

## 2. Nombre de la base de datos

```sql
gimnasio_db
```

La base de datos fue diseñada utilizando relaciones entre tablas mediante **PRIMARY KEY** y **FOREIGN KEY**.

---

## 3. Objetivo principal

El objetivo principal es crear una estructura de base de datos sencilla que permita al gimnasio administrar correctamente sus principales procesos de información.

La base de datos permite:

* Registrar ciudades.
* Registrar las sedes del gimnasio.
* Registrar especialidades.
* Registrar entrenadores.
* Registrar planes de entrenamiento.
* Registrar socios.
* Registrar las inscripciones de los socios.
* Consultar información relacionada mediante `JOIN`.
* Calcular información mediante funciones.
* Automatizar determinadas operaciones mediante procedimientos, triggers y eventos.
* Administrar usuarios y permisos mediante DCL.

---

## 4. Arquitectura básica

La base de datos está formada por las siguientes tablas:

```text
ciudades
    │
    └── sedes
           │
           └── inscripciones
                    │
                    ├── socios
                    │
                    ├── planes_entrenamiento
                    │
                    └── entrenadores
                              │
                              └── especialidades
```

### Principales relaciones

| Tabla                  | Relación                                           |
| ---------------------- | -------------------------------------------------- |
| `ciudades`             | Tiene una relación con `sedes`                     |
| `sedes`                | Puede tener muchas `inscripciones`                 |
| `especialidades`       | Puede tener muchos `entrenadores`                  |
| `entrenadores`         | Puede estar relacionado con muchas `inscripciones` |
| `planes_entrenamiento` | Puede ser seleccionado en muchas `inscripciones`   |
| `socios`               | Puede tener muchas `inscripciones`                 |
| `inscripciones`        | Relaciona socios, planes, entrenadores y sedes     |

---

---

## 6. Orden de ejecución

Los scripts deben ejecutarse en el siguiente orden.

### Etapa 1 — Creación de la base de datos

Archivo:

```text
tablas.sql
```

Este archivo:

* Elimina la base de datos anterior si existe.
* Crea `gimnasio_db`.
* Crea las tablas.
* Define las claves primarias.
* Define las claves foráneas.

Debe ejecutarse primero porque los demás scripts dependen de las tablas creadas.

---

### Etapa 2 — Inserción de datos

Archivo:

```text
inserciones.sql
```

Este archivo agrega los datos ficticios utilizados para realizar las pruebas.

Incluye:

* 3 ciudades.
* 3 sedes.
* 4 especialidades.
* 4 entrenadores.
* 3 planes.
* 6 socios.
* 6 inscripciones.

Debe ejecutarse después de la Etapa 1.

---

### Etapa 3 — Requerimientos de negocio

Archivo:

```text
dql/consultas.sql
```

Este archivo contiene:

* Consultas.


Debe ejecutarse después de haber creado las tablas y cargado los datos de prueba.

---

## 7. Tecnologías utilizadas

| Tecnología      | Uso                                 |
| --------------- | ----------------------------------- |
| MySQL           | Sistema gestor de base de datos     |
| MySQL Workbench | Desarrollo y ejecución de consultas |
| SQL             | Creación y manipulación de datos    |
| Markdown        | Documentación del proyecto          |

---

## 8. Road Map de mejoras futuras

El proyecto actualmente tiene una estructura funcional y sencilla. A futuro se pueden implementar diferentes mejoras.

### Fase 1 — Validaciones

* Agregar más restricciones `CHECK`.
* Validar números telefónicos.
* Validar costos de planes.
* Evitar inscripciones duplicadas.
* Agregar estados para socios e inscripciones.

### Fase 2 — Seguridad

* Mejorar las políticas de contraseñas.
* Crear diferentes roles.
* Aplicar el principio de mínimo privilegio.
* Separar usuarios administrativos y operativos.

### Fase 3 — Automatización

* Crear procedimientos para procesos frecuentes.
* Crear triggers adicionales cuando sean realmente necesarios.
* Mejorar los eventos programados.
* Crear tablas de auditoría.

### Fase 4 — Optimización

* Analizar consultas con `EXPLAIN`.
* Crear índices cuando sean necesarios.
* Optimizar consultas con muchos `JOIN`.
* Revisar el rendimiento de las tablas.

### Fase 5 — Escalabilidad

* Analizar el uso de particionamiento.
* Diseñar estrategias para grandes cantidades de inscripciones.
* Crear reportes estadísticos.
* Integrar la base de datos con una aplicación.

---

## 9. Estado actual del proyecto

El proyecto cuenta con una estructura inicial funcional para administrar la información principal de un gimnasio.

La arquitectura está diseñada para ser sencilla, entendible y fácil de ampliar.

---

## 10. Conclusión

La base de datos `gimnasio_db` representa una primera versión de un sistema de gestión para un gimnasio.

El proyecto aplica conceptos fundamentales de bases de datos relacionales:

* Modelado de datos.
* Claves primarias.
* Claves foráneas.
* Relaciones entre tablas.
* Consultas SQL.
* Funciones.
* Procedimientos almacenados.
* Triggers.
* Eventos.
* SQL dinámico.
* DCL.
* Particionamiento.

El diseño puede evolucionar posteriormente hacia un sistema más completo conectado a una aplicación web, móvil o de escritorio.
