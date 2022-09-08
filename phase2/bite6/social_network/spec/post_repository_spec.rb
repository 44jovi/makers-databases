require 'post'
require 'post_repository'

RSpec.describe  PostRepository do
  
  def reset_posts_table
    seed_sql = File.read('spec/seeds.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  describe '#all' do
    it 'returns array of all post objects' do
      repo = PostRepository.new 
      posts = repo.all 
      expect(posts.length).to eq 2
      expect(posts[0].title).to eq "Hello"
      expect(posts[0].content).to eq "How are you?"
      expect(posts[0].views).to eq "5"
      expect(posts[0].user_id).to eq "1"       
    end
  end

  describe '#find' do
    it 'returns single post object' do
      repo = PostRepository.new 
      posts = repo.find(1)
      expect(posts.title).to eq "Hello"
      expect(posts.content).to eq "How are you?"
      expect(posts.views).to eq "5"
      expect(posts.user_id).to eq "1"      
    end
  end

  describe '#create' do
    it 'inserts post record into posts table' do
      repo = PostRepository.new 
      post = Post.new
      post.title = "My first day"
      post.content = "Was awesome"
      post.views = "20"
      post.user_id = "1"
      repo.create(post)
      record = repo.find(3)
      expect(record.title).to eq post.title
      expect(record.content).to eq post.content
      expect(record.views).to eq post.views
      expect(record.user_id).to eq post.user_id   
    end
  end

  describe '#delete' do
    it 'deletes post record from posts table' do
      repo = PostRepository.new 
      post = repo.all[0]
      repo.delete(post)
      expect(repo.all.length).to eq 1     
    end
  end

  describe '#update' do
    it 'updates post record in posts table' do
      repo = PostRepository.new 
      post = repo.all[0]
      post.title = "Goodbye"
      repo.update(post)
      post_new = repo.find(post.id)
      expect(post_new.title).to eq "Goodbye"
      expect(post_new.content).to eq "How are you?"
      expect(post_new.views).to eq "5"
      expect(post_new.user_id).to eq "1"      
    end
  end
end