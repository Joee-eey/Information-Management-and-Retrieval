from fastapi import APIRouter, HTTPException, Security, Header
from db import get_connection
from models import Trail, Location, Review
from login import verify_token

router = APIRouter(tags=["Admin"])

def auth_dependency(authorization: str = Header(None, alias="Authorization")):
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Invalid Authorization header format")
    token = authorization.split(" ")[1]
    return verify_token(token)

# TRAILS
@router.post("/trails")
def create_trail(trail: Trail, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "EXEC CW2.sp_trail_create ?, ?, ?, ?, ?, ?, ?, ?",
            trail.trail_id, trail.user_id, trail.trail_name,
            trail.trail_length, trail.trail_duration,
            trail.trail_type, trail.trail_difficulty,
            int(trail.trail_isPublic)
        )
        conn.commit()
        return {"message": "Trail created successfully", "trail_id": trail.trail_id}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()


@router.get("/trails/{trail_id}")
def read_trail(trail_id: str, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("EXEC CW2.sp_trail_read ?", trail_id)
    row = cursor.fetchone()
    if not row:
        conn.close()
        raise HTTPException(status_code=404, detail="Trail not found")
    result = dict(zip([col[0] for col in cursor.description], row))
    conn.close()
    return result


@router.get("/trails")
def list_trails(owner_user_id: str = None, include_private: bool = False, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("EXEC CW2.sp_trail_list ?, ?", owner_user_id, int(include_private))
    rows = cursor.fetchall()
    result = [dict(zip([col[0] for col in cursor.description], row)) for row in rows]
    conn.close()
    return result


@router.put("/trails/{trail_id}")
def update_trail(trail_id: str, trail: Trail, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "EXEC CW2.sp_trail_update ?, ?, ?, ?, ?, ?, ?",
            trail_id, trail.trail_name, trail.trail_length,
            trail.trail_duration, trail.trail_type,
            trail.trail_difficulty, int(trail.trail_isPublic)
        )
        conn.commit()
        return {"message": f"Trail {trail_id} updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()


@router.delete("/trails/{trail_id}")
def delete_trail(trail_id: str, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("EXEC CW2.sp_trail_delete ?", trail_id)
        conn.commit()
        return {"message": f"Trail {trail_id} deleted successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()

# LOCATIONS
@router.post("/trails/{trail_id}/locations")
def add_location(trail_id: str, location: Location, user = Security(auth_dependency)):
    if location.trail_id != trail_id:
        raise HTTPException(status_code=400, detail="Body trail_id must match path trail_id")

    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "EXEC CW2.sp_location_add ?, ?, ?, ?, ?",
            location.location_id, location.trail_id,
            location.location_latitude, location.location_longitude,
            location.location_pointOrder
        )
        conn.commit()
        return {"message": "Location added successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()


@router.get("/trails/{trail_id}/locations")
def list_locations(trail_id: str, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("EXEC CW2.sp_location_list_by_trail ?", trail_id)
    rows = cursor.fetchall()
    result = [dict(zip([col[0] for col in cursor.description], row)) for row in rows]
    conn.close()
    return result


@router.delete("/locations/{location_id}")
def delete_location(location_id: str, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("EXEC CW2.sp_location_delete ?", location_id)
        conn.commit()
        return {"message": f"Location {location_id} deleted successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()

# REVIEWS
@router.post("/trails/{trail_id}/reviews")
def add_review(trail_id: str, review: Review, user = Security(auth_dependency)):
    if review.trail_id != trail_id:
        raise HTTPException(status_code=400, detail="Body trail_id must match path trail_id")

    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "EXEC CW2.sp_review_add ?, ?, ?, ?, ?",
            review.reviews_id, review.user_id, review.trail_id,
            review.reviews_rating, review.reviews_description
        )
        conn.commit()
        return {"message": "Review added successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()


@router.get("/trails/{trail_id}/reviews")
def list_reviews(trail_id: str, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("EXEC CW2.sp_review_list_by_trail ?", trail_id)
    rows = cursor.fetchall()
    result = [dict(zip([col[0] for col in cursor.description], row)) for row in rows]
    conn.close()
    return result


@router.delete("/reviews/{reviews_id}")
def delete_review(reviews_id: str, user = Security(auth_dependency)):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("EXEC CW2.sp_review_delete ?", reviews_id)
        conn.commit()
        return {"message": f"Review {reviews_id} deleted successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        conn.close()
