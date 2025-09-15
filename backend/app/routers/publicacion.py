# app/routers/publicacion.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/publicaciones")
async def listar_publicaciones():
    return {"message": "Lista de publicaciones"}
