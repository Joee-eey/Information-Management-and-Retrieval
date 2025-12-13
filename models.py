from pydantic import BaseModel
from typing import Optional

class Trail(BaseModel):
    trail_id: str
    user_id: str
    trail_name: str
    trail_length: Optional[float] = None
    trail_duration: Optional[float] = None
    trail_type: Optional[str] = None
    trail_difficulty: Optional[str] = None
    trail_isPublic: bool = True

class Location(BaseModel):
    location_id: str
    trail_id: str
    location_latitude: float
    location_longitude: float
    location_pointOrder: int

class Review(BaseModel):
    reviews_id: str
    user_id: str
    trail_id: str
    reviews_rating: int
    reviews_description: str