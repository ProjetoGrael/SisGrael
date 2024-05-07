module Academic::ClassroomSubjectsHelper
  def subject_options(class_sub)
    current_subject = class_sub.subject
    subjects = Academic::Subject.where(active: true).collect { |x| [x.name, x.id]}

    if current_subject.present? and !current_subject.active
      subjects.push([current_subject.name, current_subject.id])
    end
    
    return subjects
  end

  def subject_selected(class_sub)
    if class_sub.subject.present?
      class_sub.subject.id
    end
  end

  def classroom_value(class_sub)
    if class_sub.classroom_id.present?
      class_sub.classroom_id
    else
      params[:classroom_id]
    end
  end


  def get_classroom_subject(teacher)
    old_classroom_subject=[]
    current_classroom_subject=[]
    teacher.classroom_subjects.joins(:subject).order("name").each do |classroom_subject|
      unless classroom_subject.classroom.school_year == nil
        unless classroom_subject.classroom.school_year.status=='inactive'
          current_classroom_subject.push(classroom_subject)
        else
          old_classroom_subject.push(classroom_subject)
        end
      end
    end
    return old_classroom_subject, current_classroom_subject
  end

  def translate_date(date)
    day = date.to_s[8,2]
    month = date.to_s[5,2]
    return day + "/" + month
  end
end
