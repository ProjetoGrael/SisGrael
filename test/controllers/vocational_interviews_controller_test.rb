require 'test_helper'

class VocationalInterviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vocational_interview = vocational_interviews(:one)
  end

  test "should get index" do
    get vocational_interviews_url
    assert_response :success
  end

  test "should get new" do
    get new_vocational_interview_url
    assert_response :success
  end

  test "should create vocational_interview" do
    assert_difference('VocationalInterview.count') do
      post vocational_interviews_url, params: { vocational_interview: { about_future_with_family: @vocational_interview.about_future_with_family, about_future_with_family_who: @vocational_interview.about_future_with_family_who, already_attended: @vocational_interview.already_attended, already_attended_difference: @vocational_interview.already_attended_difference, already_attended_difference_other: @vocational_interview.already_attended_difference_other, already_attended_to_other: @vocational_interview.already_attended_to_other, already_attended_to_other_text: @vocational_interview.already_attended_to_other_text, already_attended_when: @vocational_interview.already_attended_when, already_attended_which: @vocational_interview.already_attended_which, already_attended_which_other: @vocational_interview.already_attended_which_other, completed_by: @vocational_interview.completed_by, computer_use: @vocational_interview.computer_use, computer_use_other: @vocational_interview.computer_use_other, concluding_remarks: @vocational_interview.concluding_remarks, do_with_family: @vocational_interview.do_with_family, enrolled_in_the_course: @vocational_interview.enrolled_in_the_course, family_life: @vocational_interview.family_life, have_income: @vocational_interview.have_income, housing_condition: @vocational_interview.housing_condition, internet_surfer: @vocational_interview.internet_surfer, last_attended_educational_institution: @vocational_interview.last_attended_educational_institution, live_with: @vocational_interview.live_with, live_with_other: @vocational_interview.live_with_other, microsoft_office_knowledge: @vocational_interview.microsoft_office_knowledge, mobile: @vocational_interview.mobile, motivation: @vocational_interview.motivation, nautical_experience: @vocational_interview.nautical_experience, nautical_experience_text: @vocational_interview.nautical_experience_text, number_transports: @vocational_interview.number_transports, phone: @vocational_interview.phone, project_access: @vocational_interview.project_access, project_access_other: @vocational_interview.project_access_other, recreational_activities: @vocational_interview.recreational_activities, repetition: @vocational_interview.repetition, responsible_phone: @vocational_interview.responsible_phone, social_name: @vocational_interview.social_name, social_networks: @vocational_interview.social_networks, social_networks_text: @vocational_interview.social_networks_text, special_needs: @vocational_interview.special_needs, work: @vocational_interview.work, work_wich: @vocational_interview.work_wich, workers_in_family: @vocational_interview.workers_in_family, workers_in_family_other: @vocational_interview.workers_in_family_other, working_time: @vocational_interview.working_time } }
    end

    assert_redirected_to vocational_interview_url(VocationalInterview.last)
  end

  test "should show vocational_interview" do
    get vocational_interview_url(@vocational_interview)
    assert_response :success
  end

  test "should get edit" do
    get edit_vocational_interview_url(@vocational_interview)
    assert_response :success
  end

  test "should update vocational_interview" do
    patch vocational_interview_url(@vocational_interview), params: { vocational_interview: { about_future_with_family: @vocational_interview.about_future_with_family, about_future_with_family_who: @vocational_interview.about_future_with_family_who, already_attended: @vocational_interview.already_attended, already_attended_difference: @vocational_interview.already_attended_difference, already_attended_difference_other: @vocational_interview.already_attended_difference_other, already_attended_to_other: @vocational_interview.already_attended_to_other, already_attended_to_other_text: @vocational_interview.already_attended_to_other_text, already_attended_when: @vocational_interview.already_attended_when, already_attended_which: @vocational_interview.already_attended_which, already_attended_which_other: @vocational_interview.already_attended_which_other, completed_by: @vocational_interview.completed_by, computer_use: @vocational_interview.computer_use, computer_use_other: @vocational_interview.computer_use_other, concluding_remarks: @vocational_interview.concluding_remarks, do_with_family: @vocational_interview.do_with_family, enrolled_in_the_course: @vocational_interview.enrolled_in_the_course, family_life: @vocational_interview.family_life, have_income: @vocational_interview.have_income, housing_condition: @vocational_interview.housing_condition, internet_surfer: @vocational_interview.internet_surfer, last_attended_educational_institution: @vocational_interview.last_attended_educational_institution, live_with: @vocational_interview.live_with, live_with_other: @vocational_interview.live_with_other, microsoft_office_knowledge: @vocational_interview.microsoft_office_knowledge, mobile: @vocational_interview.mobile, motivation: @vocational_interview.motivation, nautical_experience: @vocational_interview.nautical_experience, nautical_experience_text: @vocational_interview.nautical_experience_text, number_transports: @vocational_interview.number_transports, phone: @vocational_interview.phone, project_access: @vocational_interview.project_access, project_access_other: @vocational_interview.project_access_other, recreational_activities: @vocational_interview.recreational_activities, repetition: @vocational_interview.repetition, responsible_phone: @vocational_interview.responsible_phone, social_name: @vocational_interview.social_name, social_networks: @vocational_interview.social_networks, social_networks_text: @vocational_interview.social_networks_text, special_needs: @vocational_interview.special_needs, work: @vocational_interview.work, work_wich: @vocational_interview.work_wich, workers_in_family: @vocational_interview.workers_in_family, workers_in_family_other: @vocational_interview.workers_in_family_other, working_time: @vocational_interview.working_time } }
    assert_redirected_to vocational_interview_url(@vocational_interview)
  end

  test "should destroy vocational_interview" do
    assert_difference('VocationalInterview.count', -1) do
      delete vocational_interview_url(@vocational_interview)
    end

    assert_redirected_to vocational_interviews_url
  end
end
