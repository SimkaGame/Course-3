public static class ServerHandlers
{
    // Отправка уведомления(условие)
    public static void SendAlert(ServerContext ctx)
    {
        if (ctx.CpuLoad > 80)
        {
            ctx.AlertSent = true;
            Console.WriteLine("Нагрузка превышает 80%.");
        }
    }

    public static void RestartService(ServerContext ctx)
    {
        if (ctx.CpuLoad > 95)
        {
            ctx.Restarted = true;
            Console.WriteLine("Перезапуск сервера: нагрузка превышает 95%.");
        }
    }
}
