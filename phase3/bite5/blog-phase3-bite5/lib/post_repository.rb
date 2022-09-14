class PostRepository
  def find_by_tag(tag)    

    sql = 'SELECT posts.id, posts.title
           FROM posts
           JOIN posts_tags ON posts_tags.post_id = posts.id
           JOIN tags ON posts_tags.tag_id = tags.id
           WHERE tags.name = $1;'    
    sql_params = [tag]
    result = DatabaseConnection.exec_params(sql, sql_params)  

    posts = []
    result.each do |record|
      post = Post.new
      post.id = record["id"]
      post.title = record["title"]
      posts << post
    end
    posts
  end
end



# class from earlier exercise:

# class PostRepository
#   def find_with_comments(id)
#     sql = 'SELECT posts.title,
#                   posts.content AS post_content,
#                   posts.author AS post_author,
#                   posts.id,
#                   comments.content AS comment_content,
#                   comments.author AS comment_author,
#                   comments.post_id,
#                   comments.id AS comment_id
#             FROM posts
#             JOIN comments 
#             ON comments.post_id = posts.id
#             WHERE posts.id = $1'
#     params = [id]
#     result = DatabaseConnection.exec_params(sql, params)
#     # binding.irb
#     post = Post.new(
#       content: result[0]['post_content'],
#       title: result[0]['title'],
#       author: result[0]['post_author']
#     )
#     post.id = result.first['id'] # another way of assigning the Post object attributes(?)
#     result.each do |record|
#       comment = Comment.new(
#         content: record['comment_content'],
#         author: record['comment_author'],
#         post_id: record['post_id']
#       )
#       p record['comment_content']
#       p comment 
#       comment.id = record['comment_id']
#       post.comments << comment
#     end
#     post
#   end
# end
