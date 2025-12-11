
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
from typing import List, Dict
class UserIn(BaseModel):
    username: str
    password: str

class UserDB(UserIn):
db: List[UserDB] = []

app = FastAPI(
    title="Aylal API",
    description="login xiix API (Signup\Login)"
)

@app.post("/signup", status_code=status.HTTP_201_CREATED)
async def signup_user(user_in: UserIn):
    global db
    if any(u.username == user_in.username for u in db):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Аль хэдийн бүртгэлтэй байна."
        )
    
    db.append(UserDB(username=user_in.username, password=user_in.password))
    
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