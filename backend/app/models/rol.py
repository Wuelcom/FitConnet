# app/models/role.py
"""
Modelo Role (roles de usuario).
"""
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from .database import Base

class Role(Base):
    __tablename__ = "roles"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(50), unique=True, nullable=False)
    descripcion = Column(String(255), nullable=True)

    users = relationship("User", back_populates="role")
