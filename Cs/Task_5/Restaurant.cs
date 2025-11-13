using System;
using Interfaces;

public class Restaurant
{
    public void ProcessSimpleOrder(IOrder order, int discount)
    {
        Console.WriteLine($"Обычный заказ от клиента {order.Customer}:");
        Console.WriteLine($"Сумма до скидки: {order.TotalCents} копеек");
        order.ApplyDiscount(discount);
        Console.WriteLine($"Сумма после скидки {discount}%: {order.TotalCents} копеек");
    }

    public void ProcessMemberOrder(MemberOrder order, int discount)
    {
        Console.WriteLine($"Заказ участника программы лояльности {order.Customer}:");
        Console.WriteLine($"Сумма до скидки: {order.TotalCents} копеек");
        order.ApplyDiscount(discount);
        Console.WriteLine($"Сумма после скидки {discount}% (не меньше {order.MinBillCents} копеек): {order.TotalCents} копеек");
        Console.WriteLine($"Начисленные баллы: {order.LoyaltyPoints}");
    }
}
