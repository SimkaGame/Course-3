using System;

class Employee
{
    public string Name { get; set; }
    public double Salary { get; set; }

    public Employee(string name, double salary)
    {
        Name = name;
        Salary = salary;
    }

    public virtual double CalculateBonus()
    {

        return Salary * 0.10;
    }
}
