using System;

public enum EventType
{
    Info,
    Warning,
    Alert,
    Critical
}

public class NotifyContext
{
    public bool IsQuietHours { get; set; }
    public bool IsVIPUser { get; set; }
    public bool HasCriticalFlag { get; set; }
}

public class PriorityCalculatorEnum
{
    public int GetPriority(EventType type, NotifyContext context)
    {
        int basePriority = type switch
        {
            EventType.Info => 1,
            EventType.Warning => 3,
            EventType.Alert => 5,
            EventType.Critical => 8,
            _ => throw new ArgumentOutOfRangeException(nameof(type))
        };

        int priority = basePriority;

        if (context.IsQuietHours)
            priority -= 2;

        if (context.IsVIPUser)
            priority += 2;

        if (priority < 1)
            priority = 1;

        if (context.HasCriticalFlag)
            priority += 3;

        return priority;
    }
}



public abstract class Event
{
    private readonly int basePriority;
    public int BasePriority => basePriority;

    protected Event(int basePriority)
    {
        this.basePriority = basePriority;
    }

    public virtual int GetPriority(NotifyContext context)
    {
        int priority = basePriority;

        if (context.IsQuietHours)
            priority -= 2;

        if (context.IsVIPUser)
            priority += 2;

        if (priority < 1)
            priority = 1;

        if (context.HasCriticalFlag)
            priority += 3;

        return priority;
    }
}

public class InfoEvent : Event
{
    public InfoEvent() : base(1) { }
}

public class WarningEvent : Event
{
    public WarningEvent() : base(3) { }
}

public class AlertEvent : Event
{
    public AlertEvent() : base(5) { }
}

public class CriticalEvent : Event
{
    public CriticalEvent() : base(8) { }

    public override int GetPriority(NotifyContext context)
    {
        return base.GetPriority(context);
    }
}

public class PriorityCalculatorOop
{
    public int GetPriority(Event ev, NotifyContext context)
    {
        return ev.GetPriority(context);
    }
}

