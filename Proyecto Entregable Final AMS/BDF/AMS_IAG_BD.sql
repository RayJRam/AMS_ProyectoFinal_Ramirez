-- Base de datos: AMS_IAG_BD
-- Script para MySQL 8.0
-- Ejecutar el archivo completo desde MySQL Workbench.

CREATE DATABASE IF NOT EXISTS AMS_IAG_BD
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE AMS_IAG_BD;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('estudiante', 'administrador')),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

) ENGINE=InnoDB;

CREATE TABLE modulo (
    id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    descripcion TEXT NOT NULL,
    orden INT NOT NULL UNIQUE

) ENGINE=InnoDB;

CREATE TABLE leccion (
    id_leccion INT AUTO_INCREMENT PRIMARY KEY,
    id_modulo INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    contenido_markdown TEXT NOT NULL,
    duracion_min INT NOT NULL DEFAULT 3,
    orden INT NOT NULL,
    CONSTRAINT fk_leccion_modulo FOREIGN KEY (id_modulo) 
        REFERENCES modulo(id_modulo) ON DELETE CASCADE

) ENGINE=InnoDB;

CREATE TABLE evaluacion (
    id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    id_modulo INT NOT NULL UNIQUE,
    puntaje_minimo INT NOT NULL DEFAULT 80,
    CONSTRAINT fk_eval_modulo FOREIGN KEY (id_modulo) 
        REFERENCES modulo(id_modulo) ON DELETE CASCADE

) ENGINE=InnoDB;

CREATE TABLE pregunta (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_evaluacion INT NOT NULL,
    enunciado TEXT NOT NULL,
    opciones_json JSON NOT NULL,
    respuesta_correcta INT NOT NULL,
    CONSTRAINT fk_pregunta_eval FOREIGN KEY (id_evaluacion) 
        REFERENCES evaluacion(id_evaluacion) ON DELETE CASCADE

) ENGINE=InnoDB;

CREATE TABLE progreso (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_modulo INT NOT NULL,
    completado BOOLEAN NOT NULL DEFAULT FALSE,
    puntaje_obtenido INT DEFAULT 0,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_usuario_modulo UNIQUE (id_usuario, id_modulo),
    CONSTRAINT fk_progreso_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_progreso_modulo FOREIGN KEY (id_modulo) 
        REFERENCES modulo(id_modulo) ON DELETE CASCADE

) ENGINE=InnoDB;

CREATE TABLE certificado (
    id_certificado INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    codigo_verificacion VARCHAR(64) NOT NULL UNIQUE,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cert_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario) ON DELETE CASCADE

) ENGINE=InnoDB;

-- Índices para optimizar consultas de lectura y seguimiento
CREATE INDEX idx_leccion_modulo ON leccion(id_modulo, orden);
CREATE INDEX idx_progreso_usuario ON progreso(id_usuario);