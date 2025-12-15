import requests
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Dict

router = APIRouter(tags=["Auth"])

AUTH_API_URL = "https://web.socem.plymouth.ac.uk/COMP2001/auth/api/users"

class LoginRequest(BaseModel):
    email: str
    password: str

# In‑memory token store
TOKENS: Dict[str, str] = {}

@router.post("/login")
def login(request: LoginRequest):
    """
    Authenticates a user using the real Plymouth Auth API.
    If valid, a local token is generated and returned.
    """
    # Attempt to contact the external authentication API
    try:
        response = requests.post(
            AUTH_API_URL,
            json={"email": request.email, "password": request.password},
            timeout=10
        )
    except Exception:
        raise HTTPException(status_code=500, detail="Authentication service unreachable")

    # If external API rejects the credentials
    if response.status_code != 200:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    # Try to parse the response (structure not used, only checked)
    try:
        _ = response.json()
    except ValueError:
        raise HTTPException(status_code=500, detail="Invalid response from authentication server")

    # Generate local token
    token = f"token-{request.email}"
    TOKENS[token] = request.email

    return {
        "message": "Authenticated successfully",
        "token": token,
        "user_email": request.email
    }

@router.get("/login/examples")
def example_users():
    """
    This endpoint is no longer needed when using the real API.
    Kept only for compatibility or demonstration.
    """
    return {"message": "External authentication is now used. No local example users."}

def verify_token(token: str) -> str:
    """
    Verifies whether a token exists in the token store.
    Returns the associated email if valid.
    """
    if token not in TOKENS:
        raise HTTPException(status_code=401, detail="Unauthorized")

    return TOKENS[token]
