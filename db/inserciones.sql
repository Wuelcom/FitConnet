INSERT INTO objetivos (descripcion) VALUES
('Bajar de peso'),
('Ganar masa muscular'),
('Tonificar cuerpo'),
('Mantener condición física');


INSERT INTO usuarios (nombre, correo_electronico, contraseña, edad, sexo, peso, altura, id_objetivo, fecha_registro, foto_perfil)
VALUES
('Laura Gómez', 'laura@gmail.com', 'laura123', 27, 'Femenino', 58.0, 1.68, 2, '2025-02-15', 'laura.jpg'),
('Pedro Salazar', 'pedro@gmail.com', 'pedro456', 40, 'Masculino', 90.5, 1.82, 1, '2025-02-15', 'pedro.jpg'),
('Sandra Ruiz', 'sandra@gmail.com', 'sandra789', 33, 'Femenino', 64.3, 1.70, 3, '2025-03-03', 'sandra.jpg'),
('José Morales', 'jose@gmail.com', 'jose987', 29, 'Masculino', 75.0, 1.76, 4, '2025-03-18', 'jose.jpg'),
('Andrea Cifuentes', 'andrea@gmail.com', 'andrea654', 21, 'Femenino', 52.1, 1.60, 3, '2025-04-15', 'andrea.jpg'),
('David Blanco', 'david@gmail.com', 'david321', 38, 'Masculino', 85.2, 1.80, 2, '2025-04-25', 'david.jpg'),
('Ana Torres', 'ana@gmail.com', '123456', 28, 'Femenino', 62.5, 1.65, 3, '2025-05-1', 'ana.jpg'),
('Carlos Méndez', 'carlos@gmail.com', 'abc123', 35, 'Masculino', 78.0, 1.75, 1, '2025-05-19', 'carlos.jpg'),
('Lucía Pérez', 'lucia@gmail.com', 'lucia321', 22, 'Femenino', 55.3, 1.60, 2, '2025-06-06', 'lucia.jpg'),
('Diego Ríos', 'diego@gmail.com', 'diego456', 30, 'Masculino', 82.0, 1.78, 4, '2025-06-30', 'diego.jpg'),
('Camila Herrera', 'camila@gmail.com', 'camila123', 26, 'Femenino', 59.0, 1.65, 3, '2025-07-01', 'camila.jpg'),
('Felipe González', 'felipe@gmail.com', 'felipe456', 31, 'Masculino', 82.5, 1.80, 1, '2025-07-01', 'felipe.jpg'),
('Valeria Sánchez', 'valeria@gmail.com', 'valeria789', 24, 'Femenino', 54.2, 1.62, 2, '2025-07-02', 'valeria.jpg'),
('Juan Ramírez', 'juan@gmail.com', 'juan123', 36, 'Masculino', 88.3, 1.78, 2, '2025-07-02', 'juan.jpg');

INSERT INTO poblacion (id_usuario, poblacion) VALUES
(1, 'mujeres'),
(2, 'hombres'),
(3, 'mujeres'),
(4, 'hombres'),
(5, 'mujeres'),
(6, 'hombres'),
(7, 'mujeres'),
(8, 'hombres'),
(9, 'mujeres'),
(10, 'hombres'),
(11, 'mujeres'),
(12, 'hombres'),
(13, 'mujeres'),
(14, 'hombres');

INSERT INTO rutinas (nombre_rutina, tipo, nivel, duracion_minutos, descripcion, video_url, creador_id)
VALUES
('Full Body en Casa', 'Casa', 'Principiante', 30, 'Ejercicios básicos sin equipo', 'https://video1.com', 1),
('Cardio Intenso', 'Casa', 'Avanzado', 25, 'Entrenamiento HIIT', 'https://video2.com', 2),
('Pesas para Principiantes', 'Gimnasio', 'Principiante', 45, 'Rutina de fuerza básica', 'https://video3.com', 2),
('Calistenia Nivel 1', 'Calistenia', 'Intermedio', 40, 'Rutina con peso corporal', 'https://video4.com', 3);

INSERT INTO ejercicios (nombre, descripcion, video_url, duracion_minutos, id_rutina, fecha_registro) VALUES
-- Ejercicios para "Casa-Principiente" (id_rutina = 1)
('Marcha en el lugar', 'Caminar en el mismo sitio para calentar', 'https://video.com/marcha', 5, 1, '2025-06-20'),
('Elevación de rodillas', 'Levantar las rodillas alternadamente', 'https://video.com/elevacion_rodillas', 5, 1, '2025-06-20'),
('Flexiones contra la pared', 'Flexiones inclinadas apoyado en la pared', 'https://video.com/flexion_pared', 4, 1, '2025-06-20'),

