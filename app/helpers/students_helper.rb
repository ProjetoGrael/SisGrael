module StudentsHelper
    def student_school_name(student)
        student.school.name if student.school.present?
    end

    def student_school_year_options
        Academic::SchoolYear.where(status: :active).map {|el| [el.name, el.id]} 
    end

    def student_classroom_options
        []
    end

    def student_status_options
      [
        ["Ingressante", :ingressant], 
        ["Renovado", :renewed], 
        ["Desistente", :desisted],
        ["Reingressante", :reentry],
        ["Espera", :wait], 
        ["Evadido", :evaded]
      ]
    end

    def pretty_student_status(status)
        hash = {
            ingressant: "Ingressante",
            renewed: "Renovado",
            desisted: "Desistente",
            reentry: "Reingressante",
            wait: "Espera",
            evaded: "Evadido"
        }
        hash[status.to_sym]
    end

    def vocational_interview_destiny(student)
        if student.vocational_interview.present?
            student_vocational_interview_path(:id => student.vocational_interview, :student_id => student.id)
        else
            new_student_vocational_interview_path(student_id: student.id)
        end
    end

    def service_sheet_destiny(student)
        if student.service_sheet.present?
            student_service_sheet_path(student.service_sheet)
        else
            new_student_service_sheet_path(student)
        end
    end

    def city_options
        City.all.collect {|x| [x.name, x.id]}
    end

    def semester_options
      [["1º semestre", "01"], ["2º semestre", "02"]]
    end

    def neighborhood_options
        Neighborhood.all.collect {|x| [x.name, x.id]}
    end

    def school_options
        School.all.collect {|x| [x.name, x.id]}
    end

    def state_options
        State.all.collect {|x| [x.name, x.id]}
    end

    def city_options state
        City.where(state_id: state.id).all.collect {|x| [x.name, x.id]}
    end

    def neighborhood_options city
        Neighborhood.where(city_id: city.id).all.collect {|x| [x.name, x.id]}
    end

    def sex_options
        [["Masculino", :male], ["Feminino", :female], ["Outro", :other]]
    end

    def pretty_sex(sex)
        hash = {
            male: 'Masculino',
            female: 'Feminino',
            other: 'Outro'
        }
        hash[sex.to_sym]
    end

    def ethnicity_options
        Student.ethnicities.keys
    end

    def project_indication_options
        Student.project_indications.keys
    end

    def school_shift_options
        [["Manhã", :morning], ["Tarde", :afternoon], ["Noite", :night], ["Integral", :integral]]
    end

    def grade_options
        Student.grades.keys
    end

    def completed_options
        [["Cursando", :studying],["Concluido", :finished]]
    end

    def year_value(student)
        if student.year.present?
            student.year
        else
            Date.today.strftime('%Y')
        end
    end

    def age(birth)
        now = Time.now.utc.to_date
        now.year - birth.year - ((now.month > birth.month || (now.month == birth.month && now.day >= birth.day)) ? 0 : 1)
    end

    def months_of_age(birth)
        now = Time.now.utc.to_date
        return (now.month - birth.month) if (now.month >= birth.month)
        (12 - (birth.month - now.month)) 
    end

    def nationality_value(student)
        if student.nationality.present?
            student.nationality
        else
            'Brasileira'
        end
    end

    def family_income_options
        Student.family_incomes.keys
    end
    def consel_evaluate i
        i = i.to_i
        return "A" if i==1
        return "B" if i==2
        return "C" if i==3
        return "D" if i==4
        return i
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

    def remove_repeat_student inscriptions
        id = 0
        array =[]
         inscriptions.active.joins(:student).merge(Student.order(name: :asc)).each do |inscription|
           if inscription.student_id != id
             array.push(inscription)
             id = inscription.student_id
           end
         end
        array
    end
end
