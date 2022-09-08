require_relative './album_repository'
# require_relative './artist_repository'
require_relative './database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)

  def initialize(database_name, io, album_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
  end

  def run
    @io.puts "Welcome to the music library manager!"
    @io.puts "What would you like to do?"
    @io.puts "1 - List all albums"
    @io.puts "2 - List all albums with release year"
    @io.puts "Enter your choice:"    
    input = @io.gets.chomp        
    if input == "1"
      print_all_albums
    elsif input == "2"
      print_all_albums_with_year
    end        
  end

  def print_all_albums
    result = @album_repository.all
    result.each do |album|
      @io.puts "#{album.id} - #{album.title}"
    end
    # binding.irb
  end
  
  def print_all_albums_with_year
    result = @album_repository.all
    result.each do |album|
      @io.puts "#{album.id} - #{album.title} - #{album.release_year}"
    end
  end  
end