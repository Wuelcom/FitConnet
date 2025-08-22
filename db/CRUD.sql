-- CRUD

-- Procedimiento 1: Registrar nuevo usuario con validaciones
DELIMITER //
CREATE PROCEDURE sp_registrar_usuario(
    IN p_nombre VARCHAR(100),
    IN p_correo_electronico VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_edad INT,
    IN p_sexo VARCHAR(10),
    IN p_peso DECIMAL(5,2),
    IN p_altura DECIMAL(4,2),
    IN p_id_objetivo INT
)
BEGIN
    DECLARE email_existe INT DEFAULT 0;
    DECLARE objetivo_existe INT DEFAULT 0;
    DECLARE mensaje_error VARCHAR(100);
    DECLARE id_nuevo_usuario INT;
    
    -- Verificar si el correo ya existe
    SELECT COUNT(*) INTO email_existe FROM usuarios WHERE correo_electronico = p_correo_electronico;
    
    -- Verificar si el objetivo existe
    SELECT COUNT(*) INTO objetivo_existe FROM objetivos WHERE id_objetivo = p_id_objetivo;
    
    -- Validaciones
    IF email_existe > 0 THEN
        SET mensaje_error = 'El correo electrónico ya está registrado';
        SELECT FALSE AS exito, mensaje_error AS mensaje;
    ELSEIF objetivo_existe = 0 THEN
        SET mensaje_error = 'El objetivo seleccionado no existe';
        SELECT FALSE AS exito, mensaje_error AS mensaje;
    ELSEIF p_edad < 18 OR p_edad > 100 THEN
        SET mensaje_error = 'La edad debe estar entre 18 y 100 años';
        SELECT FALSE AS exito, mensaje_error AS mensaje;
    ELSEIF p_peso <= 0 OR p_peso > 300 THEN
        SET mensaje_error = 'El peso debe ser mayor a 0 y menor a 300 kg';
        SELECT FALSE AS exito, mensaje_error AS mensaje;
    ELSEIF p_altura <= 0 OR p_altura > 2.5 THEN
        SET mensaje_error = 'La altura debe ser mayor a 0 y menor a 2.5 m';
        SELECT FALSE AS exito, mensaje_error AS mensaje;
    ELSE
        -- Insertar nuevo usuario
        INSERT INTO usuarios(nombre, correo_electronico, contraseña, edad, sexo, peso, altura, id_objetivo)
        VALUES (p_nombre, p_correo_electronico, p_contraseña, p_edad, p_sexo, p_peso, p_altura, p_id_objetivo);
        
        SET id_nuevo_usuario = LAST_INSERT_ID();
        
        -- Registrar primer progreso
        INSERT INTO progreso_usuario(id_usuario, peso_actual, observaciones)
        VALUES (id_nuevo_usuario, p_peso, 'Registro inicial');
        
        SELECT TRUE AS exito, 'Usuario registrado correctamente' AS mensaje, id_nuevo_usuario AS id_usuario;
    END IF;
END //
DELIMITER ;


