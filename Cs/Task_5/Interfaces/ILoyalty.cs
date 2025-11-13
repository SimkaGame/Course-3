namespace Interfaces
{
    public interface ILoyalty
    {
        int LoyaltyPoints { get; set; }
        void AddPoints(int amount);
    }
}
