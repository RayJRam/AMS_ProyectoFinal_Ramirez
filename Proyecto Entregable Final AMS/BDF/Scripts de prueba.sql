-- 1. Insertar usuarios de prueba
INSERT INTO usuario (nombre, email, password_hash, rol) VALUES 
('Ana López', 'ana@ejemplo.com', 'hash_seguro_123', 'estudiante'),
('Carlos Admin', 'admin@ejemplo.com', 'hash_admin_456', 'administrador');

-- 2. Insertar los 3 módulos mínimos
INSERT INTO modulo (titulo, descripcion, orden) VALUES 
('Fundamentos y Ética de la IAG', 'Conceptos clave, sesgos y transparencia UX.', 1),
('Normatividad y Privacidad', 'Leyes de datos y prevención de fugas en prompts.', 2),
('Tips de Aplicación Práctica', 'Prompt engineering ético y etiquetado.', 3);

-- 3. Insertar una lección en el Módulo 1
INSERT INTO leccion (id_modulo, titulo, contenido_markdown, duracion_min, orden) VALUES 
(1, '¿Qué es la transparencia en UX?', '## Regla básica\nSiempre avisa al usuario cuando interactúa con IA.', 4, 1);

-- 4. Crear la evaluación del Módulo 1 y una pregunta con opciones en JSON
INSERT INTO evaluacion (id_modulo, puntaje_minimo) VALUES (1, 80);

INSERT INTO pregunta (id_evaluacion, enunciado, opciones_json, respuesta_correcta) VALUES 
(1, '¿Qué debes hacer al mostrar texto generado por IA en tu web?', 
 '["Ocultarlo", "Etiquetarlo visualmente como IA", "Pedir contraseña"]', 1);

-- 5. Registrar avance del estudiante
INSERT INTO progreso (id_usuario, id_modulo, completado, puntaje_obtenido) VALUES 
(1, 1, TRUE, 100);