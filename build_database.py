import pyodbc
from datetime import datetime
from db import get_connection

def seed_demo_data():
    conn = get_connection()
    cursor = conn.cursor()

    # Clear existing data 
    cursor.execute("DELETE FROM CW2.reviews")
    cursor.execute("DELETE FROM CW2.location")
    cursor.execute("DELETE FROM CW2.trail")
    cursor.execute("DELETE FROM CW2.[user]")
    conn.commit()

    # Insert demo users
    cursor.execute("INSERT INTO CW2.[user] (user_id, user_name, user_email, user_role) VALUES (?, ?, ?, ?)",
                   "U001", "Grace Lovelace", "grace@plymouth.ac.uk", "admin")
    cursor.execute("INSERT INTO CW2.[user] (user_id, user_name, user_email, user_role) VALUES (?, ?, ?, ?)",
                   "U002", "Tim Berners-Lee", "tim@plymouth.ac.uk", "admin")
    cursor.execute("INSERT INTO CW2.[user] (user_id, user_name, user_email, user_role) VALUES (?, ?, ?, ?)",
                   "U003", "Ada Lovelace", "ada@plymouth.ac.uk", "admin")

    # Insert demo trails 
    cursor.execute("INSERT INTO CW2.trail (trail_id, user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty, trail_isPublic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                   "T001", "U001", "Deer Valley Loop", 2.5, 1.0, "loop", "easy", 1)
    cursor.execute("INSERT INTO CW2.trail (trail_id, user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty, trail_isPublic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                   "T002", "U002", "Quarry Out-and-Back", 4.2, 2.0, "out-and-back", "moderate", 1)
    cursor.execute("INSERT INTO CW2.trail (trail_id, user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty, trail_isPublic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                   "T003", "U003", "Copper Ruins Point-to-Point", 3.0, 1.5, "point-to-point", "hard", 1)
    cursor.execute("INSERT INTO CW2.trail (trail_id, user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty, trail_isPublic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                   "T004", "U002", "River Lollipop Trail", 5.0, 2.5, "lollipop", "moderate", 1)

    # Insert demo locations 
    cursor.execute("INSERT INTO CW2.location (location_id, trail_id, location_latitude, location_longitude, location_pointOrder) VALUES (?, ?, ?, ?, ?)",
                   "L001", "T001", 50.123456, -4.123456, 1)
    cursor.execute("INSERT INTO CW2.location (location_id, trail_id, location_latitude, location_longitude, location_pointOrder) VALUES (?, ?, ?, ?, ?)",
                   "L002", "T001", 50.123500, -4.123500, 2)
    cursor.execute("INSERT INTO CW2.location (location_id, trail_id, location_latitude, location_longitude, location_pointOrder) VALUES (?, ?, ?, ?, ?)",
                   "L003", "T002", 50.223456, -4.223456, 1)
    cursor.execute("INSERT INTO CW2.location (location_id, trail_id, location_latitude, location_longitude, location_pointOrder) VALUES (?, ?, ?, ?, ?)",
                   "L004", "T002", 50.223500, -4.223500, 2)

    # Insert demo reviews 
    cursor.execute("INSERT INTO CW2.reviews (reviews_id, trail_id, user_id, reviews_rating, reviews_description, reviews_date) VALUES (?, ?, ?, ?, ?, ?)",
                   "R001", "T001", "U002", 5, "Beautiful scenery, especially in the morning!", datetime(2025, 11, 26).date())
    cursor.execute("INSERT INTO CW2.reviews (reviews_id, trail_id, user_id, reviews_rating, reviews_description, reviews_date) VALUES (?, ?, ?, ?, ?, ?)",
                   "R002", "T002", "U003", 4, "Rocky path, but worth the effort.", datetime(2025, 11, 26).date())
    cursor.execute("INSERT INTO CW2.reviews (reviews_id, trail_id, user_id, reviews_rating, reviews_description, reviews_date) VALUES (?, ?, ?, ?, ?, ?)",
                   "R003", "T003", "U001", 3, "Ruins are fascinating, but trail is tough!", datetime(2025, 11, 26).date())

    conn.commit()
    conn.close()
    print("Demo data seeded successfully!")

if __name__ == "__main__":
    seed_demo_data()