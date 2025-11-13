using System;

public delegate void MonitorHandler(ServerContext ctx);

public class MonitorPipeline
{
    public MonitorHandler? Handlers { get; set; }

    public void Run(ServerContext ctx)
    {
        Handlers?.Invoke(ctx);
    }
}
