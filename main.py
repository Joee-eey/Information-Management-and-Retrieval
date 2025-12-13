from fastapi import FastAPI
from fastapi.openapi.docs import get_swagger_ui_html
from fastapi.responses import RedirectResponse

from login import router as login_router
from admin import router as admin_router
from user import router as user_router

app = FastAPI(
    title="RP FastAPI REST API",
    description="Trails, Locations, and Reviews",
    version="1.0.0",
    openapi_tags=[
        {"name": "Auth", "description": "Authentication endpoints"},
        {"name": "Admin", "description": "Administrator operations"},
        {"name": "User", "description": "Public operations"},
    ],
    components={
        "securitySchemes": {
            "bearerAuth": {
                "type": "http",
                "scheme": "bearer",
                "bearerFormat": "token"
            }
        }
    }
)

# Redirect root to /docs
@app.get("/", include_in_schema=False)
def root():
    return RedirectResponse("/docs")

# Custom Swagger UI at /api/ui
@app.get("/api/ui", include_in_schema=False)
def custom_swagger_ui():
    return get_swagger_ui_html(
        openapi_url="/openapi.json",
        title="RP FastAPI REST API",
    )

# Routers
app.include_router(login_router)
app.include_router(user_router)
app.include_router(admin_router)