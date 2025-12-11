import json
import os
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
from typing import List, Dict

USERS_FILE = "login.json"
class UserIn(BaseModel):
    username: str
    password: str

class UserDB(UserIn):
    pass

db: List[UserDB] = []

def load_users():
    global db
    if not os.path.exists(USERS_FILE) or os.stat(USERS_FILE).st_size == 0:
        db = []
        return
    
    try:
        with open(USERS_FILE, 'r', encoding='utf-8') as f:
            data = json.load(f)
            db = [UserDB(**user_data) for user_data in data]
    except (json.JSONDecodeError, FileNotFoundError) as e:
        print(f"Warning: {USERS_FILE}{e}")
        db = []

def save_users():
    users_data = [user.model_dump() for user in db] 
    try:
        with open(USERS_FILE, 'w', encoding='utf-8') as f:
            json.dump(users_data, f, indent=4, ensure_ascii=False)
    except Exception as e:
        print(f"Error saving users to {USERS_FILE}: {e}")

load_users()

app = FastAPI(
    title="Fitness API",
    description="API for user authentication (Signup and Login)"
)
@app.post("/signup", status_code=status.HTTP_201_CREATED)
async def signup_user(user_in: UserIn):
    global db
    if any(u.username == user_in.username for u in db):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Аль хэдийн бүртгэлтэй байна."
        )
    new_user = UserDB(username=user_in.username, password=user_in.password)
    db.append(new_user)
    save_users()
    
    return {"message": "Бүртгэл амжилттай үүслээ", "username": user_in.username}

@app.post("/login")
async def login_user(user_in: UserIn):
    global db
    user_found = next((u for u in db if u.username == user_in.username), None)
    
    if user_found is None or user_found.password != user_in.password:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Нэр эсвэл нууц үг буруу байна"
        )
        
    return {"message": "Нэвтрэлт амжилттай", "username": user_in.username}

# uvicorn main:app --reload --host 0.0.0.0 --port 8000