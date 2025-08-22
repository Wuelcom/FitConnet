-- Disparadores

-- Trigger 1: Actualizar peso en tabla usuarios cuando se registra un nuevo progreso
DELIMITER //
CREATE TRIGGER tr_actualizar_peso_usuario 
AFTER INSERT ON progreso_usuario
FOR EACH ROW
BEGIN
    UPDATE usuarios
    SET peso = NEW.peso_actual
    WHERE id_usuario = NEW.id_usuario;
END //
DELIMITER ;


-- Trigger 2: Validar valores de progreso antes de insertar
DELIMITER //
CREATE TRIGGER tr_validar_progreso
BEFORE INSERT ON progreso_usuario
FOR EACH ROW
BEGIN
    DECLARE mensaje VARCHAR(100);
    
    -- Validar peso
    IF NEW.peso_actual <= 0 OR NEW.peso_actual > 300 THEN
        SET mensaje = CONCAT('Peso inválido: ', NEW.peso_actual, ' kg');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
    
    -- Validar grasa corporal
    IF NEW.grasa_corporal IS NOT NULL AND (NEW.grasa_corporal < 0 OR NEW.grasa_corporal > 70) THEN
        SET mensaje = CONCAT('Porcentaje de grasa corporal inválido: ', NEW.grasa_corporal, '%');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
    
    -- Validar masa muscular
    IF NEW.masa_muscular IS NOT NULL AND (NEW.masa_muscular < 0 OR NEW.masa_muscular > 70) THEN
        SET mensaje = CONCAT('Porcentaje de masa muscular inválido: ', NEW.masa_muscular, '%');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
END //
DELIMITER ;


-- Trigger 3: Registrar cambios en objetivos de usuario en un registro histórico
DELIMITER //
CREATE TRIGGER tr_historial_objetivos
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
    -- Solo si cambió el objetivo del usuario
    IF OLD.id_objetivo <> NEW.id_objetivo THEN
        -- Creamos primero la tabla historial_objetivos si no existe
        
        CREATE TABLE IF NOT EXISTS historial_objetivos (
            id_historial INT AUTO_INCREMENT PRIMARY KEY,
            id_usuario INT,
            id_objetivo_anterior INT,
            id_objetivo_nuevo INT,
            fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
            FOREIGN KEY (id_objetivo_anterior) REFERENCES objetivos(id_objetivo),
            FOREIGN KEY (id_objetivo_nuevo) REFERENCES objetivos(id_objetivo)
        );
        
        INSERT INTO historial_objetivos (id_usuario, id_objetivo_anterior, id_objetivo_nuevo)
        VALUES (NEW.id_usuario, OLD.id_objetivo, NEW.id_objetivo);
    END IF;
END //
DELIMITER ;


-- Trigger 4: Validar datos de usuario antes de insertar
DELIMITER //
CREATE TRIGGER tr_validar_usuario
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    DECLARE mensaje VARCHAR(100);
    
    -- Validar edad
    IF NEW.edad IS NOT NULL AND (NEW.edad < 16 OR NEW.edad > 100) THEN
        SET mensaje = CONCAT('Edad inválida: ', NEW.edad, ' años');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
    
    -- Validar peso
    IF NEW.peso IS NOT NULL AND (NEW.peso <= 0 OR NEW.peso > 300) THEN
        SET mensaje = CONCAT('Peso inválido: ', NEW.peso, ' kg');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
    
    -- Validar altura
    IF NEW.altura IS NOT NULL AND (NEW.altura <= 0 OR NEW.altura > 2.5) THEN
        SET mensaje = CONCAT('Altura inválida: ', NEW.altura, ' m');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
    
    -- Validar email (formato básico)
    IF NEW.correo_electronico NOT LIKE '%@%.%' THEN
        SET mensaje = 'Formato de correo electrónico inválido';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
    
    -- Validar contraseña (mínimo 6 caracteres)
    IF LENGTH(NEW.contraseña) < 6 THEN
        SET mensaje = 'La contraseña debe tener al menos 6 caracteres';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje;
    END IF;
END //
DELIMITER ;


-- Trigger 5: Crear notificación automática cuando un usuario crea una nueva rutina
DELIMITER //
CREATE TRIGGER tr_notificar_nueva_rutina
AFTER INSERT ON rutinas_ejercicio
FOR EACH ROW
BEGIN
    -- Creamos primero la tabla notificaciones si no existe
    
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
    
    -- Notificación para el creador
    INSERT INTO notificaciones (tipo, id_referencia, mensaje, id_usuario)
    VALUES ('nueva_rutina', NEW.id_rutina, 
           CONCAT('Has creado una nueva rutina: ', NEW.nombre_rutina), 
           NEW.creador_id);
           
    -- También se podrían crear notificaciones para otros usuarios con el mismo objetivo
    -- que puedan estar interesados en esta rutina
END //
DELIMITER ;


-- Trigger 6: Crear publicación automática al alcanzar un hito de progreso
DELIMITER //
CREATE TRIGGER tr_publicacion_hito_progreso
AFTER INSERT ON progreso_usuario
FOR EACH ROW
BEGIN
    DECLARE primer_peso DECIMAL(5,2);
    DECLARE diferencia DECIMAL(5,2);
    DECLARE objetivo_usuario INT;
    DECLARE descripcion_objetivo VARCHAR(100);
    
    -- Obtener el primer peso registrado del usuario
    SELECT peso_actual INTO primer_peso
    FROM progreso_usuario
    WHERE id_usuario = NEW.id_usuario
    ORDER BY fecha_registro ASC
    LIMIT 1;
    
    -- Calcular diferencia
    SET diferencia = NEW.peso_actual - primer_peso;
    
    -- Obtener objetivo del usuario
    SELECT id_objetivo INTO objetivo_usuario
    FROM usuarios
    WHERE id_usuario = NEW.id_usuario;
    
    SELECT descripcion INTO descripcion_objetivo
    FROM objetivos
    WHERE id_objetivo = objetivo_usuario;
    
    -- Si el objetivo es bajar de peso y ha perdido al menos 5kg
    IF objetivo_usuario = 1 AND diferencia <= -5 THEN
        INSERT INTO publicaciones (id_usuario, contenido)
        VALUES (NEW.id_usuario, CONCAT('¡He alcanzado un hito importante! He perdido ', 
               ABS(ROUND(diferencia, 2)), ' kg desde que comencé mi viaje fitness.'));
    
    -- Si el objetivo es ganar masa muscular y ha aumentado al menos 3kg
    ELSEIF objetivo_usuario = 2 AND diferencia >= 3 THEN
        INSERT INTO publicaciones (id_usuario, contenido)
        VALUES (NEW.id_usuario, CONCAT('¡He alcanzado un hito importante! He ganado ', 
               ROUND(diferencia, 2), ' kg de masa desde que comencé mi viaje fitness.'));
    END IF;
END //
DELIMITER ;
