# app/database.py
"""
Crea el engine y sessionmaker de SQLAlchemy.
Provee una dependencia get_db() para inyectar la sesión en rutas.
"""

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, declarative_base
from app.config import DATABASE_URL

SQLALCHEMY_DATABASE_URL = "mysql+pymysql://root:@localhost:3306/FitConnet"

# Engine (sin async para simplicidad)
engine = create_engine(DATABASE_URL, echo=False, future=True)

# Session local factory
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False, future=True)

Base = declarative_base()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
