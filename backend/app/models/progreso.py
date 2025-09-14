# app/models/progreso.py
"""
Modelo Progreso (datos de progreso físico por usuario).
"""
from sqlalchemy import Column, Integer, Float, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from app.database import Base

class Progreso(Base):
    __tablename__ = "progreso"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("usuarios.id"), nullable=False)
    peso = Column(Float, nullable=True)
    imc = Column(Float, nullable=True)
    fecha = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", back_populates="progress")
