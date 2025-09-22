class Person
{
    public string Name { get; set; }
    public int Ages { get; set; }
    public float Height { get; set; }

    public Person(string name, int ages, float height)
    {
        this.Name = name;
        this.Ages = ages;
        this.Height = height;
    }

    public void Birthday(int years)
    {
        if (years > 0)
        {
            Ages += years;
            Console.WriteLine($"{Name} исполнилось {Ages} года.");
        }
        else
        {
            Console.WriteLine($"Увеличение возраста должно быть положительным");
        }
    }

    public override string ToString()
    {
        return $"{Name} {Ages} года, рост {Height} см.";
    }
}