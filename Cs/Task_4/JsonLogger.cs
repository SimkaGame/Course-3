using System;

public class JsonLogger : Logger
{
    private bool use_pretty_format;

    public bool UsePrettyFormat
    {
        get => use_pretty_format;
        set => use_pretty_format = value;
    }

    public JsonLogger(string name, int level, bool pretty = false) : base(name, level)
    {
        UsePrettyFormat = pretty;
    }

    public void SwitchPrettyFormat()
    {
        UsePrettyFormat = !UsePrettyFormat;
    }

    public override string FormatMessage(string message)
    {
        string json;
        if (UsePrettyFormat)
        {
            json = "{\n" +
                   $"  \"level\": {LogLevel},\n" +
                   $"  \"name\": \"{LoggerName}\",\n" +
                   $"  \"message\": \"{message}\"\n" +
                   "}";
        }
        else
        {
            json = $"{{ \"level\": {LogLevel}, \"name\": \"{LoggerName}\", \"message\": \"{message}\" }}";
        }
        return json;
    }
}