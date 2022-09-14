require 'database_connection'
require 'post_repository'
require 'post'
require 'comment'

RSpec.describe PostRepository do
  def reset_tables 
    seed_sql = File.read('spec/seeds_test.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_2', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  describe '#find_by_tag' do
    it 'returns array of all posts for the given tag' do
      repo = PostRepository.new
      post = repo.find_by_tag("tag1")
      expect(post[0].id).to eq '1'
      expect(post[0].title).to eq 'Title 1'
      expect(post[1].id).to eq '3'
      expect(post[1].title).to eq 'Title One'
    end
  end  
end

# # tests from earlier exercise
# describe '#post_with_comments' do
# it 'returns Post with @comments' do
#   repo = PostRepository.new
#   post = repo.find_with_comments(1)
#   expect(post.title).to eq 'Day 1'
#   expect(post.content).to eq 'Awesome'
#   expect(post.author).to eq 'Rita'
#   expect(post.comments.length).to eq 2
#   expect(post.comments[0].content).to eq 'Agreed'
#   expect(post.comments[0].author).to eq 'Nadal'
#   expect(post.comments[0].id).to eq '1'
#   expect(post.comments[1].content).to eq '100%'
#   expect(post.comments[1].author).to eq 'Tomljanovic'
#   expect(post.comments[1].id).to eq '2'
# end
# end