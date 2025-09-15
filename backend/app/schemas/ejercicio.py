# app/schemas/ejercicio.py
from pydantic import BaseModel
from typing import Optional

class EjercicioBase(BaseModel):
    nombre: str
    tipo: Optional[str] = None
    descripcion: Optional[str] = None

class EjercicioCreate(EjercicioBase):
    pass

class EjercicioUpdate(EjercicioBase):
    pass

class EjercicioOut(EjercicioBase):
    id: int
    class Config:
        from_attributes = True
