from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app import crud, schemas
from app.auth.security import verify_password
from app.auth.jwt_handler import create_access_token

router = APIRouter(prefix="/auth", tags=["Auth"])

@router.post("/login")
def login(user: schemas.user.UserCreate, db: Session = Depends(get_db)):
    db_user = crud.user.get_user_by_email(db, email=user.correo_electronico)
    if not db_user or not verify_password(user.contrasena, db_user.contrasena):
        raise HTTPException(status_code=401, detail="Credenciales incorrectas")
    token = create_access_token({"sub": db_user.correo_electronico})
    return {"access_token": token, "token_type": "bearer"}
