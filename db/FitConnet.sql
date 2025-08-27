CREATE DATABASE IF NOT EXISTS FitConnet;
USE FitConnet;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('usuario','administrador') DEFAULT 'usuario'
);