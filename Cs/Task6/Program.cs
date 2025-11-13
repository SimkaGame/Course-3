using System;

public class Program
{
    public static void Main()
    {
        var calcEnum = new PriorityCalculatorEnum();
        var calcOop = new PriorityCalculatorOop();

        Console.WriteLine("Часть A");

        var context1 = new NotifyContext();
        Console.WriteLine($"Info      : {calcEnum.GetPriority(EventType.Info, context1)}");

        var context2 = new NotifyContext { IsVIPUser = true };
        Console.WriteLine($"Warning   : {calcEnum.GetPriority(EventType.Warning, context2)}");

        var context3 = new NotifyContext { IsQuietHours = true };
        Console.WriteLine($"Alert     : {calcEnum.GetPriority(EventType.Alert, context3)}");

        var context4 = new NotifyContext { HasCriticalFlag = true };
        Console.WriteLine($"Critical  : {calcEnum.GetPriority(EventType.Critical, context4)}");

        Console.WriteLine("Часть B");

        Console.WriteLine($"Info      : {calcOop.GetPriority(new InfoEvent(), context1)}");
        Console.WriteLine($"Warning   : {calcOop.GetPriority(new WarningEvent(), context2)}");
        Console.WriteLine($"Alert     : {calcOop.GetPriority(new AlertEvent(), context3)}");
        Console.WriteLine($"Critical  : {calcOop.GetPriority(new CriticalEvent(), context4)}");
    }
}
