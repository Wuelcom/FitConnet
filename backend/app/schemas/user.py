# app/schemas/user.py
"""
Schemas Pydantic para User (entrada y salida).
"""
from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import datetime, date

class UserBase(BaseModel):
    nombre: str
    correo_electronico: str
    telefono: Optional[str] = None
    fecha_nacimiento: Optional[date] = None

class UserCreate(UserBase):
    password: str
    id_objetivo: Optional[int] = None

class UserResponse(UserBase):
    id_usuario: int
    fecha_registro: datetime

    class Config:
        orm_mode = True

class UserUpdate(BaseModel):
    nombre: Optional[str] = None
    email: Optional[EmailStr] = None
    password: Optional[str] = None
    role_id: Optional[int] = None

class UserOut(UserBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True
