using System;
using System.Collections.Generic;

namespace Task2;

class Program
{
    static void Main()
    {
        MenuItem item1 = new MenuItem("Паста Карбонара", 510.99m, 750);
        MenuItem item2 = new MenuItem("Цезарь с курицей", 350m, 420);
        MenuItem item3 = new MenuItem("Тирамису", 250.99m, 250);
        MenuItem item4 = new MenuItem("Эспрессо", 199.99m, 85);

        Cafe cafe = new Cafe("Белый кролик", 50);
        cafe.AddMenuItem(item1);
        cafe.AddMenuItem(item2);
        cafe.AddMenuItem(item3);
        cafe.AddMenuItem(item4);

        Order order1 = new Order(DateTime.Now, new List<MenuItem>());
        order1.AddMenuItem(item1);
        order1.AddMenuItem(item3);

        Order order2 = new Order(DateTime.Now.AddHours(+1), new List<MenuItem>());
        order2.AddMenuItem(item2);
        order2.AddMenuItem(item4);

        Console.WriteLine(cafe.GetDescription());
        Console.WriteLine("\n" + new string('-', 50) + "\n");

        Console.WriteLine("Заказы:");
        Console.WriteLine(order1);
        Console.WriteLine("\n" + new string('-', 50) + "\n");
        Console.WriteLine(order2);
    }
}