-- Ejercicios para "Casa-Intermedio" (id_rutina = 1)
('Jumping jacks avanzados', 'Saltos rápidos con brazos y piernas', 'https://video.com/jumping_intermedio', 7, 1, '2025-06-20'),
('Sentadillas con salto', 'Sentadilla seguida de salto', 'https://video.com/sentadilla_salto', 6, 1, '2025-06-20'),
('Plancha dinámica', 'Variación de plancha con movimiento', 'https://video.com/plancha_dinamica', 5, 1, '2025-06-20'),

-- Ejercicios para "Casa-Avanzado" (id_rutina = 1)
('Burpees completos', 'Burpee con salto alto y flexión', 'https://video.com/burpee_avanzado', 8, 2, '2025-06-20'),
('Escaladores rápidos', 'Versión rápida de mountain climbers', 'https://video.com/escaladores_rapidos', 6, 2, '2025-06-20'),
('Sentadilla búlgara', 'Pierna trasera sobre silla', 'https://video.com/sentadilla_bulgara', 7, 2, '2025-06-20'),

-- Ejercicios para "Gym-Principiente" (id_rutina = 2)
('Extensiones de piernas', 'Máquina para fortalecer cuádriceps', 'https://video.com/extensiones', 6, 3, '2025-06-20'),
('Curl de bíceps con mancuerna', 'Ejercicio básico de brazo', 'https://video.com/curl_biceps', 6, 3, '2025-06-20'),
('Prensa de pecho', 'Máquina para pectorales', 'https://video.com/prensa_pecho', 5, 3, '2025-06-20'),

-- Ejercicios para "Gym-Intermedio" (id_rutina = 2)
('Press militar', 'Con barra o mancuernas, para hombros', 'https://video.com/press_militar', 8, 3, '2025-06-20'),
('Remo en máquina', 'Remo sentado con agarre cerrado', 'https://video.com/remo_maquina', 7, 3, '2025-06-20'),
('Abdominales en banco declinado', 'Más intensidad para abdomen', 'https://video.com/abd_declinado', 5, 3, '2025-06-20'),

-- Ejercicios para "Gym-Avanzado" (id_rutina = 2)
('Peso muerto con barra', 'Levantamiento desde el suelo', 'https://video.com/peso_muerto', 10, 3, '2025-06-20'),
('Sentadilla frontal', 'Versión avanzada de sentadilla con barra', 'https://video.com/sentadilla_frontal', 8, 3, '2025-06-20'),
('Dominadas con peso', 'Añade peso extra', 'https://video.com/dominadas_peso', 7, 3, '2025-06-20'),

-- Ejercicios para "Calistenia-Principiente" (id_rutina = 3)
('Flexiones de rodillas', 'Flexiones apoyando las rodillas', 'https://video.com/flexion_rodilla', 5, 4, '2025-06-20'),
('Puente de glúteos', 'Desde el suelo, levantar cadera', 'https://video.com/puente', 6, 4, '2025-06-20'),
('Bird dog', 'Estabilidad core', 'https://video.com/birddog', 5, 4, '2025-06-20'),

-- Ejercicios para "Calistenia-Intermedio" (id_rutina = 3)
('Pull-ups asistidos', 'Dominadas con ayuda de banda', 'https://video.com/pullup_banda', 6, 4, '2025-06-20'),
('Fondos en banco', 'Ejercicio de tríceps usando banco', 'https://video.com/fondos_banco', 6, 4, '2025-06-20'),
('Sentadillas a una pierna', 'Sin ayuda', 'https://video.com/pistol', 7, 4, '2025-06-20'),

-- Ejercicios para "Calistenia-Avanzado" (id_rutina = 3)
('Muscle-ups', 'Pull-up + fondos, nivel experto', 'https://video.com/muscleup', 8, 4, '2025-06-20'),
('Planche', 'Ejercicio avanzado de fuerza total', 'https://video.com/planche', 5, 4, '2025-06-20'),
('Front lever', 'Isométrico difícil de mantener', 'https://video.com/frontlever', 6, 4, '2025-06-20'),

