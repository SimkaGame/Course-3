public class ServerContext
{
    public int CpuLoad { get; set; }
    public bool AlertSent { get; set; }
    public bool Restarted { get; set; }

    public override string ToString()
    {
        return $"CPU: {CpuLoad}%, AlertSent: {AlertSent}, Restarted: {Restarted}";
    }
}
