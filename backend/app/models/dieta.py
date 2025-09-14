# app/models/dieta.py
"""
Modelo Dieta (planes_dieta).
"""
from sqlalchemy import Column, Integer, String, Text
from app.database import Base

class Dieta(Base):
    __tablename__ = "dietas"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(150), nullable=False)
    descripcion = Column(Text, nullable=True)
    calorias = Column(Integer, nullable=True)
