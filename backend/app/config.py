# app/config.py
"""
Configuración de la aplicación.
Define la cadena de conexión a la base de datos y carga variables de entorno.
"""
from dotenv import load_dotenv
import os

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL", "mysql+pymysql://root:@localhost:3306/FitConnet")
API_PREFIX = "/api"
