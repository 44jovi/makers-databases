# Setting up a project

Learn to setup a Ruby project which connects to a database.

[A video demonstration is here.](https://www.youtube.com/watch?v=9pwchQJwc5Q).

## Initial setup

First, setup a new Ruby + RSpec project.

Then, follow the additional steps below.

```bash
# Add the pg gem
bundle add pg

# Create the DatabaseConnection class (see below)
touch lib/database_connection.rb

# Create the SQL seeds (see below)
touch spec/seeds.sql

# Create a "main" app.rb file for the program (see below)
touch app.rb
```

## The `DatabaseConnection` class

This class will act as thin wrapper around the `pg` gem - it is generic enough so you can reuse it in most of your Ruby projects using a database. It implements two methods:
  * one that connects the program to PostgreSQL — it only needs to be run once.
  * one that sends an SQL query to the database and gets the result set.

```ruby
# file: lib/database_connection.rb

require 'pg'

# This class is a thin "wrapper" around the
# PG library. We'll use it in our project to interact
# with the database using SQL.

class DatabaseConnection
  # This method connects to PostgreSQL using the 
  # PG gem. We connect to 127.0.0.1, and select
  # the database name given in argument.
  def self.connect(database_name)
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end

  # This method executes an SQL query 
  # on the database, providing some optional parameters
  # (you will learn a bit later about when to provide these parameters).
  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end
```

Call the `connect` method at the top of the `spec_helper.rb` file.

```ruby
# file: spec/spec_helper.rb

require 'database_connection'

# Make sure this connects to your test database
# (its name should end with '_test')
DatabaseConnection.connect('your_database_name_test')
```

## The SQL seeds

The contents of this file will vary for each project you'll work on. This file will contain all the SQL code needed to:
  * create the different tables your program needs.
  * insert some seed data into these tables so you can run your tests.

[The SQL seed file `music_database.sql`](../resources/seeds/music_database.sql) is an example of a seed file: it contains instructions to create the tables `albums` and `artists`, as well as some data to fill these tables.

When you write RSpec tests for Ruby program, you can then use the seed data loaded in the database.

This can be a single file, or many different files, perhaps one for each table.

## The main file

Create a file `app.rb` at the root of the project. This file will be the "entrypoint" of the program — it is the file you will execute with the `ruby` command.

Its job is to connect to the database using `DatabaseConnection.connect`, and then execute whatever logic the program needs to do.

In the example below, we simply execute a `SELECT` SQL query on the database and print the returned result set.

```ruby
# file: app.rb

require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title FROM albums;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end
```

Running the main file should output a list of records to the terminal.

You should now be all set for the next step!

## Troubleshooting

If you get a SQL error, use the error message to find out what went wrong — make sure the database name is correct, and that there are no syntax errors in the SQL query.

If you spent some time debugging this setup, and you're not sure of what the problem is, ask your coach.