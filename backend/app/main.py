# app/main.py
"""
Punto de entrada de la aplicación FastAPI.
Registra routers y sirve archivos estáticos (front-end).
"""
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from app.config import API_PREFIX
from app.database import engine, Base
from app.routers import user, role, rutina, ejercicio, logro, dieta, progreso, publicacion, objetivo  # importa routers existentes
# importa los otros routers si los creas: roles, rutinas, etc.

# Crea tablas si no existen (útil en dev)
Base.metadata.create_all(bind=engine)

app = FastAPI(title="FitConnet API")

# Routers
app.include_router(user.router)
app.include_router(role.router)
app.include_router(rutina.router)
app.include_router(ejercicio.router)
app.include_router(logro.router)
app.include_router(dieta.router)
app.include_router(progreso.router)
app.include_router(publicacion.router)
app.include_router(objetivo.router)
app.include_router(auth_router.router)

# montar carpeta estática (tu HTML/CSS/JS)
app.mount("/static", StaticFiles(directory="app/static"), name="static")

# include routers
app.include_router(users.router, prefix=f"{API_PREFIX}", tags=["users"])
app.include_router(ejercicios.router, prefix=f"{API_PREFIX}", tags=["ejercicios"])
# incluir otros routers: roles.router, rutinas.router, etc.

@app.get("/")
def root():
    return {"message": "FitConnet API - ir a /static/index.html para la interfaz"}
