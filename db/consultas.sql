-- Consultas

-- 1. OBJETIVOS
-- CREATE: Insertar nuevo objetivo
INSERT INTO objetivos (descripcion) VALUES ('Mejorar resistencia cardiovascular');
-- READ: Consultar todos los objetivos
SELECT * FROM objetivos;
-- UPDATE: Actualizar descripción de un objetivo
UPDATE objetivos SET descripcion = 'Aumentar fuerza y resistencia' WHERE id_objetivo = 5;
-- DELETE: Eliminar un objetivo (si no está siendo utilizado)
DELETE FROM objetivos WHERE id_objetivo = 5;


-- 2. USUARIOS
-- CREATE: Registrar nuevo usuario
INSERT INTO usuarios (nombre, correo_electronico, contraseña, edad, sexo, peso, altura, id_objetivo)
VALUES ('Mario Gómez', 'mario@gmail.com', 'clave123', 27, 'Masculino', 74.5, 1.82, 2);
-- READ: Consultar todos los usuarios
SELECT * FROM usuarios;
-- READ: Consultar usuarios por objetivo específico
SELECT u.id_usuario, u.nombre, u.edad, o.descripcion as objetivo
FROM usuarios u
JOIN objetivos o ON u.id_objetivo = o.id_objetivo
WHERE u.id_objetivo = 2;
-- UPDATE: Actualizar información de usuario
UPDATE usuarios 
SET peso = 73.8, id_objetivo = 3
WHERE id_usuario = 5;
-- DELETE: Eliminar usuario
DELETE FROM usuarios WHERE id_usuario = 5;


-- 3. RUTINAS_EJERCICIO
-- CREATE: Crear nueva rutina
INSERT INTO rutinas_ejercicio (nombre_rutina, tipo, nivel, duracion_minutos, descripcion, video_url, creador_id)
VALUES ('Entrenamiento para corredores', 'Mixto', 'Intermedio', 35, 'Ejercicios para mejorar rendimiento en carrera', 'https://video5.com', 1);
-- READ: Mostrar todas las rutinas
SELECT * FROM rutinas_ejercicio;
-- READ: Mostrar rutinas para principiantes
SELECT id_rutina, nombre_rutina, duracion_minutos, u.nombre as creador
FROM rutinas_ejercicio r
JOIN usuarios u ON r.creador_id = u.id_usuario
WHERE nivel = 'Principiante';
-- UPDATE: Actualizar rutina
UPDATE rutinas_ejercicio 
SET duracion_minutos = 50, descripcion = 'Rutina actualizada con ejercicios adicionales'
WHERE id_rutina = 3;
-- DELETE: Eliminar rutina
DELETE FROM rutinas_ejercicio WHERE id_rutina = 5;


-- 4. PLANES_DIETA
-- CREATE: Agregar nuevo plan de dieta
INSERT INTO planes_dieta (nombre_dieta, descripcion, calorias_aprox, tipo, creador_id)
VALUES ('Dieta Mediterránea', 'Basada en alimentos frescos y aceite de oliva', 1900, 'Balanceada', 4);
-- READ: Mostrar todas las dietas
SELECT * FROM planes_dieta;
-- READ: Mostrar dietas por tipo
SELECT id_dieta, nombre_dieta, calorias_aprox, u.nombre as creador
FROM planes_dieta d
JOIN usuarios u ON d.creador_id = u.id_usuario
WHERE tipo = 'Balanceada';
-- UPDATE: Actualizar plan de dieta
UPDATE planes_dieta 
SET calorias_aprox = 2100, descripcion = 'Actualizada con más opciones de proteínas'
WHERE id_dieta = 2;
-- DELETE: Eliminar plan de dieta
DELETE FROM planes_dieta WHERE id_dieta = 4;


-- 5. PROGRESO_USUARIO
-- CREATE: Registrar nuevo progreso
INSERT INTO progreso_usuario (id_usuario, fecha_registro, peso_actual, grasa_corporal, masa_muscular, observaciones)
VALUES (2, '2025-06-10', 77.8, 24.5, 33.5, 'Mejora gradual, reducción de peso');
-- READ: Consultar todos los registros de progreso
SELECT * FROM progreso_usuario;
-- READ: Consultar progreso de un usuario específico
SELECT p.*, u.nombre 
FROM progreso_usuario p
JOIN usuarios u ON p.id_usuario = u.id_usuario
WHERE p.id_usuario = 1
ORDER BY p.fecha_registro DESC;
-- UPDATE: Actualizar registro de progreso
UPDATE progreso_usuario
SET peso_actual = 60.8, grasa_corporal = 21.0, observaciones = 'Corrección de medidas'
WHERE id_progreso = 2;
-- DELETE: Eliminar registro de progreso
DELETE FROM progreso_usuario WHERE id_progreso = 4;


-- 6. PUBLICACIONES
-- CREATE: Crear nueva publicación
INSERT INTO publicaciones (id_usuario, contenido, imagen_url)
VALUES (3, 'Hoy completé mi primer mes siguiendo la dieta proteica', 'mes1.jpg');
-- READ: Mostrar todas las publicaciones
SELECT * FROM publicaciones;
-- READ: Mostrar publicaciones con información de usuario
SELECT p.id_publicacion, p.contenido, p.fecha_publicacion, u.nombre, u.foto_perfil
FROM publicaciones p
JOIN usuarios u ON p.id_usuario = u.id_usuario
ORDER BY p.fecha_publicacion DESC;
-- UPDATE: Actualizar publicación
UPDATE publicaciones
SET contenido = 'Actualización: ¡Ahora son 6 días con la dieta keto y me siento increíble!'
WHERE id_publicacion = 2;
-- DELETE: Eliminar publicación
DELETE FROM publicaciones WHERE id_publicacion = 5;
