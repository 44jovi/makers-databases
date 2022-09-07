require_relative './album'

class AlbumRepository
  def all

    albums = []

    sql = "SELECT id, title, release_year FROM albums;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      album = Album.new

      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']

      albums << album
    end

    return albums
  end

  def find(id)


    sql = "SELECT id, title, release_year FROM albums WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    # could also do the below by first assigning result_set[0] to a variable 
    # e.g. 'record = result_set[0]' and then doing 'record["id"]', 'record["title"]' etc.
      album = Album.new      
      album.id = result_set[0]["id"]
      album.title = result_set[0]["title"]
      album.release_year = result_set[0]["release_year"]
    return album

  end
end

