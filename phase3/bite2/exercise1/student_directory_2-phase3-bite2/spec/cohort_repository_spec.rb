require 'cohort'
require 'cohort_repository'

RSpec.describe CohortRepository do  
  
  def reset_albums_table
    seed_sql = File.read('spec/seeds_test_data.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table
  end

  describe "#find_with_students" do
    it "" do
 
    end
  end



end