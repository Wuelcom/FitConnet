from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello FitConnet"}

@app.get("/saludo")
def saludo():
    return {"mensaje": "¡Bienvenido a FitConnet!"}
