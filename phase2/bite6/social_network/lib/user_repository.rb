require 'database_connection'

class UserRepository
  def all
    sql = 'SELECT * FROM users'
    results = DatabaseConnection.exec_params(sql, [])
    users = []
    results.each do |record|
      user = User.new
      user.id = record["id"]
      user.name = record["name"]
      user.email = record["email"]
      users << user
    end
    users
  end

  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1'
    params = [id]
    results = DatabaseConnection.exec_params(sql, params)
    record = results[0]
    user = User.new
    user.id = record["id"]
    user.name = record["name"]
    user.email = record["email"]
    user
  end

  def create(user)
    sql = 'INSERT INTO users (name, email) VALUES ($1, $2)'
    params = [user.name, user.email]
    results = DatabaseConnection.exec_params(sql, params)
  end

  def delete(user)
    sql = 'DELETE FROM users WHERE id = $1'
    params = [user.id]
    results = DatabaseConnection.exec_params(sql, params)
  end

  def update(user)
    sql = 'UPDATE users SET name = $1, email = $2;'
    params = [user.name, user.email]
    results = DatabaseConnection.exec_params(sql, params)
  end
end