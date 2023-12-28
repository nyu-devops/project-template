"""
Global Configuration for Application
"""
import os

# Get configuration from environment
DATABASE_URI = os.getenv(
    "DATABASE_URI", "postgresql+psycopg://postgres:pgs3cr3t@localhost:5432/postgres"
)

# Configure SQLAlchemy
SQLALCHEMY_DATABASE_URI = DATABASE_URI
SQLALCHEMY_TRACK_MODIFICATIONS = False

# Secret for session management
SECRET_KEY = os.getenv("SECRET_KEY", "s3cr3t-key-shhhh")