('Ejercicio Camila 1', 'Descripción ejercicio 1', 'https://video.com/camila1', 6, 1, '2025-07-04'),
('Ejercicio Camila 2', 'Descripción ejercicio 2', 'https://video.com/camila2', 7, 1, '2025-07-04'),
('Ejercicio Camila 3', 'Descripción ejercicio 3', 'https://video.com/camila3', 8, 1, '2025-07-04'),
('Ejercicio Camila 4', 'Descripción ejercicio 4', 'https://video.com/camila4', 9, 1, '2025-07-04'),
('Ejercicio Camila 5', 'Descripción ejercicio 5', 'https://video.com/camila5', 10, 1, '2025-07-04'),

('Ejercicio Felipe González 1', 'Descripción ejercicio 1', 'https://video.com/felipegonzalez1', 6, 1, '2025-07-04'),
('Ejercicio Felipe González 2', 'Descripción ejercicio 2', 'https://video.com/felipegonzalez2', 7, 1, '2025-07-04'),
('Ejercicio Felipe González 3', 'Descripción ejercicio 3', 'https://video.com/felipegonzalez3', 8, 1, '2025-07-04'),

('Ejercicio Valeria Sánchez 1', 'Descripción ejercicio 1', 'https://video.com/valeriasanchez1', 6, 1, '2025-07-04'),
('Ejercicio Valeria Sánchez 2', 'Descripción ejercicio 2', 'https://video.com/valeriasanchez2', 7, 1, '2025-07-04'),

('Ejercicio Juan Ramírez 1', 'Descripción ejercicio 1', 'https://video.com/juanramirez1', 6, 1, '2025-07-04'),
('Ejercicio Juan Ramírez 2', 'Descripción ejercicio 2', 'https://video.com/juanramirez2', 7, 1, '2025-07-04');

INSERT INTO planes_dieta (nombre_dieta, descripcion, calorias_aprox, tipo, creador_id)
VALUES
('Dieta Mediterránea', 'Alta en grasas saludables y vegetales', 2100, 'Balanceada', 3),
('Dieta Detox', 'Basada en jugos y líquidos', 1200, 'Hipocalórica', 1),
('Dieta Paleo', 'Basada en alimentos naturales sin procesar', 2300, 'Hipercalórica', 2),
('Dieta Sin Gluten', 'Elimina el gluten de la alimentación', 1900, 'Balanceada', 3),
('Dieta Alta en Fibra', 'Aumenta el consumo de fibra diaria', 1800, 'Hipocalórica', 1),
('Dieta para Definición', 'Baja en carbohidratos y grasas', 1700, 'Hipocalórica', 2),
('Dieta Vegana', '100% basada en plantas', 2000, 'Balanceada', 3),
('Dieta Keto Básica', 'Baja en carbohidratos, alta en grasas saludables', 1800, 'Hipocalórica', 1),
('Dieta Vegetariana Balanceada', 'Alta en vegetales y proteínas vegetales', 2000, 'Balanceada', 3),
('Dieta Proteica', 'Alta en proteínas para ganar masa muscular', 2200, 'Hipercalórica', 2),
('Dieta Camila 1', 'Dieta personalizada 1', 1900, 'Balanceada', 11),
('Dieta Camila 2', 'Dieta personalizada 2', 2000, 'Balanceada', 11),
('Dieta Camila 3', 'Dieta personalizada 3', 2100, 'Balanceada', 11),
('Dieta Felipe González 1', 'Dieta personalizada para Felipe González', 1800, 'Balanceada', 12),
('Dieta Felipe González 2', 'Dieta personalizada para Felipe González', 1900, 'Balanceada', 12),
('Dieta Valeria Sánchez 1', 'Dieta personalizada para Valeria Sánchez', 1800, 'Balanceada', 13),
('Dieta Juan Ramírez 1', 'Dieta personalizada para Juan Ramírez', 1800, 'Balanceada', 14);

INSERT INTO progreso_usuario (id_usuario, fecha_registro, peso_actual, grasa_corporal, masa_muscular, observaciones, imagen_url, id_entrenador)
VALUES
-- Ana Torres (id = 1)
(1, '2025-05-20', 61.8, 22.0, 35.5, 'Buen avance, se siente fuerte', 'progreso_ana_mayo.jpg', 2),
(1, '2025-06-01', 61.0, 21.5, 36.0, 'Notable mejora en definición', 'progreso_ana_junio.jpg',2),

