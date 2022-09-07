require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT * FROM recipes;'
sql_params = []
result_set = DatabaseConnection.exec_params(sql, sql_params)

# Print out each record from the result set .
result_set.each do |record|
  p record
end

p "All recipes:"
result_set.each do |record|
  p "Recipe #{record["id"]}: #{record["name"]} - Cooking Time: #{record["cooking_time"]} - Rating: #{record["rating"]}/5"
end