-- Procedimiento 2: Registrar progreso de usuario con cálculo de diferencias
DELIMITER //
CREATE PROCEDURE sp_registrar_progreso(
    IN p_id_usuario INT,
    IN p_peso_actual DECIMAL(5,2),
    IN p_grasa_corporal DECIMAL(4,2),
    IN p_masa_muscular DECIMAL(4,2),
    IN p_observaciones TEXT
)
BEGIN
    DECLARE usuario_existe INT DEFAULT 0;
    DECLARE ultimo_peso DECIMAL(5,2);
    DECLARE ultima_grasa DECIMAL(4,2);
    DECLARE ultima_masa DECIMAL(4,2);
    DECLARE diferencia_peso DECIMAL(5,2);
    DECLARE diferencia_grasa DECIMAL(4,2);
    DECLARE diferencia_masa DECIMAL(4,2);
    
    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO usuario_existe FROM usuarios WHERE id_usuario = p_id_usuario;
    
    IF usuario_existe = 0 THEN
        SELECT FALSE AS exito, 'El usuario no existe' AS mensaje;
    ELSE
        -- Obtener último registro de progreso
        SELECT peso_actual, grasa_corporal, masa_muscular INTO ultimo_peso, ultima_grasa, ultima_masa
        FROM progreso_usuario
        WHERE id_usuario = p_id_usuario
        ORDER BY fecha_registro DESC
        LIMIT 1;
        
        -- Calcular diferencias
        SET diferencia_peso = p_peso_actual - IFNULL(ultimo_peso, p_peso_actual);
        SET diferencia_grasa = p_grasa_corporal - IFNULL(ultima_grasa, p_grasa_corporal);
        SET diferencia_masa = p_masa_muscular - IFNULL(ultima_masa, p_masa_muscular);
        
        -- Insertar nuevo progreso
        INSERT INTO progreso_usuario(id_usuario, peso_actual, grasa_corporal, masa_muscular, observaciones)
        VALUES (p_id_usuario, p_peso_actual, p_grasa_corporal, p_masa_muscular, p_observaciones);
        
        -- Actualizar el peso en la tabla usuarios
        UPDATE usuarios SET peso = p_peso_actual WHERE id_usuario = p_id_usuario;
        
        SELECT 
            TRUE AS exito, 
            'Progreso registrado correctamente' AS mensaje,
            diferencia_peso AS cambio_peso,
            diferencia_grasa AS cambio_grasa,
            diferencia_masa AS cambio_masa,
            LAST_INSERT_ID() AS id_progreso;
    END IF;
END //
DELIMITER ;


-- Procedimiento 3: Crear rutina de ejercicio
DELIMITER //
CREATE PROCEDURE sp_crear_rutina(
    IN p_nombre_rutina VARCHAR(100),
    IN p_tipo VARCHAR(50),
    IN p_nivel VARCHAR(50),
    IN p_duracion_minutos INT,
    IN p_descripcion TEXT,
    IN p_video_url VARCHAR(255),
    IN p_creador_id INT
)
BEGIN
    DECLARE usuario_existe INT DEFAULT 0;
    
    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO usuario_existe FROM usuarios WHERE id_usuario = p_creador_id;
    
    IF usuario_existe = 0 THEN
        SELECT FALSE AS exito, 'El usuario creador no existe' AS mensaje;
    ELSEIF p_duracion_minutos <= 0 OR p_duracion_minutos > 180 THEN
        SELECT FALSE AS exito, 'La duración debe estar entre 1 y 180 minutos' AS mensaje;
    ELSE
        -- Insertar nueva rutina
        INSERT INTO rutinas_ejercicio(nombre_rutina, tipo, nivel, duracion_minutos, descripcion, video_url, creador_id)
        VALUES (p_nombre_rutina, p_tipo, p_nivel, p_duracion_minutos, p_descripcion, p_video_url, p_creador_id);
        
        SELECT TRUE AS exito, 'Rutina creada correctamente' AS mensaje, LAST_INSERT_ID() AS id_rutina;
    END IF;
END //
DELIMITER ;


-- Procedimiento 4: Crear plan de dieta
DELIMITER //
CREATE PROCEDURE sp_crear_dieta(
    IN p_nombre_dieta VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_calorias_aprox INT,
    IN p_tipo VARCHAR(50),
    IN p_creador_id INT
)
BEGIN
    DECLARE usuario_existe INT DEFAULT 0;
    
    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO usuario_existe FROM usuarios WHERE id_usuario = p_creador_id;
    
    IF usuario_existe = 0 THEN
        SELECT FALSE AS exito, 'El usuario creador no existe' AS mensaje;
    ELSEIF p_calorias_aprox < 500 OR p_calorias_aprox > 5000 THEN
        SELECT FALSE AS exito, 'Las calorías deben estar entre 500 y 5000' AS mensaje;
    ELSE
        -- Insertar nuevo plan de dieta
        INSERT INTO planes_dieta(nombre_dieta, descripcion, calorias_aprox, tipo, creador_id)
        VALUES (p_nombre_dieta, p_descripcion, p_calorias_aprox, p_tipo, p_creador_id);
        
        SELECT TRUE AS exito, 'Plan de dieta creado correctamente' AS mensaje, LAST_INSERT_ID() AS id_dieta;
    END IF;
