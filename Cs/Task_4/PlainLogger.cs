using System;

public class PlainLogger : Logger
{
    private string log_prefix;

    public string LogPrefix
    {
        get => log_prefix;
        set => log_prefix = value ?? "";
    }

    public PlainLogger(string name, int level, string prefix = "") : base(name, level)
    {
        LogPrefix = prefix;
    }

    public void SetPrefix(string prefix)
    {
        LogPrefix = prefix;
    }

    public override string FormatMessage(string message)
    {
        string baseFormat = base.FormatMessage(message);
        return string.IsNullOrEmpty(LogPrefix) ? baseFormat : $"{LogPrefix} {baseFormat}";
    }
}