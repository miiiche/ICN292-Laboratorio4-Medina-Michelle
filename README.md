Laboratorio 4: Austral Editores

Solución del Laboratorio 4 de la asignatura ICN-292 Sistemas de Información para la Gestión (UTFSM). Diseño, implementación y consulta de una base de datos relacional para gestión editorial.

Tecnologías

Motor: MySQL 8.0

IDE: MySQL Workbench

Lenguaje: SQL (DDL y DML)

Estructura de la Base de Datos (austral)

autores: Datos biográficos (restricciones NULL y dominio ENUM).

colecciones: Agrupaciones editoriales (DATE).

libros: Catálogo de obras (Claves foráneas hacia autores y colecciones).

pagos: Registro de transacciones (DECIMAL(10,2)).

Archivos del Repositorio

ICN292-Lab4-Medina-Michelle.sql: Script estructurado que incluye:

Definición del esquema (DDL).

Población de datos iniciales y de prueba (DML).

10 consultas de extracción y modificación de datos.

Informe_Laboratorio4.pdf: Documentación técnica, diagrama Entidad-Relación y resultados de ejecución.

Operaciones SQL Implementadas

Definición de Datos: CREATE TABLE, PRIMARY KEY, FOREIGN KEY, AUTO_INCREMENT.

Modificación: INSERT, UPDATE, DELETE (incluye manejo de SQL_SAFE_UPDATES).

Consultas Relacionales: INNER JOIN.

Filtros y Ordenamiento: WHERE, BETWEEN, IS NULL, DISTINCT, ORDER BY, LIMIT.

Agregación y Agrupamiento: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING.

Instrucciones de Ejecución

Abrir MySQL Workbench y conectar al servidor local.

Cargar el archivo ICN292-Lab4-Medina-Michelle.sql.

Ejecutar el script completo (Ctrl + Shift + Enter).

Visualizar la creación del esquema, inserciones y la salida de las 10 consultas en el Result Grid.
