using System;
using System.Collections.Generic;

namespace Task2;

public class Cafe
{
    public string Name { get; init; }
    public int NumberSeats { get; set; }
    public IEnumerable<MenuItem> MenuItems => menuItems;

    public Cafe(string name, int numberSeats)
    {
        Name = name;
        NumberSeats = numberSeats;
        menuItems = new List<MenuItem>();
    }

    public void AddMenuItem(MenuItem menuItem)
    {
        if (menuItem != null && !menuItems.Contains(menuItem))
        {
            menuItems.Add(menuItem);
        }
    }

    public void RemoveMenuItem(MenuItem menuItem)
    {
        menuItems.Remove(menuItem);
    }

    public string GetDescription()
    {
        List<string> lines = new List<string> { $"Кафе: {Name}, Посадочные места: {NumberSeats}, \nБлюда:" };
        foreach (var item in MenuItems)
        {
            lines.Add($"  {item}");
        }
        return string.Join("\n", lines);
    }

    public override string ToString()
    {
        return Name;
    }

    private readonly List<MenuItem> menuItems;
}