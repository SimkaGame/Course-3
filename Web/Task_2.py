class Exhibit:
    def __init__(self, id: int, name: str, author: str):
        self.id: int = id
        self.name: str = name
        self.author: str = author

    def __str__(self) -> str:
        return f"Уникальный идентификатор: {self.id},  Имя экспоната: {self.name} - Автор: {self.author}."

class Hall:
    def __init__(self, name: str, size: float):
        self.name: str = name
        self.size: float = size
        self.exhibits: list[Exhibit] = []

    def add_exhibit(self, exhibit: Exhibit) -> None:
        if exhibit not in self.exhibits:
            self.exhibits.append(exhibit)

    def __str__(self) -> str:
        return f"{self.name}, Размер зала: {self.size} кв.м, Экспонаты {len(self.exhibits)}"

class Museum:
    def __init__(self, name: str, space: float):
        self.name: str = name
        self.space: float = space
        self.halls: list[Hall] = []

    def add_hall(self, hall: Hall) -> None:
        if hall not in self.halls:
            self.halls.append(hall)

    def get_description(self) -> str:
        lines = [f"Музей: {self.name}, Общая площадь: {self.space} кв.м, \nЗалы:"]
        for hall in self.halls:
            lines.append(f"  {hall}")
            for exhibit in hall.exhibits:
                lines.append(f"    {exhibit}")
        return "\n".join(lines)

    def __str__(self) -> str:
        return self.name

def main():
    h1 = Hall("Эпоха Возрождения", 200.0)
    h2 = Hall("Современное искусство", 150.0)

    h1.add_exhibit(Exhibit(1, "Мона Лиза", "Леонардо да Винчи"))
    h1.add_exhibit(Exhibit(2, "Сотворение Адама", "Микеланджело"))
    h1.add_exhibit(Exhibit(3, "Тайная вечеря", "Леонардо да Винчи"))

    h2.add_exhibit(Exhibit(4, "Композиция VIII", "Василий Кандинский"))
    h2.add_exhibit(Exhibit(5, "Супрематическая композиция", "Казимир Малевич"))

    m1 = Museum("Музей мировой живописи", 350.0)
    m1.add_hall(h1)
    m1.add_hall(h2)

    print(m1.get_description())

if __name__ == "__main__":
    main()