require_relative "./recipe"

class RecipeRepository
  def all
    recipes = []

    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      recipe = Recipe.new

      recipe.id = record['id']
      recipe.name = record['name']
      recipe.average_cooking_time = record['average_cooking_time']
      recipe.rating = record['rating']

      recipes << recipe
    end
    return recipes
  end

  def find(id)
    sql_params = [id]
    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    recipe = Recipe.new

    recipe.id = record['id']
    recipe.name = record['name']
    recipe.average_cooking_time = record['average_cooking_time']
    recipe.rating = record['rating']

    return recipe
  end
end