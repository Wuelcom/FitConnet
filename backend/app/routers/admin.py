# backend/app/routers/admin.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database import get_db
from app import schemas, models 
from datetime import datetime, timedelta
from passlib.context import CryptContext

# Configurar encriptación de passwords
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Definir router con prefijo /admin y tags
router = APIRouter(prefix="/admin", tags=["Administrador"])

# ======================================================
# ✅ GESTIÓN DE USUARIOS
# ======================================================

@router.get("/usuarios", summary="Listar usuarios")
def listar_usuarios(db: Session = Depends(get_db)):
    return db.query(models.Usuario).all()

@router.post("/usuarios", status_code=status.HTTP_201_CREATED, summary="Crear usuario")
def crear_usuario(usuario: schemas.UsuarioOut, db: Session = Depends(get_db)):
    hashed_password = pwd_context.hash(usuario.password)
    nuevo_usuario = models.Usuario(
        nombre=usuario.nombre,
        email=usuario.email,
        password=hashed_password,
        rol_id=usuario.rol_id
    )
    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)
    return nuevo_usuario

@router.put("/usuarios/{usuario_id}", summary="Actualizar usuario")
def actualizar_usuario(usuario_id: int, usuario: schemas.UsuarioUpdate, db: Session = Depends(get_db)):
    usuario_db = db.query(models.Usuario).filter(models.Usuario.id_usuario == usuario_id).first()
    if not usuario_db:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    
    data = usuario.dict(exclude_unset=True)
    if "password" in data:
        data["password"] = pwd_context.hash(data["password"])
    
    for key, value in data.items():
        setattr(usuario_db, key, value)
    
    db.commit()
    db.refresh(usuario_db)
    return usuario_db

@router.delete("/usuarios/{usuario_id}", status_code=status.HTTP_204_NO_CONTENT, summary="Eliminar usuario")
def eliminar_usuario(usuario_id: int, db: Session = Depends(get_db)):
    usuario_db = db.query(models.Usuario).filter(models.Usuario.id_usuario == usuario_id).first()
    if not usuario_db:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    db.delete(usuario_db)
    db.commit()
    return {"detail": "Usuario eliminado con éxito"}


# ======================================================
# ✅ GESTIÓN DE RUTINAS / PLANES
# ======================================================

@router.get("/rutinas", summary="Listar rutinas")
def listar_rutinas(db: Session = Depends(get_db)):
    return db.query(models.Rutina).all()

@router.post("/rutinas", summary="Crear rutina")
def crear_rutina(rutina: schemas.RutinaCreate, db: Session = Depends(get_db)):
    nueva_rutina = models.Rutina(**rutina.dict())
    db.add(nueva_rutina)
    db.commit()
    db.refresh(nueva_rutina)
    return nueva_rutina

@router.put("/rutinas/{rutina_id}", summary="Actualizar rutina")
def actualizar_rutina(rutina_id: int, rutina: schemas.RutinaUpdate, db: Session = Depends(get_db)):
    rutina_db = db.query(models.Rutina).filter(models.Rutina.id_rutina == rutina_id).first()
    if not rutina_db:
        raise HTTPException(status_code=404, detail="Rutina no encontrada")
    for key, value in rutina.dict(exclude_unset=True).items():
        setattr(rutina_db, key, value)
    db.commit()
    db.refresh(rutina_db)
    return rutina_db

@router.delete("/rutinas/{rutina_id}", status_code=status.HTTP_204_NO_CONTENT, summary="Eliminar rutina")
def eliminar_rutina(rutina_id: int, db: Session = Depends(get_db)):
    rutina_db = db.query(models.Rutina).filter(models.Rutina.id_rutina == rutina_id).first()
    if not rutina_db:
        raise HTTPException(status_code=404, detail="Rutina no encontrada")
    db.delete(rutina_db)
    db.commit()
    return {"detail": "Rutina eliminada"}


# ======================================================
# ✅ GESTIÓN DE ROLES / PERMISOS
# ======================================================

@router.get("/roles", summary="Listar roles")
def listar_roles(db: Session = Depends(get_db)):
    return db.query(models.RolUsuario).all()

@router.post("/roles", summary="Crear rol")
def crear_rol(rol: schemas.RolCreate, db: Session = Depends(get_db)):
    nuevo_rol = models.RolUsuario(**rol.dict())
    db.add(nuevo_rol)
    db.commit()
    db.refresh(nuevo_rol)
    return nuevo_rol


# ======================================================
# ✅ REPORTES
# ======================================================

@router.get("/reportes/actividad", summary="Reporte de actividad")
def reporte_actividad(db: Session = Depends(get_db)):
    total_usuarios = db.query(models.Usuario).count()
    total_rutinas = db.query(models.Rutina).count()
    total_publicaciones = db.query(models.Publicacion).count()
    return {
        "total_usuarios": total_usuarios,
        "total_rutinas": total_rutinas,
        "total_publicaciones": total_publicaciones
    }

@router.get("/reportes/usuarios-activos", summary="Reporte de usuarios activos")
def usuarios_activos(db: Session = Depends(get_db)):
    limite = datetime.now() - timedelta(days=30)
    activos = db.query(models.Usuario).join(models.ProgresoUsuario).filter(models.ProgresoUsuario.fecha_registro >= limite).all()
    return {"usuarios_activos": len(activos), "detalle": activos}
