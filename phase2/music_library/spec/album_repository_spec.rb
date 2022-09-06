require 'album_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  user = 'jovik'
  password = ENV['PGPASSWORD'].to_s
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', user: user, password: password })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
end