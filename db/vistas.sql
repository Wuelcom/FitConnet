-- Vistas

-- Vista 1: Resumen de usuarios con sus objetivos
CREATE VIEW v_usuarios_objetivos AS
SELECT 
    u.id_usuario,
    u.nombre,
    u.edad,
    u.sexo,
    u.peso,
    u.altura,
    ROUND(u.peso / POWER(u.altura, 2), 2) AS imc,
    o.descripcion AS objetivo,
    u.fecha_registro,
    DATEDIFF(CURDATE(), u.fecha_registro) AS dias_registrado
FROM 
    usuarios u
JOIN 
    objetivos o ON u.id_objetivo = o.id_objetivo;
    
    
    -- Vista 2: Progreso detallado de usuarios
CREATE VIEW v_progreso_detallado AS
SELECT 
    p.id_progreso,
    u.id_usuario,
    u.nombre,
    p.fecha_registro,
    p.peso_actual,
    u.altura,
    ROUND(p.peso_actual / POWER(u.altura, 2), 2) AS imc,
    p.grasa_corporal,
    p.masa_muscular,
    o.descripcion AS objetivo,
    p.observaciones
FROM 
    progreso_usuario p
JOIN 
    usuarios u ON p.id_usuario = u.id_usuario
JOIN 
    objetivos o ON u.id_objetivo = o.id_objetivo
ORDER BY 
    u.id_usuario, p.fecha_registro DESC;
    
    
    -- Vista 3: Últimas mediciones de cada usuario
CREATE VIEW v_ultima_medicion_usuarios AS
SELECT 
    u.id_usuario,
    u.nombre,
    u.correo_electronico,
    p.fecha_registro AS ultima_fecha_registro,
    p.peso_actual,
    p.grasa_corporal,
    p.masa_muscular,
    o.descripcion AS objetivo,
    DATEDIFF(CURDATE(), p.fecha_registro) AS dias_desde_ultima_medicion
FROM 
    usuarios u
LEFT JOIN 
    (SELECT id_usuario, MAX(fecha_registro) AS max_fecha
     FROM progreso_usuario
     GROUP BY id_usuario) latest ON u.id_usuario = latest.id_usuario
LEFT JOIN 
    progreso_usuario p ON latest.id_usuario = p.id_usuario AND latest.max_fecha = p.fecha_registro
LEFT JOIN 
    objetivos o ON u.id_objetivo = o.id_objetivo;
    
    
    -- Vista 4: Resumen de rutinas con información del creador
CREATE VIEW v_rutinas_detalle AS
SELECT 
    r.id_rutina,
    r.nombre_rutina,
    r.tipo,
    r.nivel,
    r.duracion_minutos,
    r.descripcion,
    r.video_url,
    r.fecha_registro,
    u.id_usuario AS creador_id,
    u.nombre AS creador_nombre,
    u.foto_perfil AS creador_foto
FROM 
    rutinas_ejercicio r
JOIN 
    usuarios u ON r.creador_id = u.id_usuario;
    
    
    -- Vista 5: Resumen de planes de dieta con creador
CREATE VIEW v_dietas_detalle AS
SELECT 
    d.id_dieta,
    d.nombre_dieta,
    d.descripcion,
    d.calorias_aprox,
    d.tipo,
    d.fecha_registro,
    u.id_usuario AS creador_id,
    u.nombre AS creador_nombre,
    u.foto_perfil AS creador_foto
FROM 
    planes_dieta d
JOIN 
    usuarios u ON d.creador_id = u.id_usuario;
    
    
    -- Vista 6: Feed de publicaciones con detalles de usuario
CREATE VIEW v_feed_publicaciones AS
SELECT 
    p.id_publicacion,
    p.contenido,
    p.imagen_url,
    p.fecha_publicacion,
    u.id_usuario,
    u.nombre,
    u.foto_perfil,
    TIMESTAMPDIFF(MINUTE, p.fecha_publicacion, CURRENT_TIMESTAMP) AS minutos_transcurridos
FROM 
    publicaciones p
JOIN 
    usuarios u ON p.id_usuario = u.id_usuario
ORDER BY 
    p.fecha_publicacion DESC;
    
    
    -- Vista 7: Estadísticas de progreso por objetivo
CREATE VIEW v_estadisticas_por_objetivo AS
SELECT 
    o.id_objetivo,
    o.descripcion,
    COUNT(DISTINCT u.id_usuario) AS total_usuarios,
    AVG(p.peso_actual) AS peso_promedio,
    AVG(p.grasa_corporal) AS grasa_promedio,
    AVG(p.masa_muscular) AS masa_muscular_promedio,
    MIN(p.peso_actual) AS peso_minimo,
    MAX(p.peso_actual) AS peso_maximo
FROM 
    objetivos o
LEFT JOIN 
    usuarios u ON o.id_objetivo = u.id_objetivo
LEFT JOIN 
    progreso_usuario p ON u.id_usuario = p.id_usuario
GROUP BY 
    o.id_objetivo, o.descripcion;
