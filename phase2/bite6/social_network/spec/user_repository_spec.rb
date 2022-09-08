require 'user'
require 'user_repository'

RSpec.describe UserRepository do
  
  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  describe '#all' do
    it 'returns array of all user objects' do
      repo = UserRepository.new 
      users = repo.all 
      expect(users.length).to eq 2
      expect(users[0].id).to eq "1"
      expect(users[0].name).to eq "Jovi"
      expect(users[0].email).to eq "jovi@jovi.com"
      expect(users[1].id).to eq "2"
      expect(users[1].name).to eq "Rita"
      expect(users[1].email).to eq "rita@rita.com"
    end
  end

  describe '#find' do
    it 'returns single user object' do
      repo = UserRepository.new 
      user = repo.find(1)
      expect(user.id).to eq "1"
      expect(user.name).to eq "Jovi"
      expect(user.email).to eq "jovi@jovi.com" 
    end
  end

  describe '#create' do
    it 'inserts user record into users table' do
      repo = UserRepository.new 
      user = User.new
      user.name = "D"
      user.email = "d@dmail.com"
      repo.create(user)
      record = repo.all.last
      expect(record.id).to eq "3"
      expect(record.name).to eq "D"
      expect(record.email).to eq "d@dmail.com" 
    end
  end

  describe '#delete' do
    it 'deletes user record from users table' do
      repo = UserRepository.new 
      user = repo.all[0]
      repo.delete(user)
      expect(repo.all.length).to eq 1     
    end
  end

  describe '#update' do
    it 'updates user record in users table' do
      repo = UserRepository.new 
      user = repo.all[0]
      user.name = "Novi"
      repo.update(user)
      user_new = repo.find(user.id)
      expect(user_new.name).to eq "Novi"
      expect(user_new.email).to eq "jovi@jovi.com"    
    end
  end
end