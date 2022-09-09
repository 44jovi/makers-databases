require 'cohort'
require 'cohort_repository'
require 'student'


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
    it "returns array of students in cohort 'Sep'" do
      cohort = CohortRepository.new
      expect(cohort.find_with_students(1)).to eq ["Cohort: Sep - Student ID: 1 Student name: Wendy", "Cohort: Sep - Student ID: 3 Student name: Bob"]
    end
  end

end