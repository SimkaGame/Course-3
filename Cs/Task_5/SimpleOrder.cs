using Interfaces;

public class SimpleOrder : IOrder
{
    private string _customer;
    private int _totalCents;

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

    public SimpleOrder(string customer, int totalCents)
    {
        _customer = customer;
        _totalCents = totalCents;
    }
}
