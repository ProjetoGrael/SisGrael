module Academic::LessonsHelper
  def lesson_classroom_subject_value(lesson)
    if lesson.classroom_subject_id
      lesson.classroom_subject_id
    else
      params[:classroom_subject_id]
    end
  end

  def done_mensage lesson
    classrooms = lesson.classroom_subject.classroom.inscriptions.active
    #Fazendo com que, caso o aluno seja desistente ou evadido, não seja contado para aparecer a mensagem da pauta realizada ou não realizada
    #byebug
    classrooms = classrooms.where.not(student_status: "desisted").where.not(student_status: "evaded").where.not(student_status: nil)
    controller = true
    lesson.presences.each do |presence|
      #vejo se a inscrição da presença esta ativa
      #vejo se a situação ta nao lançada
      #vejo se aluno faz essa materia
      controller = false if classrooms.include?(presence.inscription) and presence.situation == "not_launched" and Academic::SubjectHistory.find_by(inscription_id: presence.inscription.id, classroom_subject_id: lesson.classroom_subject.id ).show?
    end
    return 'Chamada realizada.' if lesson.done || controller
    'Não preenchida.'
  end

  def can_show? presence
    out = true
    student_class_sub = Academic::StudentClassroomSubject.find_by(inscription_id: presence.inscription.id, classroom_subject_id: presence.lesson.classroom_subject.id)
    out = false if !student_class_sub.show && (student_class_sub.updated_at < presence.lesson.day || presence.situation == "not_launched")
    return out
  end

  def presence_options
    [
      ['Não Lançada', :not_launched],
      ['Presente', :present],
      ['Atrasado',:later],
      ['Ausente', :absent],
      ['Falta Justificada', :justified_absence]
    ]
  end

  def translate_presence_options(option)
    case option
    when "not_launched"
      return 'Não Lançada'
    when "present"
      return 'Presente'
    when "later"
      return 'Atrasado'
    when "absent"
      return 'Ausente'
    when "justified_absence"
      return 'Falta Justificada'
    else
      return ''
    end
  end

  def presence_evaluation
    [
      ['A - Vento Forte', 1],
      ['B - Vento Moderado', 2],
      ['C - Brisa', 3],
      ['D - Aragem', 4]
    ]
  end

  def evaded_or_desisted?(presence)
    out = true
    student_status = presence.student.inscriptions.where(classroom: Academic::Classroom.where(school_year: presence.lesson.classroom_subject.classroom.school_year)).first.student_status
    out = false unless student_status == 'evaded' || student_status == 'desisted'
    return out
  end

  def get_month_of_school_year classroom_subject
    school_year = classroom_subject.classroom.school_year
    start_day = school_year.start - school_year.start.day + 1.day
    months = []
    #Validação de todas as aulas do período anteriores ao dia de hoje
    while start_day <= school_year.final && start_day <= Time.now.to_date
      months.push(["Mês #{start_day.mon} de #{start_day.year}","#{start_day.year}-#{start_day.mon}"])
      start_day += 1.month
    end
    return months
  end
end
