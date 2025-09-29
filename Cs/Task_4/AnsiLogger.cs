using System;

public class AnsiLogger : PlainLogger
{
    private string color_code;

    public string ColorCode
    {
        get => color_code;
        set
        {
            if (string.IsNullOrEmpty(value))
                throw new ArgumentException("Код цвета не может быть пустым.");
            color_code = value;
        }
    }

    public AnsiLogger(string name, int level, string prefix, string color) : base(name, level, prefix)
    {
        ColorCode = color;
    }

    public void SetColor(string color)
    {
        ColorCode = color;
    }

    public override string FormatMessage(string message)
    {
        string baseFormat = base.FormatMessage(message);
        return $"\x1b[{ColorCode}m{baseFormat}\x1b[0m";
    }
}