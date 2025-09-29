using System;

class Program
{
    static void Main()
    {
        JsonLogger json = new JsonLogger("JsonLog", 2, true);
        json.WriteLog("Тест JSON");
        json.SwitchPrettyFormat();
        json.WriteLog("Компактный JSON");
        json.ChangeLevel(3);
        json.WriteLog("Новый уровень");

        PlainLogger plain = new PlainLogger("PlainLog", 0, "INFO");
        plain.WriteLog("Сообщение Plain");
        plain.SetPrefix("DEBUG");
        plain.WriteLog("Сообщение с новым префиксом");

        AnsiLogger ansi = new AnsiLogger("AnsiLog", 1, "ERROR", "31");
        ansi.WriteLog("Сообщение Красным");
        ansi.SetColor("34");
        ansi.WriteLog("Сообщение синим");

        try
        {
            json.ChangeLevel(-1);
        }
        catch (ArgumentException ex)
        {
            Console.WriteLine($"Ошибка: {ex.Message}");
        }

        try
        {
            ansi.LoggerName = "";
        }
        catch (ArgumentException ex)
        {
            Console.WriteLine($"Ошибка: {ex.Message}");
        }
    }
}