using System;

public abstract class Logger
{
    private string logger_name;
    private int log_level;

    public string LoggerName
    {
        get => logger_name;
        set
        {
            if (string.IsNullOrEmpty(value))
                throw new ArgumentException("Имя логгера не может быть пустым.");
            logger_name = value;
        }
    }

    public int LogLevel
    {
        get => log_level;
        set
        {
            if (value < 0)
                throw new ArgumentException("Уровень лога > 0");
            log_level = value;
        }
    }

    protected Logger(string name, int level)
    {
        LoggerName = name;
        LogLevel = level;
    }

    public void WriteLog(string message)
    {
        Console.WriteLine(FormatMessage(message));
    }

    public void ChangeLevel(int new_level)
    {
        LogLevel = new_level;
    }

    public virtual string FormatMessage(string message)
    {
        return $"[{LogLevel}] {LoggerName}: {message}";
    }
}