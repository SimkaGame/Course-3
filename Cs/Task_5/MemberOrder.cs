using Interfaces;

public class MemberOrder : IOrder, ILoyalty
{
    private string _customer;
    private int _totalCents;
    private int _loyaltyPoints;
    private int _minBillCents;

    public string Customer
    {
        get => _customer;
        set => _customer = value;
    }

    public int TotalCents
    {
        get => _totalCents;
        set => _totalCents = value;
    }

    public int LoyaltyPoints
    {
        get => _loyaltyPoints;
        set => _loyaltyPoints = value;
    }

    public int MinBillCents
    {
        get => _minBillCents;
        set => _minBillCents = value;
    }

    public MemberOrder(string customer, int totalCents, int minBillCents)
    {
        _customer = customer;
        _totalCents = totalCents;
        _minBillCents = minBillCents;
        _loyaltyPoints = 0;
    }

    public void ApplyDiscount(int percent)
    {
        int newTotal = TotalCents - (TotalCents * percent / 100);
        TotalCents = Math.Max(newTotal, _minBillCents);
        AddPoints(TotalCents / 10);
    }

    public void AddPoints(int amount)
    {
        LoyaltyPoints += amount;
    }
}
