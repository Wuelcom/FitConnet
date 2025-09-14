# app/models/rutina.py
"""
Modelo Rutina.
"""
from sqlalchemy import Column, Integer, String, Text, ForeignKey
from sqlalchemy.orm import relationship
from app.database import Base

class Rutina(Base):
    __tablename__ = "rutinas"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(150), nullable=False)
    descripcion = Column(Text, nullable=True)
    nivel = Column(String(50), nullable=True)
