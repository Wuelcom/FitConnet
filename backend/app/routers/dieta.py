# app/routers/dieta.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/dietas")
async def listar_dietas():
    return {"message": "Lista de dietas"}
