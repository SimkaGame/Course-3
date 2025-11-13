using System;

public class Program
{
    public static void Main()
    {
        var ctx = new ServerContext { CpuLoad = 97 };
        var pipeline = new MonitorPipeline();

        pipeline.Handlers += ServerHandlers.SendAlert;
        pipeline.Handlers += ServerHandlers.RestartService;

        // Добавление лямбда-обработчика — снижаем нагрузку на 10
        pipeline.Handlers += ctx =>
        {
            ctx.CpuLoad = Math.Max(0, ctx.CpuLoad - 10);
            Console.WriteLine($"Снижение нагрузки на 10. Текущая нагрузка: {ctx.CpuLoad}%");
        };


        Console.WriteLine("Первый запуск:");
        pipeline.Run(ctx);
        Console.WriteLine(ctx);
        Console.WriteLine();

        // Удаление обработчика перезапуска
        pipeline.Handlers -= ServerHandlers.RestartService;

        ctx.CpuLoad = 85;
        ctx.AlertSent = false;
        ctx.Restarted = false;

        Console.WriteLine("Второй запуск (обработчик перезапуска удалён):");
        pipeline.Run(ctx);
        Console.WriteLine(ctx);
    }
}
