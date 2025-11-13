using System;
using System.Collections.Generic;

public class Recipe
{
    private List<Ingredient> ingredients = new List<Ingredient>();

    public string Id { get; }
    public string Title { get; }
    public CraftTier Tier { get; }

    public IReadOnlyList<Ingredient> Ingredients => ingredients.AsReadOnly();

    public Recipe(string id, string title, CraftTier tier)
    {
        if (string.IsNullOrWhiteSpace(id))
            throw new ArgumentException("Id не может быть пустым!");
        if (string.IsNullOrWhiteSpace(title))
            throw new ArgumentException("Название не может быть пустым!");

        Id = id;
        Title = title;
        Tier = tier;
    }

    public void AddIngredient(Ingredient ing)
    {
        if (ing == null)
            throw new ArgumentNullException("Ингредиент не null!");
        ingredients.Add(ing);
    }
}