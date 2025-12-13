from fastapi import APIRouter
from db import get_connection

router = APIRouter(tags=["User"])

@router.get("/trails/public", tags=["User"], dependencies=[])
def public_trails():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM IMR.CW2.TrailPublicView")
    rows = cursor.fetchall()
    result = [dict(zip([col[0] for col in cursor.description], row)) for row in rows]
    conn.close()
    return result