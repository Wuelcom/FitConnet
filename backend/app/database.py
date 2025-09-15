# app/database.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# URL de conexión a MySQL
DATABASE_URL = "mysql+pymysql://root:@localhost:3306/FitConnet"

# Engine (sin async)
engine = create_engine(DATABASE_URL, echo=False, future=True)

# Session local factory
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False, future=True)

# Base declarativa para los modelos
Base = declarative_base()

# Dependency para FastAPI
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
