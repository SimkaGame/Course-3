using System;

public class ComboTracker
{
    public delegate void ComboEventHandler(ComboTracker sender, int streak);

    public event ComboEventHandler? StreakChanged;

    private EventHandler<int>? milestoneReached;
    public event EventHandler<int> MilestoneReached
    {
        add
        {
            milestoneReached += value;
        }
        remove
        {
            milestoneReached -= value;
        }
    }

    private int streak = 0;
    private int lastMilestone = 0;
    private Random rnd = new();

    public void Start()
    {
        Console.WriteLine("Начало симуляции");

        for (int i = 0; i < rnd.Next(12, 17); i++)
        {
            // 70% шанс увеличить серию
            if (rnd.NextDouble() < 0.7)
                streak += rnd.Next(1, 4);
            else
                streak = 0;

            StreakChanged?.Invoke(this, streak);

            // Проверка рубежей
            int currentMilestone = (streak / 10) * 10;
            while (currentMilestone > lastMilestone && currentMilestone >= 10)
            {
                milestoneReached?.Invoke(this, lastMilestone + 10);
                lastMilestone += 10;
            }
        }

    }
}
