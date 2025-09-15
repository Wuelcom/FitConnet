# app/routers/objetivo.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/objetivos")
async def listar_objetivos():
    return {"message": "Lista de objetivos"}
