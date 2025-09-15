# backend/app/main.py
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from app.database import engine, Base
from app.config import API_PREFIX
from app.routers import (
    user,
    rol,
    rutina,
    ejercicio,
    logro,
    dieta,
    progreso,
    publicacion,
    objetivo,
    auth,
    admin
)

# ======================================================
# Crear todas las tablas (útil en desarrollo)
# ======================================================
Base.metadata.create_all(bind=engine)

# ======================================================
# Inicializar FastAPI
# ======================================================
app = FastAPI(title="FitConnet API")

# ======================================================
# Montar carpeta estática (si la creas más adelante)
# ======================================================
# app.mount("/static", StaticFiles(directory="app/static"), name="static")

# ======================================================
# Registrar routers
# ======================================================
app.include_router(user.router, prefix=f"{API_PREFIX}/users", tags=["Usuarios"])
app.include_router(rol.router, prefix=f"{API_PREFIX}/roles", tags=["Roles"])
app.include_router(rutina.router, prefix=f"{API_PREFIX}/rutinas", tags=["Rutinas"])
app.include_router(ejercicio.router, prefix=f"{API_PREFIX}/ejercicios", tags=["Ejercicios"])
app.include_router(logro.router, prefix=f"{API_PREFIX}/logros", tags=["Logros"])
app.include_router(dieta.router, prefix=f"{API_PREFIX}/dietas", tags=["Dietas"])
app.include_router(progreso.router, prefix=f"{API_PREFIX}/progresos", tags=["Progresos"])
app.include_router(publicacion.router, prefix=f"{API_PREFIX}/publicaciones", tags=["Publicaciones"])
app.include_router(objetivo.router, prefix=f"{API_PREFIX}/objetivos", tags=["Objetivos"])
app.include_router(auth.router, prefix=f"{API_PREFIX}/auth", tags=["Autenticación"])
app.include_router(admin.router, prefix=f"{API_PREFIX}/admin", tags=["Administrador"])

# ======================================================
# Ruta raíz
# ======================================================
@app.get("/")
def root():
    return {"message": "FitConnet API - ir a /docs para la documentación Swagger"}
