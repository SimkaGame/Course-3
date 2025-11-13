```mermaid
erDiagram
    DEVELOPER ||--o{ GAME : "1:N (primary_developer_id)"
    GAME ||--|| GAME_INFO : "1:1"
    DEVELOPER }o--o{ GAME_CREDIT : "M:N (участие/роль)"
    GAME }o--o{ GAME_CREDIT : ""