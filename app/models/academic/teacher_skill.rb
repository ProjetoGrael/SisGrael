class Academic::TeacherSkill < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  validate :cant_repeate_teacher_skill

  private
    def cant_repeate_teacher_skill
      existing_teacher_skill = Academic::TeacherSkill.find_by(teacher_id: teacher_id, subject_id: subject_id)
      if existing_teacher_skill.present?
        errors.add('base', 'Este Educador já pode lecionar esta Disciplina.')
      end
    end
end
