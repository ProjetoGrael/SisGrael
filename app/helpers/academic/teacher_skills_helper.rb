module Academic::TeacherSkillsHelper
  def teacher_value(teacher_skill)
    if teacher_skill.teacher_id.present?
      teacher_skill.teacher_id
    else
      params[:teacher_id]
    end
  end

  def teacher_skill_subject_options
    Academic::Subject.where(active: true).collect {|x| [x.name, x.id]}
  end
end
