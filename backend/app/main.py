from fastapi import FastAPI
from . import models, database
from .routers import users

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI(title="FitConnet API")

# Routers
app.include_router(users.router)

@app.get("/")
def root():
    return {"message": "Bienvenido a FitConnet API 🚀"}
