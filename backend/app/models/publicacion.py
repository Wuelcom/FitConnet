# app/models/publicacion.py
"""
Modelo Publicacion (posts).
"""
from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from app.database import Base

class Publicacion(Base):
    __tablename__ = "publicaciones"
    id = Column(Integer, primary_key=True, index=True)
    titulo = Column(String(200), nullable=False)
    contenido = Column(Text, nullable=True)
    fecha = Column(DateTime(timezone=True), server_default=func.now())
    user_id = Column(Integer, ForeignKey("usuarios.id"), nullable=True)
