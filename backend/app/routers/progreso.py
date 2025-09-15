# app/routers/progreso.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/progresos")
async def listar_progresos():
    return {"message": "Lista de progresos"}
