# app/models.py
from sqlalchemy import Column, Integer, String, Text, ForeignKey, Float, DateTime, Date
from sqlalchemy.orm import relationship
from app.database import Base
from datetime import datetime

# =========================
# USUARIO
# =========================
class Usuario(Base):
    __tablename__ = "usuarios"

    id_usuario = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    password = Column(String(128), nullable=False)
    rol_id = Column(Integer, ForeignKey("roles.id_rol"), nullable=True)

    rol = relationship("RolUsuario", back_populates="usuarios")
    progresos = relationship("ProgresoUsuario", back_populates="usuario")
    publicaciones = relationship("Publicacion", back_populates="usuario")
    objetivos = relationship("Objetivo", back_populates="usuario")

# =========================
# ROL
# =========================
class RolUsuario(Base):
    __tablename__ = "roles"

    id_rol = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(50), nullable=False)

    usuarios = relationship("Usuario", back_populates="rol")

# =========================
# RUTINA
# =========================
class Rutina(Base):
    __tablename__ = "rutinas"

    id_rutina = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    descripcion = Column(Text, nullable=True)

# =========================
# EJERCICIO
# =========================
class Ejercicio(Base):
    __tablename__ = "ejercicios"

    id_ejercicio = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    descripcion = Column(Text, nullable=True)
    duracion_minutos = Column(Integer, nullable=True)

# =========================
# LOGRO
# =========================
class Logro(Base):
    __tablename__ = "logros"

    id_logro = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    descripcion = Column(Text, nullable=True)

# =========================
# DIETA
# =========================
class Dieta(Base):
    __tablename__ = "dietas"

    id_dieta = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    descripcion = Column(Text, nullable=True)

# =========================
# PROGRESO
# =========================
class ProgresoUsuario(Base):
    __tablename__ = "progresos"

    id_progreso = Column(Integer, primary_key=True, index=True)
    usuario_id = Column(Integer, ForeignKey("usuarios.id_usuario"), nullable=False)
    fecha_registro = Column(DateTime, default=datetime.utcnow)
    peso_kg = Column(Float, nullable=True)
    altura_cm = Column(Float, nullable=True)

    usuario = relationship("Usuario", back_populates="progresos")

# =========================
# PUBLICACION
# =========================
class Publicacion(Base):
    __tablename__ = "publicaciones"

    id_publicacion = Column(Integer, primary_key=True, index=True)
    usuario_id = Column(Integer, ForeignKey("usuarios.id_usuario"), nullable=False)
    contenido = Column(Text, nullable=False)
    fecha = Column(DateTime, default=datetime.utcnow)

    usuario = relationship("Usuario", back_populates="publicaciones")

# =========================
# OBJETIVO
# =========================
class Objetivo(Base):
    __tablename__ = "objetivos"

    id_objetivo = Column(Integer, primary_key=True, index=True)
    usuario_id = Column(Integer, ForeignKey("usuarios.id_usuario"), nullable=False)
    descripcion = Column(Text, nullable=False)
    fecha_inicio = Column(Date, nullable=False)
    fecha_fin = Column(Date, nullable=True)

    usuario = relationship("Usuario", back_populates="objetivos")
