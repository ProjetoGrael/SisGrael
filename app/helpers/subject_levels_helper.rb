module SubjectLevelsHelper

  def subject_level_subject_value(subject_level)
    if subject_level.subject_id.present?
      subject_level.subject_id
    else
      params[:subject_id]
    end
  end
end
