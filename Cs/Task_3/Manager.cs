using System;

class Manager : Employee
{
    public int ManagementLevel { get; set; }

    public Manager(string name, double salary, int managementLevel)
        : base(name, salary)
    {
        ManagementLevel = managementLevel;
    }

    public override double CalculateBonus()
    {
        double bonus = base.CalculateBonus();
        if (ManagementLevel > 3)
        {
            bonus += Salary * 0.05;
        }
        return bonus;
    }
}
