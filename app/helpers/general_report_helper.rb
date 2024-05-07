module GeneralReportHelper
    ##########################################################################################
    ###FUNÇÕES GERAIS###
    def get_percent_general_report(parcial, total)
        if(total > 0)
            return (100 * parcial.to_f / total).round(2)
        else
            return 0
        end
    end

    def division_with_validation_zero(parcial, total)
        if total != 0
            return (parcial / total)
        else 
            return 0
        end
    end
  
    def remove_number_equals array
        id_base = 0
        array_aux = []
        array.sort_by{|number| number}.each do |id|
            if id_base != id
                array_aux.push(id)
                id_base = id
            end
        end
        return array_aux
    end
  
    def print_school_year_name(school_year)
        if school_year != nil
            school_year.name
        else 
            "-"
        end
    end

    def validate_info_different_nil(info)
        if(info != nil)
            return yield info
        else
            return "-"
        end
    end
    ##########################################################################################
  

    ##########################################################################################
    ###FUNÇÕES general_data###
    def general_data_school_year_capacity(school_year)
        validate_info_different_nil(school_year) do |school_year|    
            return school_year.capacity
        end
    end
  
    def general_data_school_year_occupied_vacancies(school_year)
        validate_info_different_nil(school_year) do |school_year|
            return school_year.students.length
        end
    end
  
    def general_data_school_year_idle_vacancies(school_year)
        validate_info_different_nil(school_year) do |school_year|    
            vacancies = school_year.capacity - school_year.students.length
            if vacancies < 0
                return 0
            else
                return vacancies
            end
        end
    end
  
    def general_data_number_of_matriculate_students(school_year)
        validate_info_different_nil(school_year) do |school_year|    
            return remove_repeat_student(Academic::Inscription.all.joins(:classroom).where("school_year_id = ?", school_year.id)).length.to_s
        end
    end   
  
    def general_data_number_of_registred_students(school_year)
        validate_info_different_nil(school_year) do |school_year|
            start = school_year.start
            final = school_year.final
            return Student.where("created_at > ?", start).where("created_at < ?", final).length
        end
    end
    #*
    def general_data_number_of_matriculate_students_per_program(school_year)
        if school_year != nil
            count_professionalized = 0
            count_sport = 0
            count_environmental = 0
        
            array_professionalized = []
            array_sport = []
            array_environmental = []
        
            school_year.classrooms.each do |classroom|
                if classroom.professionalized?
                    classroom.students.each do |student|
                        array_professionalized.push(student.id)
                    end
                elsif classroom.sport?
                    classroom.students.each do |student|
                        array_sport.push(student.id)
                    end
                elsif classroom.environmental?
                    classroom.students.each do |student|
                        array_environmental.push(student.id)
                    end
                end
            end
        
            count_professionalized = remove_number_equals(array_professionalized).length
            count_sport = remove_number_equals(array_sport).length
            count_environmental = remove_number_equals(array_environmental).length
        
            return [count_professionalized, count_sport, count_environmental]
        else
            return ["-", "-", "-"]
        end
    end
  
    def general_data_number_of_matriculate_students_per_subject(subject, school_year)
        validate_info_different_nil(school_year) do |school_year|
            array_students_on_subject = []
        
            school_year.classrooms.each do |classroom|
                classroom.classroom_subjects.each do |cs|
                    if cs.subject == subject
                        array_students_on_subject += classroom.students
                    end
                end
            end
            return remove_number_equals(array_students_on_subject).length.to_s
        end
    end
  
    def general_data_number_of_classrooms(school_year)
        validate_info_different_nil(school_year) do |school_year|
            return school_year.classrooms.length.to_s
        end
    end
  
    def general_data_number_active_students(school_year)
        validate_info_different_nil(school_year) do |school_year|
            return remove_repeat_student(school_year.inscriptions.active).length.to_s
        end
    end
    #*
    def general_data_number_of_active_students_per_program(school_year)
        if school_year != nil
            count_professionalized = 0
            count_sport = 0
            count_environmental = 0
  
            array_professionalized = []
            array_sport = []
            array_environmental = []
  
            school_year.classrooms.each do |classroom|
                if classroom.professionalized?
                    classroom.inscriptions.each do |inscription|
                        array_professionalized.push(inscription.student.id) if inscription.active
                    end
                elsif classroom.sport?
                    classroom.inscriptions.each do |inscription|
                        array_sport.push(inscription.student.id) if inscription.active
                    end
                elsif classroom.environmental?
                    classroom.inscriptions.each do |inscription|
                        array_environmental.push(inscription.student.id) if inscription.active
                    end
                end
            end
  
            count_professionalized = remove_number_equals(array_professionalized).length
            count_sport = remove_number_equals(array_sport).length
            count_environmental = remove_number_equals(array_environmental).length
  
            return [count_professionalized, count_sport, count_environmental]
        else
            return ["-", "-", "-"]
        end
    end
  
    def general_data_number_of_active_students_per_subject(subject, school_year)
        validate_info_different_nil(school_year) do |school_year|
            array_students_on_subject = []
      
            school_year.classrooms.each do |classroom|
                classroom.classroom_subjects.each do |cs|
                    if cs.subject == subject
                        classroom.inscriptions.each do |inscription|
                            array_students_on_subject.push(inscription.student.id) if inscription.active
                        end
                    end
                end
            end
            return remove_number_equals(array_students_on_subject).length.to_s
        end
    end
  
    def general_data_number_evaded_students(school_year)
        validate_info_different_nil(school_year) do |school_year|
            return remove_repeat_student(school_year.inscriptions.where(student_status: "evaded")).length.to_s
        end
    end
    #*
    def general_data_number_of_evaded_students_per_program(school_year)
        if school_year != nil
            count_professionalized = 0
            count_sport = 0
            count_environmental = 0
    
            array_professionalized = []
            array_sport = []
            array_environmental = []
  
            school_year.classrooms.each do |classroom|
                if classroom.professionalized?
                    classroom.inscriptions.each do |inscription|
                        array_professionalized.push(inscription.student.id) if inscription.student_status == "evaded"
                    end
                elsif classroom.sport?
                    classroom.inscriptions.each do |inscription|
                        array_sport.push(inscription.student.id) if inscription.student_status == "evaded"
                    end
                elsif classroom.environmental?
                    classroom.inscriptions.each do |inscription|
                        array_environmental.push(inscription.student.id) if inscription.student_status == "evaded"
                    end
                end
            end
  
            count_professionalized = remove_number_equals(array_professionalized).length
            count_sport = remove_number_equals(array_sport).length
            count_environmental = remove_number_equals(array_environmental).length

            return [count_professionalized, count_sport, count_environmental]
        else
            return ["-", "-", "-"]
        end
    end
  
    def general_data_number_of_evaded_students_per_subject(subject, school_year)
        validate_info_different_nil(school_year) do |school_year|
            array_students_on_subject = []
      
            school_year.classrooms.each do |classroom|
                classroom.classroom_subjects.each do |cs|
                    if cs.subject == subject
                        classroom.inscriptions.each do |inscription|
                            array_students_on_subject.push(inscription.student.id) if inscription.student_status == "evaded"
                        end
                    end
                end
            end
            return remove_number_equals(array_students_on_subject).length.to_s
        end
    end
  
    def general_data_number_renewed_students(school_year)
        validate_info_different_nil(school_year) do |school_year|
            return remove_repeat_student(school_year.inscriptions.where(student_status: "renewed")).length.to_s
        end
    end
    ##########################################################################################
 
    ##########################################################################################
    ###FUNÇÕES council###
    #*
    def council_monitoring_get_percent_grade(school_year)
        if(school_year != nil)
        sub_hist_len = 0
        grade_a = 0
        grade_b = 0
        grade_c = 0 
        grade_d = 0
  
        school_year.classrooms.each do |classroom|
            classroom.classroom_subjects.each do |cs|
                sub_hist_len += cs.subject_histories.where(inscription: Academic::Inscription.active).length
                grade_a += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 1).length
                grade_b += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 2).length
                grade_c += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 3).length
                grade_d += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 4).length
            end
        end
  
        grade_a = get_percent_general_report(grade_a, sub_hist_len)
        grade_b = get_percent_general_report(grade_b, sub_hist_len)
        grade_c = get_percent_general_report(grade_c, sub_hist_len)
        grade_d = get_percent_general_report(grade_d, sub_hist_len)
  
        return [grade_a.to_s + "%", grade_b.to_s + "%", grade_c.to_s + "%", grade_d.to_s + "%"]
    else
        return ["-", "-", "-", "-"]
    end
  end
  
    def council_monitoring_get_percent_situation(school_year, string, insc_len)
        validate_info_different_nil(school_year) do |school_year|
            return get_percent_general_report(school_year.inscriptions.where(situation: string).length, insc_len).to_s + "%"
        end
    end
  
    def council_monitoring_get_percent_next_course(school_year, insc_len)
        validate_info_different_nil(school_year) do |school_year|
            return get_percent_general_report(school_year.inscriptions.where.not(subject_level_id: nil).length, insc_len).to_s + "%"
        end
    end
    ##########################################################################################
  
    ##########################################################################################
    ###FUNÇÕES instructor####*
    def instructor_per_centage_grades(instructor, school_year)
        if(school_year != nil)
            grade_a = 0
            grade_b = 0
            grade_c = 0 
            grade_d = 0
            sub_hist_len = 0
        
            instructor.classroom_subjects.where(classroom: Academic::Classroom.where(school_year: school_year)).each do |cs|
                sub_hist_len += cs.subject_histories.where(inscription: Academic::Inscription.active).length
                grade_a += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 1).length
                grade_b += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 2).length
                grade_c += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 3).length
                grade_d += cs.subject_histories.where(inscription: Academic::Inscription.active).where(final_counsel: 4).length
            end
        
            grade_a = get_percent_general_report(grade_a, sub_hist_len)
            grade_b = get_percent_general_report(grade_b, sub_hist_len)
            grade_c = get_percent_general_report(grade_c, sub_hist_len)
            grade_d = get_percent_general_report(grade_d, sub_hist_len)
        
            return [grade_a.to_s + "%", grade_b.to_s + "%", grade_c.to_s + "%", grade_d.to_s + "%"]
        else
            return ["-", "-", "-", "-"]
        end
    end
    #*
    def instructor_per_centage_presences(instructor, school_year)
        if(school_year != nil)
            number_of_presences = 0
            absent = 0
            later = 0
            present = 0
            justified_absence = 0
            not_launched = 0
        
            instructor.classroom_subjects.where(classroom: Academic::Classroom.where(school_year: school_year)).each do |cs|
                array = []
                cs.classroom.inscriptions.each {|inscription| array.push(inscription.student.id)}
                cs.lessons.where('day < ?', Time.now).each do |lesson|
                    lesson.presences.each do |presence|
                        number_of_presences += 1 if array.include?(presence.student.id)
                        absent += 1 if array.include?(presence.student.id) && presence.situation == "absent"
                        later += 1 if array.include?(presence.student.id) && presence.situation == "later"
                        present += 1 if array.include?(presence.student.id) && presence.situation == "present"
                        justified_absence += 1 if array.include?(presence.student.id) && presence.situation == "justified_absence"
                        not_launched += 1 if array.include?(presence.student.id) && presence.situation == "not_launched"
                    end
                end
            end
        
            absent = get_percent_general_report(absent, number_of_presences)
            later = get_percent_general_report(later, number_of_presences)
            present = get_percent_general_report(present, number_of_presences)
            justified_absence = get_percent_general_report(justified_absence, number_of_presences)
            not_launched = get_percent_general_report(not_launched, number_of_presences)
        
            return [absent.to_s + "%", later.to_s + "%", present.to_s + "%", justified_absence.to_s + "%", not_launched.to_s + "%"]
        else
            return ["-", "-", "-", "-", "-"]
        end
    end
  
    #Função que calcula a porcentagem de alunos com mais de 25% de faltas de um professor
    def instructor_per_centage_absents_more_than_25(instructor, school_year)
        validate_info_different_nil(school_year) do |school_year|
            number_absents_more_than_25 = 0
            number_students = 0
        
            total_presences = 0
            total_absents = 0
        
            #Pega todos os cursos do professor
            instructor.classroom_subjects.where(classroom: Academic::Classroom.where(school_year: school_year)).each do |cs|
                #Pega todos os alunos não evadidos e nem desistentes do professor
                inscriptions = cs.classroom.inscriptions.where("student_status != ?", "evaded").where("student_status != ?", "desisted")
                #Para cada aluno, verifica se ele tem mais de 25% de falta
                inscriptions.each do |inscription|
                    number_students += 1
                    total_presences = Academic::Presence.where(lesson: Academic::Lesson.where(classroom_subject: cs).where('day < ?', Time.now)).where(student: inscription.student).length
                    total_absents = Academic::Presence.where(lesson: Academic::Lesson.where(classroom_subject: cs).where('day < ?', Time.now)).where(student: inscription.student).where(situation: "absent").length
                    if(total_presences > 0)
                        if((total_absents.to_f / total_presences) > 0.25 )
                            number_absents_more_than_25 += 1
                        end
                    end
                end
            end
            return get_percent_general_report(number_absents_more_than_25, number_students).to_s + "%"
        end
    end
  
    #Função que calcula a porcentagem de alunos com mais de 75% de presença de um professor
    def instructor_per_centage_presents_more_than_75(instructor, school_year)
        validate_info_different_nil(school_year) do |school_year|
            number_presents_more_than_75 = 0
            number_students = 0
        
            total_presences = 0
            total_presents = 0
        
            #Pega todos os cursos do professor
            instructor.classroom_subjects.where(classroom: Academic::Classroom.where(school_year: school_year)).each do |cs|
                #Pega todos os alunos não evadidos e nem desistentes do professor
                inscriptions = cs.classroom.inscriptions.where("student_status != ?", "evaded").where("student_status != ?", "desisted")
                #Para cada aluno, verifica se ele tem mais de 75% de presença
                inscriptions.each do |inscription|
                    number_students += 1
                    total_presences = Academic::Presence.where(lesson: Academic::Lesson.where(classroom_subject: cs).where('day < ?', Time.now)).where(student: inscription.student).length
                    total_presents = Academic::Presence.where(lesson: Academic::Lesson.where(classroom_subject: cs).where('day < ?', Time.now)).where(student: inscription.student).where(situation: "present").length
                    if(total_presences > 0)
                        if((total_presents.to_f / total_presences) > 0.75 )
                            number_presents_more_than_75 += 1
                        end
                    end
                end
            end
            return get_percent_general_report(number_presents_more_than_75, number_students).to_s + "%"
        end
    end
    ##########################################################################################

    ##########################################################################################
    ###FUNÇÕES social_service###
    def count_students_with_service_sheet(students)
        if students != nil
            count = 0
            students.each do |student|
                if student.service_sheet != nil
                    count += 1
                end
            end
            return count
        else
            return 0
        end
    end
    
    def count_students_with_vocational_interview(students)
        if students != nil
            count = 0
            students.each do |student|
                if student.vocational_interview != nil
                    count += 1
                end
            end
            return count
        else
            return 0
        end
    end
    
    def social_service_monitoring_per_cent_beneficiary_assistencial_programs(students)
        validate_info_different_nil(students) do |students|
            count = 0
                
            #Se o aluno tiver algum programa assistencial, adiciona na contagem.
            students.each do |student|
                if student.assistance_programs.any?
                    count += 1
                end
            end
    
            return get_percent_general_report(count, count_students_with_service_sheet(students)).to_s + "%"
        end
    end
    
    def mean_all_family_income(students)
        validate_info_different_nil(students) do |students|
            sum = 0
            count_students = 0
        
            students.each do |student|
                if student.service_sheet != nil
        
                    count_students += 1
            
                    total_income = 0.0
                    student.family_members.each do |fm|
                        if fm.income != nil
                            total_income += fm.income
                        end
                    end
            
                    #adicionando o rendimento do estudante
                    if student.service_sheet.salary != nil   
                        total_income += salary
                    end
            
                    #Soma um por causa do próprio aluno
                    mean = total_income / (student.family_members.length + 1)
            
                    sum += mean
                end
            end
        
            #Validação para não dividir por 0
            return "R$ " + division_with_validation_zero(Float(sum), count_students).round(2).to_s
        end
    end
    
    def social_service_labor_market_students(students)
        validate_info_different_nil(students) do |students|
            count = 0
            students.each do |student|
                if student.labor_markets.any?
                    count += 1
                end
            end
            
            return count.to_s
        end
    end
    
    def social_service_labor_market_students_by_sex(sex, students)
        validate_info_different_nil(students) do |students|
            count = 0
            students.where(sex: sex).each do |student|
                if student.labor_markets.any?
                    count += 1
                end
            end
            
            return count.to_s
        end
    end
    
    def social_service_per_cent_transportation_students(transportation, students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.project_access == transportation
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_motivation_students(motivation, students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.motivation == motivation
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_have_income_students(bool, students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.have_income == bool
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_father_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.father_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_mother_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                total += 1
                parcial += 1 if student.vocational_interview.mother_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_step_father_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                total += 1
                parcial += 1 if student.vocational_interview.step_father_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_step_mother_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.step_mother_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_brothers_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.brothers_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_grandparents_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.grandparents_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    def social_service_per_cent_other_reponsible_for_income_family(students)
        validate_info_different_nil(students) do |students|
            parcial = 0
            total = 0
            students.each do |student|
                if student.vocational_interview != nil
                    total += 1
                    parcial += 1 if student.vocational_interview.other_works
                end
            end
        
            return get_percent_general_report(parcial, total).to_s + "%";
        end
    end
    
    ##########################################################################################
    
    ##########################################################################################
    ###FUNÇÕES student_profile###
    def student_profile_per_cent_students_per_gender(gender, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(sex: gender).length
            total = students.where.not(sex: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_age(age_start, age_final, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where("birthdate <= ?", Date.today - age_start.year).where("birthdate > ?", Date.today - (age_final+1).year).length
            total = students.where.not(birthdate: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_gender_and_per_age(gender, age_start, age_final, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(sex: gender).where("birthdate <= ?", Date.today - age_start.year).where("birthdate > ?", Date.today - (age_final+1).year).length
            total = students.where.not(sex: nil).where.not(birthdate: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_ethnicity(ethnicity, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(ethnicity: ethnicity).length
            total = students.where.not(ethnicity: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_city(city, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(city: city).length
            total = students.where.not(city: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_neighborhood(neighborhood, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(neighborhood: neighborhood).length
            total = students.where.not(neighborhood: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_school_shift(school_shift, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(school_shift: school_shift).length
            total = students.where.not(school_shift: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_per_grade(grade, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(grade: grade).length
            total = students.where.not(grade: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_studying(bool_studying, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(completed: bool_studying).length
            total = students.where.not(completed: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_working(bool_working, students)
        validate_info_different_nil(students) do |students|
            total = 0
            parcial = 0
            students.each do |student|
                if student.service_sheet != nil
                    total += 1 if student.service_sheet.current_working != nil
                    parcial += 1 if student.service_sheet.current_working == bool_working
                end
            end
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_project_indication(project_indication, students)
        validate_info_different_nil(students) do |students|
            parcial = students.where(project_indication: project_indication).length
            total = students.where.not(project_indication: nil).length
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    
    def student_profile_per_cent_students_medication(bool_medication, students)
        validate_info_different_nil(students) do |students|
            total = 0
            parcial = 0
            students.each do |student|
                if student.service_sheet != nil
                    total += 1 if student.service_sheet.medication != nil 
                    parcial += 1 if student.service_sheet.medication == bool_medication
                end
            end
            return get_percent_general_report(parcial, total).to_s + "%"
        end
    end
    ##########################################################################################
    
end
