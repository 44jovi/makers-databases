require 'database_connection'

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT * FROM recipes;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    recipes = []

    result_set.each do |record|
      recipe = Recipe.new

      recipe.id = record["id"]
      recipe.name = record["name"]
      recipe.cooking_time = record["cooking_time"]
      recipe.rating = record["rating"]

      recipes << recipe
    end

    return recipes
  end

  def find(id)
    
  sql = "SELECT * FROM recipes WHERE id = $1;"
  sql_params = [id]
  result_set = DatabaseConnection.exec_params(sql, sql_params)  

  recipe = Recipe.new

  recipe.id = result_set[0]["id"]
  recipe.name = result_set[0]["name"]
  recipe.cooking_time = result_set[0]["cooking_time"]
  recipe.rating = result_set[0]["rating"]

  return recipe
  end
end