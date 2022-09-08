require_relative './database_connection'
require_relative './artist'


class ArtistRepository
  def all
    sql = "SELECT * FROM artists;"
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record["id"]
      artist.name = record["name"]
      artist.genre = record["genre"]
      artists << artist
    end

    return artists
  end

  def find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    artist = Artist.new
    artist.id = record["id"]
    artist.name = record["name"]
    artist.genre = record["genre"]
    
    return artist    
  end
end