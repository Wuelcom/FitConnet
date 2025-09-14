# app/models/user.py
"""
Modelo User (usuarios).
Campos típicos: id, nombre, email, hashed_password, fecha_creacion, role_id (FK)
"""
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from app.database import Base

class User(Base):
    __tablename__ = "usuarios"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(120), nullable=False)
    email = Column(String(150), unique=True, nullable=False, index=True)
    hashed_password = Column(String(255), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    role_id = Column(Integer, ForeignKey("roles.id"), nullable=True)
    role = relationship("Role", back_populates="users")

    # relaciones
    progress = relationship("Progreso", back_populates="user", cascade="all, delete-orphan")
    achievements = relationship("Logro", back_populates="user", cascade="all, delete-orphan")
