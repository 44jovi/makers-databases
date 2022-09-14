class PostRepository
  def find_with_comments(id)
    sql = 'SELECT posts.title,
                  posts.content AS post_content,
                  posts.author AS post_author,
                  posts.id,
                  comments.content AS comment_content,
                  comments.author AS comment_author,
                  comments.post_id,
                  comments.id AS comment_id
            FROM posts
            JOIN comments ON comments.post_id = posts.id
            WHERE posts.id = $1'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    post = Post.new(
      title: result.first['title'],
      content: result.first['post_content'],
      author: result.first['post_author']
    )
    post.id = result.first['id']
    result.each do |record|
      comment = Comment.new(
        content: record['comment_content'],
        author: record['comment_author'],
        post_id: record['post_id']
      )
      p record['comment_content']
      p comment 
      comment.id = record['comment_id']
      post.comments << comment
    end
    post
  end
end