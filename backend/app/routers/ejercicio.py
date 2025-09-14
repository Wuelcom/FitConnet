# app/routers/ejercicios.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.database import get_db
from app.schemas.ejercicio import EjercicioCreate, EjercicioOut, EjercicioUpdate
from app import crud

router = APIRouter(prefix="/ejercicios", tags=["ejercicios"])

@router.get("/", response_model=List[EjercicioOut])
def list_ejercicios(skip: int=0, limit: int=100, db: Session = Depends(get_db)):
    return crud.ejercicio.get_ejercicios(db, skip, limit)

@router.post("/", response_model=EjercicioOut)
def create_ejercicio(ejercicio_in: EjercicioCreate, db: Session = Depends(get_db)):
    return crud.ejercicio.create_ejercicio(db, ejercicio_in)

@router.get("/{ejercicio_id}", response_model=EjercicioOut)
def get_ejercicio(ejercicio_id: int, db: Session = Depends(get_db)):
    obj = crud.ejercicio.get_ejercicio(db, ejercicio_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Ejercicio no encontrado")
    return obj

@router.put("/{ejercicio_id}", response_model=EjercicioOut)
def update_ejercicio(ejercicio_id: int, updates: EjercicioUpdate, db: Session = Depends(get_db)):
    obj = crud.ejercicio.get_ejercicio(db, ejercicio_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Ejercicio no encontrado")
    return crud.ejercicio.update_ejercicio(db, obj, updates)

@router.delete("/{ejercicio_id}")
def delete_ejercicio(ejercicio_id: int, db: Session = Depends(get_db)):
    obj = crud.ejercicio.get_ejercicio(db, ejercicio_id)
    if not obj:
        raise HTTPException(status_code=404, detail="Ejercicio no encontrado")
    crud.ejercicio.delete_ejercicio(db, obj)
    return {"detail": "Ejercicio eliminado"}
