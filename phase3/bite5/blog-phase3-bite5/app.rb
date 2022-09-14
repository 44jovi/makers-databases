require_relative 'lib/database_connection'
require_relative 'lib/post_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

post_repository = PostRepository.new

post_repository.all.each do |post|
  p post
end

# Return post with id 3
post = post_repository.find(3)
p "Post with id #{post.id} is: #{post.title} - #{post.release_year}"



# backup code

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end


post_repository = PostRepository.new 

posts = post_repository.find_by_tag('coding')

# The array `posts` should contain the following Post objects:
#
#  * 1	How to use Git
#  * 2	Ruby classes
#  * 3	Using IRB
#  * 7  SQL basics