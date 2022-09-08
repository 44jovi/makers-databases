require 'artist'
require 'artist_repository'

RSpec.describe AlbumRepository do  
  def reset_albums_table
    seed_sql = File.read('spec/seeds_artists.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table
  end

  describe "#all" do
    it "returns all artists (2 artists)" do
      repo = ArtistRepository.new
      artists = repo.all
      
      expect(artists.length).to eq 2

      expect(artists[0].id).to eq "1"
      expect(artists[0].name).to eq "Nirvana"
      expect(artists[0].genre).to eq "Grunge"
      expect(artists[1].id).to eq "2"
      expect(artists[1].name).to eq "Linkin Park"
      expect(artists[1].genre).to eq "Alternative Rock"
    end
  end

  describe "#find" do
    it "returns 1 artist ('Nirvana')" do
      repo = ArtistRepository.new
      artist = repo.find(1)
      
      expect(artist.id).to eq "1"
      expect(artist.name).to eq "Nirvana"
      expect(artist.genre).to eq "Grunge"
    end
  end
end