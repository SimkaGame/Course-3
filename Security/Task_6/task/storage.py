import json
import os
import tempfile
from pathlib import Path
from typing import Any, Optional
import time


BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"
USERS_PATH = DATA_DIR / "users.json"
TOKENS_PATH = DATA_DIR / "tokens.json"


def _ensure_files():
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    if not USERS_PATH.exists():
        USERS_PATH.write_text(json.dumps({"users": []}, ensure_ascii=False, indent=2), encoding="utf-8")
    if not TOKENS_PATH.exists():
        TOKENS_PATH.write_text(json.dumps({"tokens": []}, ensure_ascii=False, indent=2), encoding="utf-8")


def _atomic_write(path: Path, data: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile("w", delete=False, dir=str(path.parent), encoding="utf-8") as tmp:
        json.dump(data, tmp, ensure_ascii=False, indent=2)
        tmp.flush()
        os.fsync(tmp.fileno())
        name = tmp.name
    os.replace(name, path)


def load_users() -> dict[str, Any]:
    _ensure_files()
    return json.loads(USERS_PATH.read_text(encoding="utf-8"))


def save_users(db: dict[str, Any]) -> None:
    _atomic_write(USERS_PATH, db)


def load_tokens() -> dict[str, Any]:
    _ensure_files()
    return json.loads(TOKENS_PATH.read_text(encoding="utf-8"))


def save_tokens(db: dict[str, Any]) -> None:
    _atomic_write(TOKENS_PATH, db)

def find_user(username: str) -> Optional[dict[str, Any]]:
    db = load_users()
    return next((u for u in db["users"] if u["username"] == username), None)


def add_user(user: dict[str, Any]) -> None:
    db = load_users()
    db["users"].append(user)
    save_users(db)


def update_user(user: dict[str, Any]) -> None:
    db = load_users()
    for i, u in enumerate(db["users"]):
        if u["username"] == user["username"]:
            db["users"][i] = user
            save_users(db)
            return

def find_token(token: str) -> Optional[dict[str, Any]]:
    db = load_tokens()
    return next((t for t in db["tokens"] if t["token"] == token), None)


def add_token(token_record: dict[str, Any]) -> None:
    db = load_tokens()
    db["tokens"].append(token_record)
    save_tokens(db)


def revoke_token(token: str) -> None:
    db = load_tokens()
    db["tokens"] = [t for t in db["tokens"] if t["token"] != token]
    save_tokens(db)

def clear_data():
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    USERS_PATH.write_text(json.dumps({"users": []}, ensure_ascii=False, indent=2), encoding="utf-8")
    TOKENS_PATH.write_text(json.dumps({"tokens": []}, ensure_ascii=False, indent=2), encoding="utf-8")
def record_token(payload: dict[str, Any]) -> None:
    db = load_tokens()
    db["tokens"].append({
        "jti": payload["jti"],
        "exp": payload["exp"],
        "revoked": False
    })
    save_tokens(db)


def revoke_by_jti(jti: str) -> None:
    db = load_tokens()
    for t in db["tokens"]:
        if t["jti"] == jti:
            t["revoked"] = True
    save_tokens(db)


def is_revoked(jti: str) -> bool:
    db = load_tokens()
    for t in db["tokens"]:
        if t["jti"] == jti:
            return t.get("revoked", False)
    return False


def is_expired(exp: int) -> bool:
    return int(time.time()) > exp