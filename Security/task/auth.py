# auth.py
import hashlib
import time
from passlib.context import CryptContext
from user import User, UserStorage
from validation import validation

pwd_context = CryptContext(schemes=["argon2"], deprecated="auto")

def register_user(storage: UserStorage, username: str, email: str, password: str) -> User:
    if User.exists(storage, username):
        raise ValueError("Пользователь с таким username уже существует")

    result = validation(password)
    if not result.is_valid:
        raise ValueError(f"Invalid password: {', '.join(result.errors)}")

    hashed = pwd_context.hash(password)
    user = User(username, email, hashed, 0, 0.0)
    user.save(storage)
    return user


def verify_credentials(storage: UserStorage, username: str, password: str) -> bool:
    user = User.load(storage, username)
    if not user:
        return False

    delay = 1.5 ** (user.failed_attempts + 1) + 1
    time.sleep(delay)

    if user.password_hash.startswith("$argon2"):
        ok = pwd_context.verify(password, user.password_hash)
    else:
        ok = hashlib.md5(password.encode()).hexdigest() == user.password_hash
        if ok:
            user.password_hash = pwd_context.hash(password)
            user.save(storage)

    if ok:
        user.failed_attempts = 0
        user.backoff_seconds = 0.0
        user.save(storage)
        return True
    else:
        user.failed_attempts += 1
        user.backoff_seconds = 1.5 ** user.failed_attempts + 1
        user.save(storage)
        return False