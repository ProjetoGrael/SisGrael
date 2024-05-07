require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post students_url, params: { student: { address: @student.address, annotations: @student.annotations, birthdate: @student.birthdate, cep: @student.cep, city_id: @student.city_id, company: @student.company, cpf: @student.cpf, email: @student.email, ethnicity: @student.ethnicity, family_income: @student.family_income, father_cpf: @student.father_cpf, father_email: @student.father_email, father_name: @student.father_name, father_phone: @student.father_phone, grade: @student.grade, issuing_agency: @student.issuing_agency, issuing_date: @student.issuing_date, medication: @student.medication, mother_cpf: @student.mother_cpf, mother_email: @student.mother_email, mother_name: @student.mother_name, mother_phone: @student.mother_phone, name: @student.name, nationality: @student.nationality, naturalness: @student.naturalness, neighborhood_id: @student.neighborhood_id, nis: @student.nis, number_residents: @student.number_residents, phone: @student.phone, photo: @student.photo, project_indication: @student.project_indication, project_indication_description: @student.project_indication_description, responsible_cpf: @student.responsible_cpf, responsible_email: @student.responsible_email, responsible_name: @student.responsible_name, responsible_phone: @student.responsible_phone, rg: @student.rg, school_id: @student.school_id, school_shift: @student.school_shift, semester: @student.semester, sex: @student.sex, state_id: @student.state_id, sub_neighborhood: @student.sub_neighborhood, working: @student.working, year: @student.year } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { address: @student.address, annotations: @student.annotations, birthdate: @student.birthdate, cep: @student.cep, city_id: @student.city_id, company: @student.company, cpf: @student.cpf, email: @student.email, ethnicity: @student.ethnicity, family_income: @student.family_income, father_cpf: @student.father_cpf, father_email: @student.father_email, father_name: @student.father_name, father_phone: @student.father_phone, grade: @student.grade, issuing_agency: @student.issuing_agency, issuing_date: @student.issuing_date, medication: @student.medication, mother_cpf: @student.mother_cpf, mother_email: @student.mother_email, mother_name: @student.mother_name, mother_phone: @student.mother_phone, name: @student.name, nationality: @student.nationality, naturalness: @student.naturalness, neighborhood_id: @student.neighborhood_id, nis: @student.nis, number_residents: @student.number_residents, phone: @student.phone, photo: @student.photo, project_indication: @student.project_indication, project_indication_description: @student.project_indication_description, responsible_cpf: @student.responsible_cpf, responsible_email: @student.responsible_email, responsible_name: @student.responsible_name, responsible_phone: @student.responsible_phone, rg: @student.rg, school_id: @student.school_id, school_shift: @student.school_shift, semester: @student.semester, sex: @student.sex, state_id: @student.state_id, sub_neighborhood: @student.sub_neighborhood, working: @student.working, year: @student.year } }
    assert_redirected_to student_url(@student)
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
