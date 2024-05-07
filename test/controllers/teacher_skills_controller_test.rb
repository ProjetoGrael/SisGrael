require 'test_helper'

class Academic::TeacherSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher_skill = teacher_skills(:one)
  end

  test "should get index" do
    get teacher_skills_url
    assert_response :success
  end

  test "should get new" do
    get new_teacher_skill_url
    assert_response :success
  end

  test "should create teacher_skill" do
    assert_difference('TeacherSkill.count') do
      post teacher_skills_url, params: { teacher_skill: { subject_id: @teacher_skill.subject_id, teacher_id: @teacher_skill.teacher_id } }
    end

    assert_redirected_to teacher_skill_url(TeacherSkill.last)
  end

  test "should show teacher_skill" do
    get teacher_skill_url(@teacher_skill)
    assert_response :success
  end

  test "should get edit" do
    get edit_teacher_skill_url(@teacher_skill)
    assert_response :success
  end

  test "should update teacher_skill" do
    patch teacher_skill_url(@teacher_skill), params: { teacher_skill: { subject_id: @teacher_skill.subject_id, teacher_id: @teacher_skill.teacher_id } }
    assert_redirected_to teacher_skill_url(@teacher_skill)
  end

  test "should destroy teacher_skill" do
    assert_difference('TeacherSkill.count', -1) do
      delete teacher_skill_url(@teacher_skill)
    end

    assert_redirected_to teacher_skills_url
  end
end
