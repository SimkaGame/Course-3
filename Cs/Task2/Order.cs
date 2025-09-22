using System;
using System.Collections.Generic;
using System.Linq;

namespace Task2;

public class Order
{
    public DateTime OrderDate { get; init; }
    public List<MenuItem> OrderedItems { get; set; }
    public decimal TotalAmount { get; set; }

    public Order(DateTime orderDate, List<MenuItem> orderedItems)
    {
        OrderDate = orderDate;
        OrderedItems = orderedItems ?? new List<MenuItem>();
        TotalAmount = OrderedItems.Sum(item => item.Price);
    }

    public void AddMenuItem(MenuItem item)
    {
        if (item != null && !OrderedItems.Contains(item))
        {
            OrderedItems.Add(item);
            TotalAmount += item.Price;
        }
    }

    public override string ToString()
    {
        List<string> lines = new List<string>
        { $"Заказ от {OrderDate:dd.MM.yyyy HH:mm}, Итоговая сумма: {TotalAmount:F2} рублей, \nЗаказанные блюда:" };
        foreach (var item in OrderedItems)
        {
            lines.Add($"  {item}");
        }
        return string.Join("\n", lines);
    }
}