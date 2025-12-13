from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter(tags=["Auth"])

EXAMPLE_USERS = [
    {"name": "Grace Lovelace", "email": "grace@plymouth.ac.uk", "password": "ISAD123!"},
    {"name": "Tim Berners-Lee", "email": "tim@plymouth.ac.uk", "password": "COMP2001!"},
    {"name": "Ada Lovelace", "email": "ada@plymouth.ac.uk", "password": "insecurePassword"},
]

class LoginRequest(BaseModel):
    email: str
    password: str

TOKENS = {}

@router.post("/login")
def login(request: LoginRequest):
    for user in EXAMPLE_USERS:
        if user["email"] == request.email and user["password"] == request.password:
            token = f"token-{request.email}"
            TOKENS[token] = request.email
            return {"message": "Authenticated successfully", "token": token}
    raise HTTPException(status_code=401, detail="Invalid credentials")

@router.get("/login/examples")
def example_users():
    return EXAMPLE_USERS

def verify_token(token: str):
    if token not in TOKENS:
        raise HTTPException(status_code=401, detail="Unauthorized")
    return TOKENS[token]