-- Sandra Ruiz (id = 3)
(3, '2025-06-01', 64.0, 23.5, 34.0, 'Estable, mantener progreso', 'progreso_sandra_junio.jpg',2),

-- José Morales (id = 4)
(4, '2025-06-01', 75.0, 21.0, 36.5, 'Buena condición física', 'progreso_jose.jpg',8),

-- Andrea Cifuentes (id = 5)
(5, '2025-06-02', 51.5, 20.8, 32.0, 'Se siente con más energía', 'progreso_andrea.jpg',2),

-- Ana Torres (id = 7)
(7, '2025-06-04', 62.0, 21.5, 36.2, 'Marcando más el abdomen', 'progreso_ana_junio_extra.jpg',6),

-- Lucía Pérez (id = 9)
(9, '2025-06-05', 55.0, 19.0, 32.5, 'Más resistencia física', 'progreso_lucia.jpg',6),

-- Diego Ríos (id = 10)
(10, '2025-06-06', 82.2, 22.0, 37.0, 'Mantuvo nivel muscular', 'progreso_diego.jpg',8),

-- 
(11, '2025-07-03', 58.0, 21.0, 34.0, 'Excelente evolución, mejoró fuerza y resistencia', 'camila_progreso.jpg', 2),

--
(12, '2025-07-03', 82.0, 22.5, 36.5, 'Aún necesita trabajar la resistencia cardiovascular', 'felipe_progreso.jpg', 6),

--
(13, '2025-07-04', 53.8, 20.0, 33.0, 'Muy disciplinada, buenos hábitos de alimentación', 'valeria_progreso.jpg', 6),

--
(14, '2025-07-04', 87.0, 21.5, 37.5, 'Gran esfuerzo, aumentó masa muscular', 'juan_progreso.jpg', 2);

INSERT INTO publicaciones (id_usuario, contenido, imagen_url)
VALUES
(1, '¡Completé mi primera rutina!', 'progreso1.jpg'),
(2, 'Día 5 de la dieta keto y me siento genial.', 'foto_dieta.jpg'),
(3, '¿Alguien más hace calistenia por las mañanas?', NULL),
(4, 'Les comparto mi progreso de esta semana', 'semana4.jpg');

INSERT INTO comentarios (id_usuario, id_publicacion, contenido) VALUES
(2, 1, '¡Felicidades Ana! Sigue así, vas muy bien.'),
(3, 1, 'Me inspiras a empezar también. ¿Qué rutina seguiste?'),
(1, 2, 'La dieta keto es genial, yo también la estoy siguiendo.'),
(4, 2, '¿Tienes algún consejo para los primeros días?'),
(1, 3, 'Sí, yo hago calistenia por las tardes. Es increíble.'),
(2, 4, 'Excelente progreso Diego, se nota el esfuerzo.');

INSERT INTO rol_usuarios (rol, descripcion) VALUES
('Usuario', 'Usuario regular de la aplicación'),
('Entrenador', 'Profesional del fitness que puede crear rutinas'),
('Administrador', 'Administrador del sistema'),
('Nutricionista', 'Especialista en nutrición que puede crear dietas');

INSERT INTO usuario_rol (id_usuario, id_rol) VALUES
(1, 1),  -- Laura Gómez → Usuario
(2, 2),  -- Pedro Salazar → Entrenador
(3, 1),  -- Sandra Ruiz → Usuario
(4, 3),  -- José Morales → Administrador
(5, 1),  -- Andrea Cifuentes → Usuario
(6, 2),  -- David Blanco → Entrenador
(7, 1),  -- Ana Torres → Usuario
(8, 2),  -- Carlos Méndez → Entrenador
(9, 1),  -- Lucía Pérez → Usuario
(10, 3), -- Diego Ríos → Administrador
(11, 1),
(12, 1),
(13, 1),
(14, 1);

INSERT INTO ejecucion_rutina (numero_serie, numero_repeticiones, peso_utilizado, id_ejercicio, id_rutina, id_usuario) VALUES
-- José (id_usuario = 4) ejecutando rutina "Cardio Intenso" (id_rutina = 2)
(3, 12, 0.00, 7, 2, 4), -- Burpees
(3, 15, 0.00, 8, 2, 4), -- Escaladores rápidos
(2, 10, 0.00, 9, 2, 4), -- Sentadilla búlgara