END //
DELIMITER ;



-- Procedimiento 5: Obtener informe de progreso del usuario
DELIMITER //
CREATE PROCEDURE sp_informe_progreso_usuario(IN p_id_usuario INT)
BEGIN
    DECLARE usuario_existe INT DEFAULT 0;
    DECLARE fecha_primer_registro DATE;
    DECLARE dias_seguimiento INT;
    
    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO usuario_existe FROM usuarios WHERE id_usuario = p_id_usuario;
    
    IF usuario_existe = 0 THEN
        SELECT FALSE AS exito, 'El usuario no existe' AS mensaje;
    ELSE
        -- Obtener fecha del primer registro
        SELECT MIN(fecha_registro) INTO fecha_primer_registro 
        FROM progreso_usuario 
        WHERE id_usuario = p_id_usuario;
        
        -- Calcular días de seguimiento
        SET dias_seguimiento = DATEDIFF(CURDATE(), fecha_primer_registro);
        
        -- Información general del usuario
        SELECT 
            TRUE AS exito,
            u.id_usuario,
            u.nombre,
            u.edad,
            u.sexo,
            o.descripcion AS objetivo,
            fecha_primer_registro,
            dias_seguimiento,
            COUNT(p.id_progreso) AS total_registros,
            (SELECT peso_actual FROM progreso_usuario 
             WHERE id_usuario = p_id_usuario 
             ORDER BY fecha_registro ASC LIMIT 1) AS peso_inicial,
            (SELECT peso_actual FROM progreso_usuario 
             WHERE id_usuario = p_id_usuario 
             ORDER BY fecha_registro DESC LIMIT 1) AS peso_actual,
            (SELECT peso_actual FROM progreso_usuario 
             WHERE id_usuario = p_id_usuario 
             ORDER BY fecha_registro DESC LIMIT 1) - 
            (SELECT peso_actual FROM progreso_usuario 
             WHERE id_usuario = p_id_usuario 
             ORDER BY fecha_registro ASC LIMIT 1) AS diferencia_peso
        FROM 
            usuarios u
        JOIN 
            objetivos o ON u.id_objetivo = o.id_objetivo
        LEFT JOIN 
            progreso_usuario p ON u.id_usuario = p.id_usuario
        WHERE 
            u.id_usuario = p_id_usuario
        GROUP BY 
            u.id_usuario, u.nombre, u.edad, u.sexo, o.descripcion, fecha_primer_registro, dias_seguimiento;
            
        -- Historial detallado
        SELECT 
            p.id_progreso,
            p.fecha_registro,
            p.peso_actual,
            p.grasa_corporal,
            p.masa_muscular,
            p.observaciones
        FROM 
            progreso_usuario p
        WHERE 
            p.id_usuario = p_id_usuario
        ORDER BY 
            p.fecha_registro DESC;
    END IF;
END //
DELIMITER ;


