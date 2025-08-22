drop database if exists FitConnet;
create database FitConnet;
use FitConnet;

CREATE TABLE objetivos (
    id_objetivo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    edad INT,
    sexo VARCHAR(10),
    peso DECIMAL(5,2),
    altura DECIMAL(4,2),
    id_objetivo INT,
    id_entrenador INT,
    fecha_registro DATE,
    foto_perfil VARCHAR(255),
    FOREIGN KEY (id_objetivo) REFERENCES objetivos(id_objetivo),
    FOREIGN KEY (id_entrenador) REFERENCES usuarios(id_usuario)
);

CREATE TABLE poblacion (
    id_poblacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    sexo ENUM('Hombre', 'Mujer') NOT NULL,
    fecha_registro DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE rutinas (
    id_rutina int AUTO_INCREMENT PRIMARY KEY,
    nombre_rutina VARCHAR(100) NOT NULL,
    tipo VARCHAR(50), -- Ej: 'Casa', 'Gimnasio', 'Calistenia'
    nivel VARCHAR(50),  -- Ej: 'Principiante', 'Intermedio', 'Avanzado'
    duracion_minutos INT,
    descripcion TEXT,
    video_url VARCHAR(255),
    fecha_registro DATE,
    fecha_inicio DATE,
    fecha_fin DATE,
    creador_id INT,
    FOREIGN KEY (creador_id) REFERENCES usuarios(id_usuario)
);

CREATE TABLE ejercicios (
    id_ejercicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    video_url VARCHAR(255),
    duracion_minutos INT,
    id_rutina INT,
    fecha_registro DATE,
    FOREIGN KEY (id_rutina) REFERENCES rutinas(id_rutina)
);

CREATE TABLE planes_dieta (
    id_dieta INT AUTO_INCREMENT PRIMARY KEY,
    nombre_dieta VARCHAR(100) NOT NULL,
    descripcion TEXT,
    calorias_aprox INT,
    funciones TEXT,
    tipo VARCHAR(50),
    creador_id INT,
    fecha_registro DATE,
    FOREIGN KEY (creador_id) REFERENCES usuarios(id_usuario)
);

CREATE TABLE progreso_usuario (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_registro DATE,
    peso_actual DECIMAL(5,2),
    grasa_corporal DECIMAL(4,2),
    masa_muscular DECIMAL(4,2),
    observaciones TEXT,
    imagen_url VARCHAR(255),
    id_entrenador INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_entrenador) REFERENCES usuarios(id_usuario)
);

CREATE TABLE publicaciones (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    contenido TEXT,
    imagen_url VARCHAR(255),
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE comentarios (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_publicacion INT,
    contenido VARCHAR(500) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion)
);

CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50),
    id_referencia INT,
    mensaje TEXT,
    id_usuario INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leida BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE rol_usuarios (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE usuario_rol (
    id_usuario INT,
    id_rol INT,
    fecha_asignacion DATE,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES rol_usuarios(id_rol)
);

CREATE TABLE ejecucion_rutina (
    id_ejecucion INT AUTO_INCREMENT PRIMARY KEY,
    numero_serie INT,
    numero_repeticiones INT,
    peso_utilizado DECIMAL(5,2),
    fecha_ejecucion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_ejercicio INT,
    id_rutina INT,
    id_usuario INT,
    FOREIGN KEY (id_ejercicio) REFERENCES ejercicios(id_ejercicio),
    FOREIGN KEY (id_rutina) REFERENCES rutinas(id_rutina),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE logros (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_ejecucion INT,
    nombre_logro VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_logro DATE,
    numero_serie INT,
    numero_repeticiones INT,
    peso_utilizado DECIMAL(5,2),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_ejecucion) REFERENCES ejecucion_rutina(id_ejecucion)
);




UPDATE usuarios SET id_entrenador = 2 WHERE id_usuario IN (1, 3, 5);  -- Pedro entrena a Laura, Sandra y Andrea
UPDATE usuarios SET id_entrenador = 6 WHERE id_usuario IN (7, 9);     -- David entrena a Ana y Lucía
UPDATE usuarios SET id_entrenador = 8 WHERE id_usuario IN (4, 10);    -- Carlos entrena a José y Diego


