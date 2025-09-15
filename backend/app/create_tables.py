# backend/create_tables.py
from app.database import Base, engine
from app import models

if __name__ == "__main__":
    print("Creando tablas en la base de datos...")
    Base.metadata.create_all(bind=engine)
    print("Tablas creadas correctamente.")