-- Andrea (id_usuario = 5) ejecutando rutina "Full Body en Casa" (id_rutina = 1)
(3, 12, 0.00, 1, 1, 5), -- Marcha en el lugar
(3, 12, 0.00, 2, 1, 5), -- Elevación de rodillas
(2, 30, 0.00, 3, 1, 5), -- Flexiones pared

-- David (id_usuario = 6) ejecutando rutina "Pesas para Principiantes" (id_rutina = 3)
(4, 10, 40.00, 10, 3, 6), -- Curl bíceps
(3, 10, 50.00, 11, 3, 6), -- Prensa de pecho
(3, 8, 70.00, 12, 3, 6),  -- Press militar

-- Ana (id_usuario = 7) ejecutando rutina "Cardio Intenso" (id_rutina = 2)
(3, 12, 0.00, 7, 2, 7),
(2, 20, 0.00, 8, 2, 7),
(2, 10, 0.00, 9, 2, 7),

-- Carlos (id_usuario = 8) ejecutando rutina "Pesas para Principiantes" (id_rutina = 3)
(3, 8, 60.00, 9, 3, 8),
(3, 10, 70.00, 10, 3, 8),
(3, 5, 90.00, 11, 3, 8),

-- Lucía (id_usuario = 9) ejecutando rutina "Calistenia Nivel 1" (id_rutina = 4)
(3, 8, 0.00, 13, 4, 9),
(2, 10, 0.00, 14, 4, 9),
(2, 4, 0.00, 15, 4, 9),

-- Diego (id_usuario = 10) ejecutando rutina "Calistenia Nivel 1" (id_rutina = 4)
(3, 10, 0.00, 13, 4, 10),
(3, 12, 0.00, 14, 4, 10),
(2, 5, 0.00, 15, 4, 10),

-- Ana ejecutando rutina Full Body
(3, 10, 0.00, 1, 1, 1), -- Flexiones
(3, 15, 0.00, 2, 1, 1), -- Sentadillas
(1, 30, 0.00, 3, 1, 1), -- Plancha (30 segundos)
(3, 8, 0.00, 4, 1, 1),  -- Burpees

-- Carlos ejecutando rutina de Pesas
(4, 8, 60.00, 9, 3, 2),  -- Press de banca
(4, 10, 80.00, 10, 3, 2), -- Sentadilla con barra
(3, 5, 100.00, 11, 3, 2), -- Peso muerto
(3, 8, 50.00, 12, 3, 2),  -- Remo con barra

-- Lucía ejecutando Calistenia
(3, 5, 0.00, 13, 4, 3),  -- Pull-ups
(3, 8, 0.00, 14, 4, 3),  -- Dips
(2, 3, 0.00, 15, 4, 3),  -- Pistol Squats
(2, 20, 0.00, 16, 4, 3), -- L-Sit (20 segundos)

-- Camila (id = 11)
(3, 10, 0.00, 1, 1, 11),
(2, 12, 0.00, 2, 1, 11),
(3, 8, 0.00, 3, 1, 11),
(2, 15, 0.00, 4, 1, 11),
(1, 30, 0.00, 5, 1, 11),

-- Felipe (id = 12)
(3, 10, 50.00, 10, 3, 12),
(3, 12, 60.00, 11, 3, 12),
(2, 8, 80.00, 12, 3, 12),

-- Valeria (id = 13)
(3, 10, 0.00, 1, 1, 13),
(3, 10, 0.00, 2, 1, 13),

-- Juan (id = 14)
(3, 12, 60.00, 10, 3, 14),
(3, 10, 80.00, 11, 3, 14);

INSERT INTO logros (id_usuario, id_ejecucion, nombre_logro, descripcion, numero_serie, numero_repeticiones, peso_utilizado) VALUES
(1, 1, 'Primera rutina completada', 'Completó su primera rutina de ejercicios', 3, 10, 0.00),
(1, 3, 'Plancha de 30 segundos', 'Logró mantener plancha por 30 segundos', 1, 30, 0.00),
(2, 7, 'Peso muerto 100kg', 'Alcanzó los 100kg en peso muerto', 3, 5, 100.00),
(3, 9, 'Primeras dominadas', 'Completó sus primeras 5 dominadas', 3, 5, 0.00),
(4, 5, 'Sentadilla con 80kg', 'Logró sentadilla con 80kg de peso', 4, 10, 80.00);