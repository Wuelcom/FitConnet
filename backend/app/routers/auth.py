# app/routers/auth.py
from fastapi import APIRouter

router = APIRouter()

@router.post("/login")
async def login():
    return {"message": "Login exitoso"}

@router.post("/register")
async def register():
    return {"message": "Usuario registrado"}
