from fastapi import FastAPI
from app.database import engine, Base
from app.routers import usuarios

app = FastAPI()

# Crear tablas si no existen
Base.metadata.create_all(bind=engine)

app.include_router(usuarios.router)

@app.get("/")
def read_root():
    return {"mensaje": "Hola, FastAPI está funcionando 🚀"}
