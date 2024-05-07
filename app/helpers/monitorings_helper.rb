module MonitoringsHelper
    def mean_hash number
        return 'N/A' if number.nil?
        {1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D'}[number.to_i]
        
    end

    def translate_situation situation
        return 'Estudando' if situation == 'student'
        return 'Aprovado' if situation == 'approved'
        return 'Participante' if situation == 'participant'
        return 'Desistente' if situation == 'desisted'
        return 'Evadiu' if situation == 'evaded'
        return 'Reprovado por Falta' if situation == 'lack_of_lesson'
        return "Estudando" if situation == 'studying'
      end

    def sum_of_student classrooms
        sum = 0
        classrooms.each {|classroom| sum += classroom.inscriptions.length}
        sum
    end

    def sum_of_student_evaded classrooms
        sum = 0
        classrooms.each {|classroom| sum +=classroom.inscriptions.where(student_status: 'desisted').length}
        sum
    end

    def sum_of_student_active classrooms
        sum = 0
        classrooms.each {|classroom| sum += classroom.inscriptions.active.length}
        sum
    end

    def next_subject_name inscription
        if inscription.subject_level_id
            subject_level = Academic::SubjectLevel.find_by(id: inscription.subject_level_id)
            "#{subject_level&.subject&.name} - #{subject_level&.name}"
        elsif inscription.subject_id
            subject = Academic::Subject.find_by(id: inscription.subject_id)
            "#{subject&.name}"
        else
            "N/A"
        end
    end

    def teacher_name classroom
        if classroom.main_id.present?
            main_classroom_subject = classroom.classroom_subjects.find_by(id: classroom.main_id)
            main_classroom_subject.teacher.user.name    
        else
            "N/A"
        end
    end

    def final_counsel_percentage (subject_histories, grade)
      ((@subject_histories.where(final_counsel: grade).length.to_f * 100)/@subject_histories.length.to_f).round(2) 
    end
end
