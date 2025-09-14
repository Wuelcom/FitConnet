# app/models/objetivo.py
"""
Modelo Objetivo.
"""
from sqlalchemy import Column, Integer, String, Text
from app.database import Base

class Objetivo(Base):
    __tablename__ = "objetivos"
    id = Column(Integer, primary_key=True, index=True)
    descripcion = Column(String(255), nullable=False)
    tipo = Column(String(80), nullable=True)  # e.g., perder peso, ganar masa
