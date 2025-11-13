using System;

public class Program
{
    public static void Main()
    {
        var tracker = new ComboTracker();
        var announcer = new ConsoleAnnouncer();
        var stats = new StreakStats();

        // Подписка
        tracker.StreakChanged += announcer.OnStreakChanged;
        tracker.StreakChanged += stats.OnStreakChanged;
        tracker.MilestoneReached += announcer.OnMilestoneReached;

        // Запуск симуляции
        tracker.Start();

        // Отписка одного обработчика
        tracker.MilestoneReached -= announcer.OnMilestoneReached;

        // Итоговый отчёт
        stats.Report();
    }
}
