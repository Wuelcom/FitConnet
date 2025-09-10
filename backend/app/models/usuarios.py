from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from app.database import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    id_usuario = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    correo_electronico = Column(String(100), unique=True, nullable=False)
    contrasena = Column(String(255), nullable=False)
    fecha_registro = Column(TIMESTAMP)
    id_objetivo = Column(Integer, ForeignKey("objetivos.id_objetivo"))
