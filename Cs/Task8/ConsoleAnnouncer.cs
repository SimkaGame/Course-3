using System;

public class ConsoleAnnouncer
{
    public void OnStreakChanged(ComboTracker sender, int streak)
    {
        Console.WriteLine($"Комбо: {streak}");
    }

    public void OnMilestoneReached(object? sender, int milestone)
    {
        Console.WriteLine($"Рубеж комбо: {milestone} Отлично!");
    }
}
