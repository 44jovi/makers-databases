require 'book'
require 'book_repository'
require 'database_connection'

RSpec.describe BookRepository do

  def reset_books_table
    seed_sql = File.read('spec/seeds_books.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test', user: user, password: password })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_books_table
  end

  it "returns all books" do
    repo = BookRepository.new

    books = repo.all

    expect(books.length).to eq 2

    expect(books[0].id).to eq "1"
    expect(books[0].title).to eq "Book One"
    expect(books[0].author_name).to eq "Author One"

    expect(books[1].id).to eq "2"
    expect(books[1].title).to eq "Book Two"
    expect(books[1].author_name).to eq "Author Two"

  end
end