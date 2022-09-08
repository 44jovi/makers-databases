require 'database_connection'

class PostRepository
  def all
    sql = 'SELECT * FROM posts;'
    result_set = DatabaseConnection.exec_params(sql,[])
    posts = []
    result_set.each do |record|
      post = Post.new
      post.id = record["id"]
      post.content = record["content"]
      post.title = record["title"]
      post.views = record["views"]
      post.user_id = record["user_id"]
      posts << post
    end
    posts
  end

  def find(id)
    # returns single post object
    sql = 'SELECT * FROM posts WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql,params)
    record = result_set[0]
    post = Post.new
    post.id = record["id"]
    post.content = record["content"]
    post.title = record["title"]
    post.views = record["views"]
    post.user_id = record["user_id"]
    post
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.user_id]
    result_set = DatabaseConnection.exec_params(sql,params)
  end

  def delete(post)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [post.id]
    result_set = DatabaseConnection.exec_params(sql,params)
  end

  def update(post)
    sql = 'UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4 WHERE id = $5;'
    params = [post.title, post.content, post.views, post.user_id, post.id]
    result_set = DatabaseConnection.exec_params(sql,params)
  end
end