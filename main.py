
import os
import uvicorn
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

load_dotenv()

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def homepage():
    return "Hello from homepage"

@app.get("/config")
def config():
    value = os.environ.get("HELLO", "planet")
    return value


if __name__ == "__main__":
    uvicorn.run(app)