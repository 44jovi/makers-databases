require 'application'
require 'album'
require 'album_repository'


RSpec.describe Application do
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

  describe "#print_all_albums" do
    it "prints all albums" do      
      io = double :io
      repo = AlbumRepository.new
      app = Application.new('music_library_test', io, repo)
      expect(io).to receive(:puts).with("1 - Bleach")
      expect(io).to receive(:puts).with("2 - Hybrid Theory")
      app.print_all_albums
    end
  end

  describe "#print_all_albums_with_year" do
    it "prints all albums with release year" do      
      io = double :io
      repo = AlbumRepository.new
      app = Application.new('music_library_test', io, repo)
      expect(io).to receive(:puts).with("1 - Bleach - 1989")
      expect(io).to receive(:puts).with("2 - Hybrid Theory - 2000")
      app.print_all_albums_with_year
    end
  end

  describe "#run" do
    context "when menu 1 is chosen" do
      it "prints all album titles" do
        io = double :io
        repo = AlbumRepository.new
        app = Application.new('music_library_test', io, repo)
        expect(io).to receive(:puts).with("Welcome to the music library manager!")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all albums")
        expect(io).to receive(:puts).with("2 - List all albums with release year")
        expect(io).to receive(:puts).with("Enter your choice:")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("1 - Bleach")
        expect(io).to receive(:puts).with("2 - Hybrid Theory")
        app.run
      end
    end
  end
end