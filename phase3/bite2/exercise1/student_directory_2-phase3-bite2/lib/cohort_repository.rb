require_relative './cohort'
require_relative './student'


class CohortRepository
  
  def find_with_students(id)
    sql = "SELECT cohorts.id AS cohort_id, cohorts.name AS cohort_name,
           students.id AS student_id, students.name AS student_name
           FROM cohorts
           JOIN students
           ON students.cohort_id = cohorts.id
           WHERE cohorts.id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    result_set.map do |record|
      "Cohort: #{record["cohort_name"]} - Student ID: #{record["student_id"]} Student name: #{record["student_name"]}"      
    end

  end

end
