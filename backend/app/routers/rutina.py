# app/routers/rutina.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/rutinas")
async def listar_rutinas():
    return {"message": "Lista de rutinas"}
