from dataclasses import dataclass
from typing import Protocol, Optional, Dict

class UserStorage(Protocol):
    def get_user(self, username: str) -> Optional["User"]: ...
    def save_user(self, user: "User") -> None: ...
    def exists(self, username: str) -> bool: ...

@dataclass
class User:
    username: str
    email: str
    password_hash: str
    failed_attempts: int = 0
    backoff_seconds: float = 0.0

    def save(self, storage: UserStorage) -> None:
        storage.save_user(self)

    @classmethod
    def load(cls, storage: UserStorage, username: str) -> Optional["User"]:
        return storage.get_user(username)

    @classmethod
    def exists(cls, storage: UserStorage, username: str) -> bool:
        return storage.exists(username)

class InMemoryUserStorage:
    """Учебное хранилище на словаре."""
    def __init__(self) -> None:
        self._db: Dict[str, User] = {}

    def get_user(self, username: str) -> Optional[User]:
        return self._db.get(username)

    def save_user(self, user: User) -> None:
        self._db[user.username] = user

    def exists(self, username: str) -> bool:
        return username in self._db