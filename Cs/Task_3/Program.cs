using System;

class Program
{
    static void Main()
    {
        Manager manager = new Manager("Иван", 100000, 4);
        Developer developer = new Developer("Андрей", 80000, true);

        Console.WriteLine($"Премия менеджера: {manager.CalculateBonus()} руб.");
        Console.WriteLine($"Премия разработчика: {developer.CalculateBonus()} руб.");
    }
}
