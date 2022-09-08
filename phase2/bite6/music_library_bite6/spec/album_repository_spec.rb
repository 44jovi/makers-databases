require 'album'
require 'album_repository'

RSpec.describe AlbumRepository do  
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table
  end

    it "returns two albums" do
      repo = AlbumRepository.new
      albums = repo.all

      expect(albums.length).to eq 2

      expect(albums[0].id).to eq "1"
      expect(albums[0].title).to eq "Bleach"
      expect(albums[0].release_year).to eq "1989"
      expect(albums[1].id).to eq "2"
      expect(albums[1].title).to eq "Hybrid Theory"
      expect(albums[1].release_year).to eq "2000"
    end

    describe "#find" do
      it "returns 1 album ('Bleach')" do

        repo = AlbumRepository.new
        album = repo.find(1)

        expect(album.id).to eq "1"
        expect(album.title).to eq "Bleach"
        expect(album.release_year).to eq "1989"
      end
    
      it "returns 1 album ('Hybrid Theory')" do

        repo = AlbumRepository.new
        album = repo.find(2)

        expect(album.id).to eq "2"
        expect(album.title).to eq "Hybrid Theory"
        expect(album.release_year).to eq "2000"
      end
    end 

    describe "#create" do
    it "creates 1 album ('Dummy')" do

      album = Album.new
      album.title = "Dummy"
      album.release_year = "1994"

      repo = AlbumRepository.new

      repo.create(album)

      record = repo.all.last
      expect(record.title).to eq "Dummy"
      expect(record.release_year).to eq "1994"
      
    end
  

  end 

end