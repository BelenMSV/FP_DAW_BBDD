# 📕 Tarea 6: Programación de Bases de Datos

![Programación de Bases de Datos](T6_BBDD.png)

> Implementación de procedimientos almacenados, funciones y triggers en Oracle PL/SQL sobre la base de datos de la ONG “Cesta Solidaria”.

## 📄 Tabla de Contenidos

- [Descripción](#descripcion)
- [Archivos incluidos](#archivos-incluidos)
- [Instrucciones de uso](#instrucciones-de-uso)
- [Resumen de ejercicios](#resumen-de-ejercicios)
- [Autoría](#autoria)

---

## <h2 id="descripcion">📝 Descripción</h2>

La tarea 6 se centra en la **programación de bases de datos** usando subprogramas del SGBD Oracle.  
Con la base de datos "Cesta Solidaria" como contexto, el objetivo es automatizar y extender sus capacidades mediante la creación de **procedimientos, funciones y triggers** para diversas tareas propuestas en el PDF.
Incluye el script para la creación y carga de tablas de la base de datos, necesario para ejecutar el resto de scripts de la tarea.

---

## <h2 id="archivos-incluidos">📂 Archivos incluidos</h2>

- `SCRIPT_Tarea6_CESTA_2324.sql`: Script para la creación de la base de datos y todas las tablas necesarias, así como la inserción de los datos de partida. - El **Script de creación de tablas:** Define la estructura y los datos iniciales requeridos para realizar los ejercicios.
- `Solis_Valle_Belen_Maria_BD_Tarea6.pdf`: Documento completo con enunciado, desarrollo, ejemplos y correcciones.
- `Solis_Valle_Belen_Maria_BBDD_T6.1_TAREA_PROCEDIMIENTO_A.sql`: Script para el procedimiento que muestra detalles completos de una cesta y sus productos.
- `Solis_Valle_Belen_Maria_BBDD_T6.3_TAREA_PROCEDIMIENTO_B.sql`: Script para el procedimiento que actualiza el tipo de ayuda asignada a un socio.
- `Solis_Valle_Belen_Maria_BBDD_T6.2_TAREA_FUNCION_C.sql`: Script para una función que devuelve la cantidad total de un producto repartido en todas las cestas.
- `Solis_Valle_Belen_Maria_BBDD_T6.4_TAREA_TRIGGER_D.sql`: Script de trigger que actualiza puntos de voluntarios al preparar una cesta.
- `T6_BBDD.jpg`: Imagen ilustrativa de la tarea y el tema.

---

## <h2 id="instrucciones-de-uso">🛠 Instrucciones de uso</h2>

1. Ejecuta **SCRIPT_Tarea6_CESTA_2324.sql** en Oracle para crear y poblar la base de datos.
2. Importa y ejecuta cada uno de los scripts de procedimientos, funciones y triggers, siguiendo el orden recomendado en el PDF si es necesario.
3. Comprueba el funcionamiento realizando pruebas sobre las tablas, y observa los efectos sobre los datos y registros afectados por cada subprograma.
4. Usa el PDF para consultar resultados esperados y ejemplos corregidos.

---

## <h2 id="resumen-de-ejercicios">📋 Resumen de ejercicios</h2>

- **Procedimiento A:** Muestra información detallada de una cesta, su voluntario preparador y los productos incluidos.
- **Procedimiento B:** Actualiza el tipo de ayuda de un socio en base a su renta y familiares a cargo.
- **Función C:** Devuelve la cantidad total de un producto en todas las cestas.
- **Trigger D:** Suma automáticamente puntos a un voluntario al preparar una cesta.

Cada script incluye comentarios aclaratorios. Resultados y explicaciones ampliadas están registrados en el PDF.

---

## <h2 id="autoria">👩‍💻 Autoría</h2>

Belén María Solís Valle  
DAW – Curso 2023/2024

---
