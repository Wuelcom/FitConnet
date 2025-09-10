from sqlalchemy import Column, Integer, String
from .database import Base

class User(Base):
    __tablename__ = "usuarios"

    id_usuario = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    correo_electronico = Column(String(100), unique=True, index=True)
    contrasena = Column(String(255), nullable=False)
    rol = Column(String(50), default="usuario")
