# TrailService Microservice 
The TrailService microservice was developed as part of the MAL2018 Information Management & Retrieval module to support the management of trail data, geographic locations, user reviews,
and audit logs within a broader well‑being trail application. The service is implemented using FastAPI and integrates with Microsoft SQL Server through a structured set of stored procedures,
views, and triggers under the CW2 schema. The design follows RESTful principles, incorporates role‑based access control, and adheres to recognised standards for privacy, integrity, and security.


# 1. System Architecture
The microservice adopts a modular architecture comprising:
- FastAPI application layer for routing, validation, and documentation
- SQL Server database layer containing tables, views, stored procedures, and triggers
- Authentication simulation module representing integration with an external Authenticator API
- Administrative and public endpoints for controlled access to trail data
All source code is maintained in a dedicated GitHub repository, and the service is deployed and tested locally.


# 2. Features
- Manage trails, locations, and user reviews
- Public and admin endpoints with role‑based access
- External authentication (simulated login for demo)
- SQL Server backend with stored procedures, views, and triggers
- Audit logging for trail creation
- Fully documented API using Swagger UI
- Clean separation of authentication (external) and authorisation (local roles)


# 3. Technology Stack
- FastAPI                : RESTful API framework
- Uvicorn                : ASGI server
- Microsoft SQL Server   : Database 
- Azure Data Studio      : Database management
- pyodbc                 : Database connectivity
- Pydantic               : Request/response validation
- dotenv                 : Secure environment variable management


# 4. Project Structure
/TrailService
- │── admin.py              # Admin CRUD endpoints
- │── build_database.py     # Demo data seeder
- │── db.py                 # Database connection handler
- │── login.py              # Simulated authentication + token generation
- │── main.py               # FastAPI app configuration
- │── models.py             # Pydantic models
- │── requirements.txt      # Dependencies
- │── swagger.yml           # API documentation
- └── user.py               # Public endpoints


# 5. Database Design
The CW2 schema includes the following entities:
- User      : minimal attributes (user_id, user_email, user_role)
- Trail     : core trail information
- Location  : ordered GPS points for each trail
- Reviews   : user feedback with rating validation
- TrailLog  : audit log for trail creation

Additional database features:
- Unique index on (trail_id, location_pointOrder)
- Composite indexes for reviews and audit logs
- TrailPublicView for restricted public access
- Trigger tr_trail_insert_log for automatic audit logging


# 6. API Endpoints
Authentication
- POST /login – Simulated login returning a Bearer token
- 
Admin Endpoints (token required)
- POST /trails – Create trail
- GET /trails – List trails
- GET /trails/{id} – Read trail
- PUT /trails/{id} – Update trail
- DELETE /trails/{id} – Delete trail
- POST /trails/{id}/locations – Add location
- GET /trails/{id}/locations – List locations
- DELETE /locations/{id} – Delete location
- POST /trails/{id}/reviews – Add review
- GET /trails/{id}/reviews – List reviews
 -DELETE /reviews/{id} – Delete review
  
Public Endpoints
- GET /trails/public – View limited trail data from SQL view


# 7. Deployment and Execution
Step 1: Install dependencies
    - pip install -r requirements.txt
Step 2: Configure environment variables
    - DB_SERVER=localhost
    - DB_NAME=IMR
    - DB_USER=SA
    - DB_PASSWORD=C0mp2001!
Step 3: Start the API
    - uvicorn main:app --reload
Step 4: Access Swagger UI
    - http://localhost:8000/docs


# 8. Testing
All testing was performed using Postman, covering:
- Authentication
- Trail CRUD
- Location management
- Review management
- Public endpoints


# 9. Strengths
- Clear alignment between the ERD, CW2 schema, and API implementation.
- Secure design achieved using stored procedures, views, and triggers.
- Strong separation between authentication (external API) and authorisation (local roles).
- FastAPI and Swagger provided clean, well-documented REST endpoints.


# 10. Weaknesses
- Error handling and input validation remain basic.
- Sample data is manually added within the codebase.


# 11. Areas of Improvement
- Expand automated testing to cover edge cases, error handling, and stored procedure behaviour. 
- Introduce soft delete functionality to preserve historical data rather than permanently removing records. 
- Enhance and streamline the workflow of stored procedures, including better parameter handling, clearer error responses, and more consistent logic across CRUD operations. 
