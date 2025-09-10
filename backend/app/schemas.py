from pydantic import BaseModel

class UserBase(BaseModel):
    nombre: str
    correo_electronico: str
    rol: str

class UserCreate(UserBase):
    contrasena: str

class UserOut(UserBase):
    id_usuario: int

    class Config:
        orm_mode = True
