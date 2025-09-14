# app/models/ejercicio.py
"""
Modelo Ejercicio.
"""
from sqlalchemy import Column, Integer, String, Text
from app.database import Base

class Ejercicio(Base):
    __tablename__ = "ejercicios"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(150), nullable=False)
    tipo = Column(String(80), nullable=True)  # e.g., fuerza, cardio
    descripcion = Column(Text, nullable=True)