-- Procedimiento 6: Recomendación de rutinas según perfil y objetivos
DELIMITER //
CREATE PROCEDURE sp_recomendar_rutinas(IN p_id_usuario INT)
BEGIN
    DECLARE obj_usuario INT;
    DECLARE sex_usuario VARCHAR(10);
    DECLARE nivel_estimado VARCHAR(50);
    
    -- Obtener objetivo y sexo del usuario
    SELECT id_objetivo, sexo INTO obj_usuario, sex_usuario
    FROM usuarios
    WHERE id_usuario = p_id_usuario;
    
    -- Estimar nivel basado en registros de progreso (ejemplo simplificado)
    SELECT 
        CASE 
            WHEN COUNT(*) < 5 THEN 'Principiante'
            WHEN COUNT(*) < 15 THEN 'Intermedio'
            ELSE 'Avanzado'
        END INTO nivel_estimado
    FROM progreso_usuario
    WHERE id_usuario = p_id_usuario;
    
    -- Recomendar rutinas basadas en objetivo y nivel
    SELECT 
        r.id_rutina,
        r.nombre_rutina,
        r.tipo,
        r.nivel,
        r.duracion_minutos,
        r.descripcion,
        r.video_url,
        u.nombre AS creador,
        CASE
            WHEN obj_usuario = 1 AND r.tipo LIKE '%Cardio%' THEN 'Alta - Ayuda a bajar de peso'
            WHEN obj_usuario = 2 AND r.tipo LIKE '%Pesas%' THEN 'Alta - Ayuda a ganar masa muscular'
            WHEN obj_usuario = 3 AND r.tipo LIKE '%Funcional%' THEN 'Alta - Ayuda a tonificar'
            WHEN obj_usuario = 4 THEN 'Media - Mantiene tu condición'
            ELSE 'Baja'
        END AS relevancia
    FROM 
        rutinas_ejercicio r
    JOIN
        usuarios u ON r.creador_id = u.id_usuario
    WHERE
        r.nivel = nivel_estimado
    ORDER BY
        CASE
            WHEN obj_usuario = 1 AND r.tipo LIKE '%Cardio%' THEN 1
            WHEN obj_usuario = 2 AND r.tipo LIKE '%Pesas%' THEN 1
            WHEN obj_usuario = 3 AND r.tipo LIKE '%Funcional%' THEN 1
            WHEN obj_usuario = 4 THEN 2
            ELSE 3
        END,
        r.fecha_registro DESC
    LIMIT 10;
END //
DELIMITER ;


-- Procedimiento 7: Crear publicación con notificación a seguidores
DELIMITER //
CREATE PROCEDURE sp_crear_publicacion(
    IN p_id_usuario INT,
    IN p_contenido TEXT,
    IN p_imagen_url VARCHAR(255)
)
BEGIN
    DECLARE nueva_publicacion_id INT;
    
    -- Validar que el usuario existe
    DECLARE usuario_existe INT;
    SELECT COUNT(*) INTO usuario_existe FROM usuarios WHERE id_usuario = p_id_usuario;
    
    IF usuario_existe = 0 THEN
        SELECT FALSE AS exito, 'El usuario no existe' AS mensaje;
    ELSEIF p_contenido IS NULL AND p_imagen_url IS NULL THEN
        SELECT FALSE AS exito, 'La publicación debe tener contenido o imagen' AS mensaje;
    ELSE
        -- Insertar la publicación
        INSERT INTO publicaciones (id_usuario, contenido, imagen_url)
        VALUES (p_id_usuario, p_contenido, p_imagen_url);
        
        SET nueva_publicacion_id = LAST_INSERT_ID();
        
        -- Crear notificaciones para los seguidores
        -- Asumiendo que existe una tabla de seguidores
        -- Si no existe, deberías crearla primero
        
        CREATE TABLE IF NOT EXISTS seguidores (
            id_seguimiento INT AUTO_INCREMENT PRIMARY KEY,
            id_seguidor INT,
            id_seguido INT,
            fecha_seguimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (id_seguidor) REFERENCES usuarios(id_usuario),
            FOREIGN KEY (id_seguido) REFERENCES usuarios(id_usuario),
            UNIQUE KEY unique_seguimiento (id_seguidor, id_seguido)
        );
        
        CREATE TABLE IF NOT EXISTS notificaciones (
            id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
            tipo VARCHAR(50),
            id_referencia INT,
            mensaje TEXT,
            id_usuario INT,
            fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            leida BOOLEAN DEFAULT FALSE,
            FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
        );
        
        -- Crear notificaciones para seguidores
        INSERT INTO notificaciones (tipo, id_referencia, mensaje, id_usuario)
        SELECT 
            'nueva_publicacion', 
            nueva_publicacion_id, 
            CONCAT((SELECT nombre FROM usuarios WHERE id_usuario = p_id_usuario), ' ha publicado nuevo contenido'), 
            id_seguidor
        FROM 
            seguidores
        WHERE 
            id_seguido = p_id_usuario;
        
        SELECT TRUE AS exito, 'Publicación creada correctamente' AS mensaje, nueva_publicacion_id AS id_publicacion;
    END IF;
END //
DELIMITER ;
