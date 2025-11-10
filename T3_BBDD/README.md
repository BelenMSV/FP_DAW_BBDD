# 📙 Tarea 3: Implantación de Bases de Datos Relacionales

![Instalación MySQL y Oracle](T3_BBDD.png)

> Práctica completa de creación y modificación de una base de datos relacional para gestión de clínicas sanitarias, con SQL y MySQL.

---

## 📄 Tabla de Contenidos
- [Descripción](#descripcion)
- [Archivos incluidos](#archivos-incluidos)
- [Objetivos](#objetivos)
- [Resumen de ejercicios y estructura](#resumen)
- [Autoría](#autoria)

---

<h2 id="descripcion">📝 Descripción</h2>

Esta tarea aborda el proceso de implantación de bases de datos relacionales para una empresa de gestión de clínicas sanitarias.  

El trabajo parte de un **diagrama Entidad/Relación** y un **Modelo Relacional** ya realizados, y se centra en la escritura y ejecución de los scripts SQL necesarios para:

- Crear y configurar la estructura de la base de datos y sus tablas en **MySQL**.  
- Definir claves primarias y ajenas, restricciones y reglas de integridad referencial.  
- Modificar la BBDD y sus tablas para añadir campos, cambiar tipos de datos y generar vistas e índices.  
- Gestionar usuarios y permisos en el sistema.

El ejercicio está documentado y la corrección se incluye en el **PDF adjunto**.

---

<h2 id="archivos-incluidos">📂 Archivos incluidos</h2>

- **Solis_Valle_Belen_Maria_BD_Tarea3_Corregida.pdf** → Informe completo de la tarea con explicaciones, capturas y correcciones.  
- **Solis_Valle_Belen_Maria_BD_Tarea3.sql** → Script SQL con todos los ejercicios y sentencias para ejecutar y probar la base de datos.

---

<h2 id="objetivos">🎯 Objetivos</h2>

- Aprender a implementar una base de datos usando **MySQL** y sentencias **DDL / DCL / DML**.  
- Aplicar reglas de integridad referencial, restricciones y tipos de datos adecuados.  
- Modificar y mantener la estructura de una BBDD (tablas, vistas, índices).  
- Crear y gestionar usuarios y permisos en MySQL para garantizar la seguridad y el control de acceso.

---

<h2 id="resumen">📋 Resumen de ejercicios y estructura</h2>

| Ejercicio | Acción principal |
|------------|------------------|
| **Script inicial** | `DROP DATABASE`, `CREATE DATABASE`, `USE` |
| **Crear tablas** | Sentencias `CREATE TABLE` con claves y restricciones |
| **Modificar tablas** | `ALTER TABLE`: añadir columna (`email`), cambiar nombre (`nhistorialclinico`), crear índice |
| **Crear vista** | `CREATE VIEW CLINICASPRIVADAS` para mostrar clínicas privadas |
| **Gestionar usuarios** | `CREATE USER`, `GRANT SELECT ON PACIENTE` |

---

<h2 id="autoria">👩‍💻 Autoría</h2>

**Belén María Solís Valle**  
DAW – Curso 2023/2024
