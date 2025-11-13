namespace Interfaces
{
    public interface IOrder
    {
        string Customer { get; set; }
        int TotalCents { get; set; }

        void ApplyDiscount(int percent)
        {
            TotalCents = Math.Max(0, TotalCents - (TotalCents * percent / 100));
        }
    }
}
