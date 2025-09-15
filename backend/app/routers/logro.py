from fastapi import APIRouter

router = APIRouter()

@router.get("/logros")
async def listar_logros():
    return {"message": "Lista de logros"}
