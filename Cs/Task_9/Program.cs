using System;

class Program
{
    static void Main()
    {
        RecipeBook book = new RecipeBook();

        Recipe sword = new Recipe("sword1", "Меч", CraftTier.Advanced);
        sword.AddIngredient(new Ingredient("Железо", 3));
        sword.AddIngredient(new Ingredient("Дерево", 1));

        Recipe potion = new Recipe("potion1", "Зелье", CraftTier.Mythic);
        potion.AddIngredient(new Ingredient("Магия", 1));

        book.Add(sword);
        book.Add(potion);

        Console.WriteLine("Все рецепты:");
        foreach (Recipe r in book)
        {
            Console.WriteLine(r.Title + " [" + r.Tier + "]");
        }

        Console.WriteLine("\nТолько Мистические:");
        foreach (Recipe r in book.EnumerateByTier(CraftTier.Mythic))
        {
            Console.WriteLine("  -> " + r.Title);
        }
    }
}