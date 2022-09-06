require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new

album_repository.all.each do |album|
  p album
end

# backup code

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end