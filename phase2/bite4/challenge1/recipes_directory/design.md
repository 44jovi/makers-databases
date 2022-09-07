# Music Library - Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

<!-- If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`* -->

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep a list of all my recipes with their names.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep the average cooking time (in minutes) for each recipe.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to give a rating to each of the recipes (from 1 to 5).

```
# EXAMPLE

Table: recipes

Columns:
id | name | cooking_time | rating
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_recipes.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Burger', 30, 5);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Salad', 2, 1);


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_recipes_directory_test.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: recipess

# Model class
# (in lib/recipes.rb)
class Recipe
end

# Repository class
# (in lib/recipes_repository.rb)
class RecipeRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipes.rb)

class Recipe
  attr_accessor :id, :name, :cooking_time, :rating
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM recipes;

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
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all recipes

repo = RecipeRepository.new

recipes = repo.all

recipes.length # => 2

recipes[0].id # => 1
recipes[0].name # => 'Burger'
recipes[0].cooking_time # => '30'
recipes[0].rating # => '5'

recipes[1].id # => 2
recipes[1].name # => 'Salad'
recipes[1].cooking_time # => '2'
recipes[1].rating # => '1'


# 2
# Get a single recipe ("Burger")

repo = RecipeRepository.new

recipe = repo.find(1)

expect(recipe.id).to eq 1
expect(recipe.name).to eq "Burger"
expect(recipe.cooking_time).to eq "30"
expect(recipe.rating).to eq "5"


# 3
# Get a single recipe ("Salad")

repo = RecipeRepository.new

recipe = repo.find(2)

expect(recipe.id).to eq 2
expect(recipe.name).to eq "Salad"
expect(recipe.cooking_time).to eq "2"
expect(recipe.rating).to eq "1"

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes_directory_test.sql')
  user = ENV['PGUSER1'].to_s
  password = ENV['PGPASSWORD'].to_s
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test', user: user, password: password })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  recipe_repository = RecipeRepository.new
  expect(recipe_repository.all)to eq 0

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._