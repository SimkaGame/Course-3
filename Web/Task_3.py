class Animal:
    def __init__(self, name, weight):
        self.name = name
        self.weight = weight

    def description(self):
        return f"Это {self.name}, массой {self.weight} кг."


class Dog(Animal):
    def __init__(self, name, weight, hair_length):
        super().__init__(name, weight)
        self.hair_length = hair_length

    def description(self):
        return super().description() + f" Длина шерсти — {self.hair_length}."


class Cat(Animal):
    def __init__(self, name, weight, color):
        super().__init__(name, weight)
        self.color = color

    def description(self):
        return super().description() + f" Окрас кота — {self.color}."


# Тест
dog1 = Dog("Собака", 25, "короткая")
cat1 = Cat("Кот", 5, "серый")

print(dog1.description())
print(cat1.description())
