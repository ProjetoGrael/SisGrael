class AbsenceReportsController < ApplicationController
    before_action :autorized_users
    def index
        @absents = Student.absents
    end

    def show
        @student = Student.find(params[:id])
        inscription = Academic::Inscription.where(student: @student)
        day = "2000-01-01".to_date
        if Academic::SchoolYear.find_by(status: 1) != nil
            day = Academic::SchoolYear.find_by(status: 1).start
        end
        @absences = @student.absences.where(lesson: Academic::Lesson.where('day > ?', day))

        #Variavel que armazena o estudante, o curso e as faltas (naquele curso) do estudante
        @absences_subjects = []
        @absences.each do |abs|
            exists = false
            @absences_subjects.each do |subject_history|
                if abs.lesson.classroom_subject.subject == subject_history[:classroom_subject].subject
                    exists = true
                end
            end

            if exists == false
                #Se a data nao for nil, usar a data, caso a data seja nivel, colocar a data que faça sentido
                date = Academic::SubjectHistory.where(classroom_subject: abs.lesson.classroom_subject).where(inscription: Academic::Inscription.where(student: Student.find(params[:id]))).first.date_resolved_absence
                if date != nil
                    if Academic::SchoolYear.find_by(status: 1) != nil
                        if date < Academic::SchoolYear.find_by(status: 1).start
                            date = Academic::SchoolYear.find_by(status: 1).start
                        end
                    end
                    absence_subject = {
                        :student => Student.find(params[:id]),
                        :classroom_subject => abs.lesson.classroom_subject,
                        :absences => @student.absences.where(lesson: Academic::Lesson.where('day > ?', Academic::SubjectHistory.where(classroom_subject: abs.lesson.classroom_subject).where(inscription: Academic::Inscription.where(student: Student.find(params[:id]))).first.date_resolved_absence).where(classroom_subject: Academic::ClassroomSubject.where(subject: abs.lesson.classroom_subject.subject)))
                    }
                else
                    date = "2000-01-01".to_date
                    if Academic::SchoolYear.find_by(status: 1) != nil
                        if date < Academic::SchoolYear.find_by(status: 1).start
                            date = Academic::SchoolYear.find_by(status: 1).start
                        end
                    end
                    absence_subject = {
                        :student => Student.find(params[:id]),
                        :classroom_subject => abs.lesson.classroom_subject,
                        :absences => @student.absences.where(lesson: Academic::Lesson.where('day > ?', date).where(classroom_subject: Academic::ClassroomSubject.where(subject: abs.lesson.classroom_subject.subject)))
                    }
                end
                @absences_subjects.push(absence_subject)
            end
        end

        
    end
    private
        def autorized_users
            redirect_to '/403.html' unless current_user.secretary? or current_user.admin? or current_user.coordination? or current_user.pedagogue?
        end 

end







