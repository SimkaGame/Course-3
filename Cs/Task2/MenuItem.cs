using System;

namespace Task2;

public class MenuItem
{
    public string Name { get; init; }
    public decimal Price { get; set; }
    public int Calories { get; init; }

    public MenuItem(string name, decimal price, int calories)
    {
        Name = name;
        Price = price;
        Calories = calories;
    }

    public override string ToString()
    {
        return $"Блюдо: {Name}, Стоимость: {Price:F2} рублей, Калорийность: {Calories} ккал";
    }
}