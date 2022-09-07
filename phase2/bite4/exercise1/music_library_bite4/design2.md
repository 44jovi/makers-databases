# Music Library - Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

<!-- If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`* -->

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_albums.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year) VALUES ('Bleach', '1989');
INSERT INTO albums (title, release_year) VALUES ('Hybrid Theory', '2000');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_albums.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Album
  attr_accessor :id, :title, :release_year
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

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year FROM albums;

    # Returns an array of Album objects.
  end

  # Selecting a single albums record
  # 1 argument 'id' as an integer
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year FROM albums WHERE id = $1;

    # Returns a single Album object
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # => 2

albums[0].id # => 1
albums[0].title # => 'Bleach'
albums[0].release_year # => '1989'

albums[0].id # =>  2
albums[0].title # => 'Hybrid Theory'
albums[0].release_year # => '2000'

# 2
# Get a single album ("Bleach")

repo = AlbumRepository.new

album = repo.find(1)

expect(album.id).to eq 1
expect(album.title).to eq "Bleach"
expect(album.release_year).to eq "1989"

# 3
# Get a single album ("Hybrid Theory")

repo = AlbumRepository.new

album = repo.find(2)

expect(album.id).to eq 2
expect(album.title).to eq "Hybrid Theory"
expect(album.release_year).to eq "2000"

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  user = ENV['PGUSER1'].to_s
  password = ENV['PGPASSWORD'].to_s
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', user: user, password: password })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  album_repository = AlbumRepositor.new
  expect(album_repository.all)to eq 0

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._