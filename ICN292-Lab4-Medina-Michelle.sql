-- 1. PREPARACIÓN DE LA BASE DE DATOS
DROP DATABASE IF EXISTS austral;
CREATE DATABASE austral;
USE austral;

-- 2. CREACIÓN DE TABLAS
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    pais VARCHAR(60),
    genero ENUM('Cómic', 'Ensayo', 'Infantil', 'Novela', 'Poesía') NOT NULL
);

CREATE TABLE colecciones (
    id_coleccion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    fecha_publicacion DATE
);

CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    id_coleccion INT NOT NULL,
    titulo VARCHAR(120) NOT NULL,
    paginas INT,
    ejemplares_vendidos INT,
    anio INT,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_coleccion) REFERENCES colecciones(id_coleccion)
);

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    fecha_pago DATE,
    monto DECIMAL(10,2),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

-- 3. CARGA DE DATOS (En el orden correcto)
INSERT INTO autores (nombre, pais, genero) VALUES
('Elena Pizarro', 'Chile', 'Novela'),
('Harold Finch', 'Inglaterra', 'Ensayo'),
('Rodrigo Bahamonde', 'Chile', 'Poesía'),
('Valentina Correa', 'Argentina', 'Infantil'),
('Nora Keller', 'Estados Unidos', 'Novela'),
('Kenji Arakawa', NULL, 'Cómic');

INSERT INTO colecciones (titulo, fecha_publicacion) VALUES
('Colección Clásica', '2022-01-15'),
('Colección Contemporánea', '2023-05-20');

INSERT INTO libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) VALUES
(1, 1, 'Cielo de Enero', 210, 1500, 2024),
(1, 1, 'Marea Baja', 185, 800, 2023),
(1, 2, 'El Norte', 200, 2200, 2024),
(2, 2, 'Estrellas que Caen', 240, 3000, 2022),
(2, 1, 'Máquinas', 215, 450, 2024),
(3, 2, 'Luz Artificial', 300, 1200, 2024),
(3, 1, 'Ruido Blanco', 280, 600, 2023),
(4, 2, 'El Barrio de Lila', 190, 5000, 2024),
(4, 1, 'Antes del Amanecer', 205, 2700, 2024),
(4, 2, 'La Calle 8', 175, 900, 2023),
(5, 1, 'Flor de Hierro', 195, 4100, 2024),
(5, 2, 'Hora Dorada', 220, 1800, 2022);

INSERT INTO pagos (id_autor, fecha_pago, monto) VALUES
(1, '2024-01-10', 150000.00),
(1, '2024-06-15', 250000.50),
(4, '2024-03-20', 320000.00);

-- ENTREGABLE 2: CONSULTAS

-- Consulta 1: Autores cuyo país no es Chile (incluyendo NULL)
SELECT nombre, genero 
FROM autores 
WHERE pais <> 'Chile' OR pais IS NULL 
ORDER BY nombre;

-- Consulta 2: Libros entre 190 y 220 páginas
SELECT titulo, paginas 
FROM libros 
WHERE paginas BETWEEN 190 AND 220 
ORDER BY paginas ASC;

-- Consulta 3: Estadísticas del catálogo
SELECT 
    COUNT(*) AS total_libros, 
    SUM(ejemplares_vendidos) AS total_vendidos, 
    AVG(paginas) AS promedio_paginas, 
    MIN(anio) AS anio_mas_antiguo, 
    MAX(ejemplares_vendidos) AS max_vendidos 
FROM libros;

-- Consulta 4: Géneros sin repetir en orden alfabético
SELECT DISTINCT genero 
FROM autores 
ORDER BY genero ASC;

-- Consulta 5: Autores con más de 1 libro en 2024
SELECT a.nombre, COUNT(l.id_libro) AS cantidad_libros
FROM autores a
JOIN libros l ON a.id_autor = l.id_autor
WHERE l.anio = 2024
GROUP BY a.id_autor, a.nombre
HAVING COUNT(l.id_libro) > 1
ORDER BY a.nombre;

-- Consulta 6: Top 3 libros de 2024 con más de 2000 ventas
SELECT titulo, ejemplares_vendidos 
FROM libros 
WHERE anio = 2024 AND ejemplares_vendidos > 2000 
ORDER BY ejemplares_vendidos DESC 
LIMIT 3;

-- Consulta 7: Inserción y eliminación de libro
-- Paso A: Insertar
INSERT INTO libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) 
VALUES (3, 1, 'Papel Mojado', 260, 50, 2024);
-- Paso B: Select previo para comprobar inserción
SELECT * FROM libros WHERE titulo = 'Papel Mojado';
-- Paso C: Eliminar (desactivando temporalmente el modo seguro para evitar errores)
SET SQL_SAFE_UPDATES = 0;
DELETE FROM libros WHERE titulo = 'Papel Mojado';
SET SQL_SAFE_UPDATES = 1;
-- Paso D: Select posterior para comprobar eliminación
SELECT * FROM libros WHERE titulo = 'Papel Mojado';

-- Consulta 8: Actualizar ejemplares vendidos de 'Cielo de Enero'
-- Paso A: Select previo
SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';
-- Paso B: Update calculando sobre el valor actual
SET SQL_SAFE_UPDATES = 0;
UPDATE libros SET ejemplares_vendidos = ejemplares_vendidos + 100 WHERE titulo = 'Cielo de Enero';
SET SQL_SAFE_UPDATES = 1;
-- Paso C: Select posterior para comprobar el cambio
SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';

-- Consulta 9: Libro, colección y fecha de publicación
SELECT l.titulo AS libro, c.titulo AS coleccion, c.fecha_publicacion 
FROM libros l
JOIN colecciones c ON l.id_coleccion = c.id_coleccion;


-- Consulta 10: Pagos a autores (Dos partes)
-- Parte A: Detalle de pagos
SELECT a.nombre AS autor, p.fecha_pago, p.monto 
FROM pagos p
JOIN autores a ON p.id_autor = a.id_autor;
-- Parte B: Total pagado por autor
SELECT a.nombre AS autor, SUM(p.monto) AS total_pagado 
FROM pagos p
JOIN autores a ON p.id_autor = a.id_autor
GROUP BY a.id_autor, a.nombre;
