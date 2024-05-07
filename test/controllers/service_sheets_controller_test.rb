require 'test_helper'

class ServiceSheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_sheet = service_sheets(:one)
  end

  test "should get index" do
    get service_sheets_url
    assert_response :success
  end

  test "should get new" do
    get new_service_sheet_url
    assert_response :success
  end

  test "should create service_sheet" do
    assert_difference('ServiceSheet.count') do
      post service_sheets_url, params: { service_sheet: { deficiency_in_family: @service_sheet.deficiency_in_family, deficiency_in_family_text: @service_sheet.deficiency_in_family_text, deficiency_in_family_who: @service_sheet.deficiency_in_family_who, disabled_person: @service_sheet.disabled_person, dwell_time_address: @service_sheet.dwell_time_address, dwell_time_city: @service_sheet.dwell_time_city, family_income: @service_sheet.family_income, father: @service_sheet.father, food: @service_sheet.food, food_value: @service_sheet.food_value, has_documentation: @service_sheet.has_documentation, health_more_info: @service_sheet.health_more_info, internet: @service_sheet.internet, internet_value: @service_sheet.internet_value, iptu: @service_sheet.iptu, iptu_value: @service_sheet.iptu_value, kind_of_residence: @service_sheet.kind_of_residence, kind_of_residence_text: @service_sheet.kind_of_residence_text, light: @service_sheet.light, light_value: @service_sheet.light_value, marital_status: @service_sheet.marital_status, medication: @service_sheet.medication, medication: @service_sheet.medication, medication_text: @service_sheet.medication_text, medication_value: @service_sheet.medication_value, mother: @service_sheet.mother, notes: @service_sheet.notes, other: @service_sheet.other, other_text: @service_sheet.other_text, phone: @service_sheet.phone, phone_value: @service_sheet.phone_value, previously_resided_city: @service_sheet.previously_resided_city, protective_measures: @service_sheet.protective_measures, protective_measures_text: @service_sheet.protective_measures_text, psychiatric_treatment: @service_sheet.psychiatric_treatment, psychiatric_treatment_where: @service_sheet.psychiatric_treatment_where, receives_benefit: @service_sheet.receives_benefit, receives_benefit_wich: @service_sheet.receives_benefit_wich, referrals: @service_sheet.referrals, residence_status: @service_sheet.residence_status, residence_status_text: @service_sheet.residence_status_text, responsible_technician: @service_sheet.responsible_technician, room_number: @service_sheet.room_number, socio_educational_measure: @service_sheet.socio_educational_measure, socio_educational_measure_text: @service_sheet.socio_educational_measure_text, socio_educational_measure_when: @service_sheet.socio_educational_measure_when, student_id: @service_sheet.student_id, water: @service_sheet.water, water_value: @service_sheet.water_value, working_situation: @service_sheet.working_situation, working_situation_other: @service_sheet.working_situation_other } }
    end

    assert_redirected_to service_sheet_url(ServiceSheet.last)
  end

  test "should show service_sheet" do
    get service_sheet_url(@service_sheet)
    assert_response :success
  end

  test "should get edit" do
    get seedit_rvice_sheet_url(@service_sheet)
    assert_response :success
  end

  test "should update service_sheet" do
    patch service_sheet_url(@service_sheet), params: { service_sheet: { deficiency_in_family: @service_sheet.deficiency_in_family, deficiency_in_family_text: @service_sheet.deficiency_in_family_text, deficiency_in_family_who: @service_sheet.deficiency_in_family_who, disabled_person: @service_sheet.disabled_person, dwell_time_address: @service_sheet.dwell_time_address, dwell_time_city: @service_sheet.dwell_time_city, family_income: @service_sheet.family_income, father: @service_sheet.father, food: @service_sheet.food, food_value: @service_sheet.food_value, has_documentation: @service_sheet.has_documentation, health_more_info: @service_sheet.health_more_info, internet: @service_sheet.internet, internet_value: @service_sheet.internet_value, iptu: @service_sheet.iptu, iptu_value: @service_sheet.iptu_value, kind_of_residence: @service_sheet.kind_of_residence, kind_of_residence_text: @service_sheet.kind_of_residence_text, light: @service_sheet.light, light_value: @service_sheet.light_value, marital_status: @service_sheet.marital_status, medication: @service_sheet.medication, medication: @service_sheet.medication, medication_text: @service_sheet.medication_text, medication_value: @service_sheet.medication_value, mother: @service_sheet.mother, notes: @service_sheet.notes, other: @service_sheet.other, other_text: @service_sheet.other_text, phone: @service_sheet.phone, phone_value: @service_sheet.phone_value, previously_resided_city: @service_sheet.previously_resided_city, protective_measures: @service_sheet.protective_measures, protective_measures_text: @service_sheet.protective_measures_text, psychiatric_treatment: @service_sheet.psychiatric_treatment, psychiatric_treatment_where: @service_sheet.psychiatric_treatment_where, receives_benefit: @service_sheet.receives_benefit, receives_benefit_wich: @service_sheet.receives_benefit_wich, referrals: @service_sheet.referrals, residence_status: @service_sheet.residence_status, residence_status_text: @service_sheet.residence_status_text, responsible_technician: @service_sheet.responsible_technician, room_number: @service_sheet.room_number, socio_educational_measure: @service_sheet.socio_educational_measure, socio_educational_measure_text: @service_sheet.socio_educational_measure_text, socio_educational_measure_when: @service_sheet.socio_educational_measure_when, student_id: @service_sheet.student_id, water: @service_sheet.water, water_value: @service_sheet.water_value, working_situation: @service_sheet.working_situation, working_situation_other: @service_sheet.working_situation_other } }
    assert_redirected_to service_sheet_url(@service_sheet)
  end

  test "should destroy service_sheet" do
    assert_difference('ServiceSheet.count', -1) do
      delete service_sheet_url(@service_sheet)
    end

    assert_redirected_to service_sheets_url
  end
end
