from pydantic import BaseModel

class UsuarioBase(BaseModel):
    nombre: str
    correo_electronico: str
    contrasena: str
    id_objetivo: int | None = None

class UsuarioCreate(UsuarioBase):
    pass

class Usuario(UsuarioBase):
    id_usuario: int

    class Config:
        orm_mode = True
