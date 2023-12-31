from fastapi import FastAPI
from server.routes.image import router as imageRouter


app = FastAPI()

app.include_router(imageRouter, tags=["image"], prefix="/image")
@app.get("/", tags=["Root"])
async def read_root():
    return {"message": "Welcome to this fantastic app!"}