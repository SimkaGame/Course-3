using System;

public class Ingredient
{
    public string Code { get; }
    public int Quantity { get; }

    public Ingredient(string code, int quantity)
    {
        if (string.IsNullOrWhiteSpace(code))
            throw new ArgumentException("Код не может быть пустым!");
        if (quantity < 1)
            throw new ArgumentException("Количество >= 1!");

        Code = code;
        Quantity = quantity;
    }

    public override string ToString()
    {
        return Code + " x" + Quantity;
    }
}