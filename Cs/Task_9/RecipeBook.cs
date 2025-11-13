using System;
using System.Collections;
using System.Collections.Generic;

public class RecipeBook : IEnumerable<Recipe>
{
    private List<Recipe> recipes = new List<Recipe>();
    private Dictionary<string, Recipe> byId = new Dictionary<string, Recipe>();

    public int Count => recipes.Count;

    public Recipe this[int index]
    {
        get
        {
            if (index < 0 || index >= recipes.Count)
                throw new ArgumentOutOfRangeException("Неверный индекс!");
            return recipes[index];
        }
    }

    public Recipe this[string id]
    {
        get
        {
            if (id == null)
                throw new ArgumentNullException("Id не может быть null!");
            if (!byId.ContainsKey(id))
                throw new KeyNotFoundException("Рецепт '" + id + "' не найден!");
            return byId[id];
        }
    }

    public void Add(Recipe recipe)
    {
        if (recipe == null)
            throw new ArgumentNullException("Рецепт не может быть null!");
        if (byId.ContainsKey(recipe.Id))
            throw new ArgumentException("Рецепт с Id '" + recipe.Id + "' уже есть!");

        recipes.Add(recipe);
        byId[recipe.Id] = recipe;
    }

    public bool RemoveAt(int index)
    {
        if (index < 0 || index >= recipes.Count)
            return false;

        Recipe r = recipes[index];
        recipes.RemoveAt(index);
        byId.Remove(r.Id);
        return true;
    }

    public bool RemoveById(string id)
    {
        if (id == null || !byId.ContainsKey(id))
            return false;

        Recipe r = byId[id];
        byId.Remove(id);
        recipes.Remove(r);
        return true;
    }

    public IEnumerable<Recipe> EnumerateByTier(CraftTier minTier)
    {
        foreach (Recipe r in recipes)
        {
            if (r.Tier >= minTier)
                yield return r;
        }
    }

    public IEnumerator<Recipe> GetEnumerator()
    {
        return recipes.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }
}