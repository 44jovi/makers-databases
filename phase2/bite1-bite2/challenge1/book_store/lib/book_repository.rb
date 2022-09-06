class BookRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = "SELECT id, title, author_name FROM books;"
    result_set = DatabaseConnection.exec_params(sql, [])

    books = []

    result_set.each do |record|
      
      book = Book.new

      book.id = record["id"]
      book.title = record["title"]
      book.author_name = record["author_name"]

      books << book
    end

    return books

    # # alternative output for user readability and then use app.rb to execute:
    # result_set.each do |record|      
    #   book = Book.new

    #   p "#{record["id"]} - #{record["title"]} - #{record["author_name"]}"  
    # end

  end
end