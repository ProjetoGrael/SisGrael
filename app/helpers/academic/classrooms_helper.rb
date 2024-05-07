module Academic::ClassroomsHelper
    def current_classrooms_link
        if current_school_year.present?
            school_year_classrooms_path(current_school_year.id)
        else
            '#'
        end
    end

    def get_subject_history(inscription, classroom_subject)
        inscription.subject_histories.find_by(classroom_subject_id: classroom_subject.id)
    end 

    def get_presence_percentage(student, classroom_subject )
        number_class_present = student.presences.joins(:lesson).where(lessons: {classroom_subject_id: classroom_subject.id}, situation: 'absent').length
        total_class = student.presences.joins(:lesson).where(lessons: {classroom_subject_id: classroom_subject.id}).length
        return ((number_class_present.to_f/total_class)*100).round if total_class!= 0
        return 0
    end

    def get_number_of_justified_absence(student, classroom_subject )
        student.presences.joins(:lesson).where(lessons: {classroom_subject_id: classroom_subject.id}, situation: 'justified_absence').length
    end
    def council_options
        ['A','B','C','D']
    end

    def has_professionalized classroom
        return true if not classroom.subjects.where(professionalized: true).empty?
        return false
    end

    def is_environmental? classroom
        return true if not has_professionalized classroom and not classroom.subjects.where(environmental: true).empty?
        return false
    end
    def is_sport? classroom
        return true if not is_environmental? classroom and not classroom.subjects.where(sport: true).empty?
        return false
    end

    def pretty_inscription_situation(situation)
        hash = {
            studying: "Estudando",
            approved: "Aprovado",
            participant: "Participante",
            desisted: "Desistente",
            evaded: "Evadido",
            lack_of_lesson: "Faltou muitas aulas"
        }
        hash[situation.to_sym]
    end
    def put_zero_if_there_isnt time
        time = '0' + time.to_s if time.to_s.length == 1
        time
    end

    def enum_months(num)
        if(num == "01")
            return 'Janeiro'
        elsif(num == "02")
            return 'Fevereiro'
        elsif(num == "03")
            return 'Março'
        elsif(num == "04")
            return 'Abril'
        elsif(num == "05")
            return 'Maio'
        elsif(num == "06")
            return 'Junho'
        elsif(num == "07")
            return 'Julho'
        elsif(num == "08")
            return 'Agosto'
        elsif(num == "09")
            return 'Setembro'
        elsif(num == "10")
            return 'Outubro'
        elsif(num == "11")
            return 'Novembro'
        elsif(num == "12")
            return 'Dezembro'
        end
    end

    def self.translate_situation(situation)
        if(situation == "not_launched")
            return 'NL'
        elsif(situation == "present")
            return '-'
        elsif(situation == "later")
            return 'AT'
        elsif(situation == "absent")
            return 'AU'
        elsif(situation == "justified_absence")
            return 'FJ'
        else
            return ''
        end
    end

    #Função que conta a quantidade de faltas que um aluno teve em um mês
    def count_misses_month(month, presences)
        count = 0
        presences.each do |presence|
            #Se o aluno tiver falta ou falta justificada e também a aula for daquele mês, conta a presença...
            if ((presence.situation == 'absent' || presence.situation == 'justified_absence') && presence.lesson.day.to_s[5..6] <= month)
                count += 1
            end
        end
        return count
    end

    #Função que calcula a quantidade de presença do aluno até o momento
    def calculate_percentage_frequency(month, classroom_subject, amount_misses)
        amount_lessons = 0
        classroom_subject.lessons.each do |lesson|
            if(lesson.day.to_s[5..6] <= month)
                amount_lessons += 1
            end
        end
        amount_presences = amount_lessons - amount_misses
        if amount_lessons != 0
            percentage_presence = ((Float(amount_presences) / Float(amount_lessons)) * 100).round().to_s
        else
            percentage_presence = 0.to_s
        end
        return percentage_presence+"%"
    end

    def calculate_percentage_max_frequency(classroom_subject, amount_misses)
        amount_lessons = classroom_subject.lessons.length
        if amount_lessons != 0
            percentage_misses = (Float(amount_misses) / Float(amount_lessons)) * 100
        else
            percentage_misses = 0
        end
        percentage_max_frequency =  (100 - percentage_misses).round().to_s
        return percentage_max_frequency+"%"
    end

    def translate_date_lesson(day)
        year = day.to_s[0..3]
        month = day.to_s[5..6]
        day = day.to_s[8..9]
        return day+"/"+abbreviation_month(month)
    end

    def abbreviation_month(month)
        case month
        when "01"
            return 'Jan'
        when "02"
            return 'Fev'
        when "03"
            return 'Mar'
        when "04"
            return 'Abr'
        when "05"
            return 'Mai'
        when "06"
            return 'Jun'
        when "07"
            return 'Jul'
        when "08"
            return 'Ago'
        when "09"
            return 'Set'
        when "10"
            return 'Out'
        when "11"
            return "Nov"
        when "12"
            return "Dez"
        end
    end

    #Função que verifica e retorna os meses do periodo letivo
    def month_options(classroom)
        start_year = classroom.school_year.start.to_s[0..3].to_i
        final_year = classroom.school_year.final.to_s[0..3].to_i
        start_month = classroom.school_year.start.to_s[5..6].to_i
        final_month = classroom.school_year.final.to_s[5..6].to_i

        months = [
            ["Janeiro", 1],
            ["Fevereiro", 2],
            ["Março", 3],
            ["Abril", 4],
            ["Maio", 5],
            ["Junho", 6],
            ["Julho", 7],
            ["Agosto", 8],
            ["Setembro", 9],
            ["Outubro", 10],
            ["Novembro", 11],
            ["Dezembro", 12]
        ]
        array = []
        #Verificando se o periodo não tem mais de um ano
        if (classroom.school_year.final - classroom.school_year.start) > 365
            return months
        end
        #Se o Periodo Letivo começar e terminar no mesmo ano
        if start_month <= final_month
            months.each do |month|
                if month[1] >= start_month && month[1] <= final_month
                    array.push(month)
                end
            end
        #Caso o periodo letivo começe no 'final' de um ano e termine no outro ano
        else
            months.each do |month|
                if month[1] >= start_month || month[1] <= final_month
                    array.push(month)
                end
            end
        end 
        return array
    end

end
