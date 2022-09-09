require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'

DatabaseConnection.connect('student_directory_2')

cohort = CohortRepository.new
list = cohort.find_with_students(1)
puts list.join("\n")

list = cohort.find_with_students(2)
puts list.join("\n")
