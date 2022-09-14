require 'pg'

class DatabaseConnection 
  def self.connect(dbname)
    @connection = PG.connect({host: '127.0.0.1', dbname: dbname})
  end

  def self.exec_params(query, params)
    if @connection.nil? 
      'Have you connected to the database by calling DatabaseConnection.connect ?'
    else 
      @connection.exec(query, params)
    end
  end
end