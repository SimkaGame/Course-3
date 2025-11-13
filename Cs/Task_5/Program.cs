using System;

public class Program
{
    public static void Main()
    {
        Restaurant restaurant = new Restaurant();

        SimpleOrder simpleOrder = new SimpleOrder("Иван", 10000);
        restaurant.ProcessSimpleOrder(simpleOrder, 20); //Скидка
        Console.WriteLine();

        MemberOrder memberOrder = new MemberOrder("Мария", 10000, 5000);
        restaurant.ProcessMemberOrder(memberOrder, 60);
    }
}
