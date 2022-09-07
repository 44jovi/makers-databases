require 'database_connection'

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT * FROM recipes;'
    params = []
    result = DatabaseConnection.exec_params(sql, params)
    # binding.irb
    # Executes the SQL query:
    # ;

    # Returns an array of Recipe objects.
  end

  # Selecting a single recipe record
  # 1 argument 'id' as an integer
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM albums WHERE id = $1;

    # Returns a single Recipe object
  end
end