# FitConnet - Backend FastAPI (Demo)

## Requisitos
- Python 3.10+
- MySQL corriendo y base de datos `FitConnet` creada.
- Cadena de conexión por defecto: `mysql+pymysql://root:@localhost:3306/FitConnet`

## Instalación
1. Crear venv:
   `python -m venv venv && source venv/bin/activate` (Windows: `venv\Scripts\activate`)
2. Instalar dependencias:
   `pip install -r requirements.txt`
3. Ejecutar:
   `uvicorn app.main:app --reload --port 8000`
4. Abrir front-end:
   `http://127.0.0.1:8000/static/index.html`

