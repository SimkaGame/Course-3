using System;

class Developer : Employee
{
    public bool KnowJavaScript { get; set; }

    public Developer(string name, double salary, bool knowJavaScript)
        : base(name, salary)
    {
        KnowJavaScript = knowJavaScript;
    }

    public override double CalculateBonus()
    {
        double bonus = base.CalculateBonus();
        if (KnowJavaScript)
        {
            bonus += Salary * 0.03;
        }
        return bonus;
    }
}
