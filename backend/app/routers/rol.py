from fastapi import APIRouter

router = APIRouter()

@router.get("/roles")
async def listar_roles():
    return {"message": "Lista de roles"}
