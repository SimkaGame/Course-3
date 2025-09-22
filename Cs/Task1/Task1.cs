class Task1
{
    static void Main()
    {
        Person person = new Person("Дмитрий", 23, 181);

        person.Birthday(1);
        Console.WriteLine(person);
    }
}