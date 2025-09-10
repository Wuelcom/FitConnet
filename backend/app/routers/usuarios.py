from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from app.database import get_db
from app.models import Usuario

router = APIRouter(prefix="/usuarios", tags=["Usuarios"])

class UsuarioCreate(BaseModel):
    nombre: str
    correo_electronico: str
    contrasena: str
    rol: str = "user"

class UsuarioUpdate(BaseModel):
    nombre: str | None = None
    correo_electronico: str | None = None
    contrasena: str | None = None
    rol: str | None = None

class LoginRequest(BaseModel):
    nombre: str
    contrasena: str

@router.post("/register")
def registrar(usuario: UsuarioCreate, db: Session = Depends(get_db)):
    existe = db.query(Usuario).filter(Usuario.nombre == usuario.nombre).first()
    if existe:
        raise HTTPException(status_code=400, detail="El usuario ya existe")

    nuevo = Usuario(
        nombre=usuario.nombre,
        correo_electronico=usuario.correo_electronico,
        contrasena=usuario.contrasena,
        rol=usuario.rol
    )
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return {"message": "Usuario registrado", "usuario": nuevo.nombre}

@router.post("/login")
def login(data: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(Usuario).filter(Usuario.nombre == data.nombre).first()
    if not user or user.contrasena != data.contrasena:
        raise HTTPException(status_code=401, detail="Usuario o contraseña incorrectos")
    return {"id_usuario": user.id_usuario, "nombre": user.nombre, "rol": user.rol}

@router.get("/")
def listar_usuarios(db: Session = Depends(get_db)):
    return db.query(Usuario).all()

@router.put("/{id_usuario}")
def actualizar_usuario(id_usuario: int, data: UsuarioUpdate, db: Session = Depends(get_db)):
    user = db.query(Usuario).filter(Usuario.id_usuario == id_usuario).first()
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    if data.nombre: user.nombre = data.nombre
    if data.correo_electronico: user.correo_electronico = data.correo_electronico
    if data.contrasena: user.contrasena = data.contrasena
    if data.rol: user.rol = data.rol

    db.commit()
    db.refresh(user)
    return {"message": "Usuario actualizado"}

@router.delete("/{id_usuario}")
def eliminar_usuario(id_usuario: int, db: Session = Depends(get_db)):
    user = db.query(Usuario).filter(Usuario.id_usuario == id_usuario).first()
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    db.delete(user)
    db.commit()
    return {"message": "Usuario eliminado"}
