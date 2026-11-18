-- Prueba A: Consultar el avance combinado (valida los JOIN y el campo JSON)
SELECT 
    u.nombre AS estudiante,
    m.titulo AS modulo,
    p.puntaje_obtenido,
    p.completado,
    pr.opciones_json
FROM progreso p
JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN modulo m ON p.id_modulo = m.id_modulo
JOIN evaluacion e ON m.id_modulo = e.id_modulo
JOIN pregunta pr ON e.id_evaluacion = pr.id_evaluacion;

-- Prueba B: Validar seguridad de reglas (DEBE DAR ERROR)
-- Si intenta insertar un rol distinto a 'estudiante' o 'administrador', el CHECK lo bloqueará:
INSERT INTO usuario (nombre, email, password_hash, rol) 
VALUES ('Intruso', 'hack@ejemplo.com', '123', 'superusuario');