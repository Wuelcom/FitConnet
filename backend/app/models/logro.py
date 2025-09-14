# app/models/logro.py
"""
Modelo Logro (achievements).
Relaciona con usuario.
"""
from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database import Base

class Logro(Base):
    __tablename__ = "logros"
    id = Column(Integer, primary_key=True, index=True)
    titulo = Column(String(150), nullable=False)
    descripcion = Column(String(255), nullable=True)
    fecha = Column(DateTime(timezone=True), server_default=func.now())
    user_id = Column(Integer, ForeignKey("usuarios.id"), nullable=False)

    user = relationship("User", back_populates="achievements")
