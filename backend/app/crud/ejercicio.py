# app/crud/ejercicio.py
from sqlalchemy.orm import Session
from typing import List, Optional
from app.models.ejercicio import Ejercicio
from app.schemas.ejercicio import EjercicioCreate, EjercicioUpdate

def get_ejercicio(db: Session, ejercicio_id: int) -> Optional[Ejercicio]:
    return db.query(Ejercicio).filter(Ejercicio.id == ejercicio_id).first()

def get_ejercicios(db: Session, skip: int=0, limit: int=100) -> List[Ejercicio]:
    return db.query(Ejercicio).offset(skip).limit(limit).all()

def create_ejercicio(db: Session, data: EjercicioCreate) -> Ejercicio:
    obj = Ejercicio(nombre=data.nombre, tipo=data.tipo, descripcion=data.descripcion)
    db.add(obj)
    db.commit()
    db.refresh(obj)
    return obj

def update_ejercicio(db: Session, db_obj: Ejercicio, updates: EjercicioUpdate) -> Ejercicio:
    if updates.nombre is not None: db_obj.nombre = updates.nombre
    if updates.tipo is not None: db_obj.tipo = updates.tipo
    if updates.descripcion is not None: db_obj.descripcion = updates.descripcion
    db.add(db_obj)
    db.commit()
    db.refresh(db_obj)
    return db_obj

def delete_ejercicio(db: Session, db_obj: Ejercicio):
    db.delete(db_obj)
    db.commit()
