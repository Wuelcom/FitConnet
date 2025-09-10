# app/database.py

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Opción 1 → Usando mysqlconnector
SQLALCHEMY_DATABASE_URL = "mysql+mysqlconnector://root:@localhost:3306/FitConnet"

# Opción 2 → Usando PyMySQL
# SQLALCHEMY_DATABASE_URL = "mysql+pymysql://root:@localhost:3306/FitConnet"

# =====================================================
# CONFIGURACIÓN DEL MOTOR Y SESIÓN
# =====================================================
# Crear el motor de conexión
engine = create_engine(SQLALCHEMY_DATABASE_URL)

# Crear la clase Base para los modelos
Base = declarative_base()

# Crear la sesión para interactuar con la base de datos
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# =====================================================
# FUNCIÓN PARA OBTENER SESIONES EN DEPENDENCIAS DE FASTAPI
# =====================================================
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
