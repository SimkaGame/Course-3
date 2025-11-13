using System;

public class StreakStats
{
    private int resets = 0;
    private int maxStreak = 0;

    public void OnStreakChanged(ComboTracker sender, int streak)
    {
        if (streak == 0)
            resets++;
        if (streak > maxStreak)
            maxStreak = streak;
    }

    public void Report()
    {
        Console.WriteLine($"Сбросов: {resets}; Максимальное комбо: {maxStreak}");
    }
}
