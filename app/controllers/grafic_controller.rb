class GraficController < ApplicationController
  before_action :redirect_to_not_permit

  def time_stay
    @date = {'Menos de 1 semestre': 0,'De 1 semestre à 2': 0, 'De 3 semestres à 4': 0, 'De 5 semestre à 6': 0, 'Mais que 6 semestre': 0}
    date_of_database_with_restriction = Academic::Inscription.active.where.not(situation: "studying").active.joins(:classroom).group(:student_id).select(:school_year_id).distinct.count   
    @date_of_database = Academic::Inscription.all.active.joins(:classroom).group(:student_id).select(:school_year_id).distinct.count 
    @date_of_database.each do |key, value|
      number = 0
      puts value
      if !date_of_database_with_restriction[key].present? or value != date_of_database_with_restriction[key]
        number = value - 1
      else
        number = value
      end
      if number == 0
        @date[:'Menos de 1 semestre'] += 1
      elsif number < 3
        @date[:'De 1 semestre à 2']+= 1
      elsif number < 5
        @date[:'De 3 semestres à 4'] += 1
      elsif number < 7
        @date[:'De 5 semestre à 6'] += 1
      else
        @date[:'Mais que 6 semestre'] += 1
      end
      
    end
  end

  def main
  end

  def local_neighborhood
    @student_len = Student.all.count
    @date = Student.all.joins(:neighborhood).group('neighborhoods.name').select('neighborhoods.name').count
    @date = @date.map{ |key, value| [key, value.to_f * 100 / @student_len]}.to_h
  end

  def local_city
    @student_len = Student.all.count
    @date = Student.all.joins(:city).group('cities.name').select('cities.name').count
    @date = @date.map{ |key, value| [key, value.to_f * 100 / @student_len]}.to_h
  end

  def per_school_year
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @subject_id = params[:subject_id]
    @subject = Academic::Subject.find(@subject_id) if @subject_id.present?
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @general_presence = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where(" school_year_id = #{@school_year.id}")
    @date_third = {"Presentes": (@general_presence.where('situation != 3 and situation !=2').length.to_f* 100.0/ @general_presence.length),"Faltas": @general_presence.where('situation = 3 or situation =2').length.to_f* 100.0/ @general_presence.length}
    return unless @subject_id.present?
    @presences = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where("subject_id = #{@subject.id} and school_year_id = #{@school_year.id}")
    @date_first = {"Quantidade de presenças": @presences.length, "Quantidade de atraso": @presences.where(situation: "later").length, "Quantidade de faltas": @presences.where('situation = 3 or situation = 2').length}
    @date_second = {"Conceito A": @presences.where(participation: 1 ).length,"Conceito B": @presences.where(participation: 2 ).length,"Conceito C": @presences.where(participation: 3 ).length,"Conceito D": @presences.where(participation: 4 ).length}
  end

  def per_school_year
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @subject_id = params[:subject_id]
    @subject = Academic::Subject.find(@subject_id) if @subject_id.present?
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @general_presence = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where(" school_year_id = #{@school_year.id}")
    @date_third = {"Presentes": (@general_presence.where('situation != 3 and situation !=2').length.to_f* 100.0/ @general_presence.length),"Faltas": @general_presence.where('situation = 3 or situation =2').length.to_f* 100.0/ @general_presence.length}
    return unless @subject_id.present?
    @presences = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where("subject_id = #{@subject.id} and school_year_id = #{@school_year.id}")
    @date_first = {"Presenças": @presences.length, "Atrasos": @presences.where(situation: "later").length, "Faltas": @presences.where('situation = 3 or situation = 2').length}
    @date_second = {"Conceito A": @presences.where(participation: 1 ).length,"Conceito B": @presences.where(participation: 2 ).length,"Conceito C": @presences.where(participation: 3 ).length,"Conceito D": @presences.where(participation: 4 ).length}
  end

  def presence_per_school_year
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @subject_id = params[:subject_id]
    @subject = Academic::Subject.find(@subject_id) if @subject_id.present?
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @general_presence = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where(" school_year_id = #{@school_year.id}")
    @date_third = {"Presentes": (@general_presence.where('situation != 3 and situation !=2').length.to_f* 100.0/ @general_presence.length),"Faltas": @general_presence.where('situation = 3 or situation =2').length.to_f* 100.0/ @general_presence.length}
    return unless @subject_id.present?
    @presences = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where("subject_id = #{@subject.id} and school_year_id = #{@school_year.id}")
    @date_first = {"Quantidade de presenças": @presences.length, "Quantidade de atraso": @presences.where(situation: "later").length, "Quantidade de faltas": @presences.where('situation = 3 or situation = 2').length}
    @date_second = {"Conceito A": @presences.where(participation: 1 ).length,"Conceito B": @presences.where(participation: 2 ).length,"Conceito C": @presences.where(participation: 3 ).length,"Conceito D": @presences.where(participation: 4 ).length}
  end

  def dairy_concept
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @subject_id = params[:subject_id]
    @subject = Academic::Subject.find(@subject_id) if @subject_id.present?
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @general_presence = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where(" school_year_id = #{@school_year.id}")
    @date_third = {"Presentes": (@general_presence.where('situation != 3 and situation !=2').length.to_f* 100.0/ @general_presence.length),"Faltas": @general_presence.where('situation = 3 or situation =2').length.to_f* 100.0/ @general_presence.length}
    return unless @subject_id.present?
    @presences = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where("subject_id = #{@subject.id} and school_year_id = #{@school_year.id}")
    @date_first = {"Quantidade de presenças": @presences.length, "Quantidade de atraso": @presences.where(situation: "later").length, "Quantidade de faltas": @presences.where('situation = 3 or situation = 2').length}
    @date_second = {"Conceito A": @presences.where(participation: 1 ).length,"Conceito B": @presences.where(participation: 2 ).length,"Conceito C": @presences.where(participation: 3 ).length,"Conceito D": @presences.where(participation: 4 ).length}
  end

  def student_per_school
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @swiming = Academic::ClassroomSubject.where(subject_id: 4)
    @vela = Academic::ClassroomSubject.where('classroom_subjects.subject_id = 1 or classroom_subjects.subject_id = 2 or classroom_subjects.subject_id = 17')
    @canoa = Academic::ClassroomSubject.where(subject_id: 16)
    @swiming =@swiming.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @vela =@vela.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @canoa =@canoa.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @other = Academic::Subject.where(professionalized: true).joins(classroom_subject: [classroom: [:inscriptions]]).where('school_year_id = ? ',@school_year.id).count('DISTINCT(student_id)')
    @date = {"Matriculado em Natação": @swiming.count('DISTINCT(student_id)'), "Matriculado em Vela": @vela.count('DISTINCT(student_id)'),"Matriculado em Canoa": @canoa.count('DISTINCT(student_id)'),"Matriculados em Profissionalizante": @other    }
  end

  def student_per_school_re
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @swiming = Academic::ClassroomSubject.where(subject_id: 4)
    @vela = Academic::ClassroomSubject.where('classroom_subjects.subject_id = 1 or classroom_subjects.subject_id = 2 or classroom_subjects.subject_id = 17')
    @canoa = Academic::ClassroomSubject.where(subject_id: 16)
    @swiming =@swiming.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @vela =@vela.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @canoa =@canoa.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @date = {"Rematriculado em Natação": @swiming.where("inscriptions.student_status = 'renewed'").count('DISTINCT(student_id)'), "Rematriculado em Vela": @vela.where("inscriptions.student_status = 'renewed'").count('DISTINCT(student_id)'),"Rematriculado em Canoa": @canoa.where("inscriptions.student_status = 'renewed'").count('DISTINCT(student_id)')}
  end

  def student_per_school_active
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @swiming = Academic::ClassroomSubject.where(subject_id: 4)
    @vela = Academic::ClassroomSubject.where('classroom_subjects.subject_id = 1 or classroom_subjects.subject_id = 2 or classroom_subjects.subject_id = 17')
    @canoa = Academic::ClassroomSubject.where(subject_id: 16)
    @swiming =@swiming.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @vela =@vela.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @canoa =@canoa.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @date = {"Ativos em Natação": @swiming.where("inscriptions.situation != 3 or inscriptions.situation != 4").count('DISTINCT(student_id)'), "Ativos em Vela": @vela.where("inscriptions.situation != 3 or inscriptions.situation != 4").count('DISTINCT(student_id)'),"Ativos em Canoa": @canoa.where("inscriptions.situation != 3 or inscriptions.situation != 4").count('DISTINCT(student_id)')}
  end

  def student_per_school_approved
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
    @swiming = Academic::ClassroomSubject.where(subject_id: 4)
    @vela = Academic::ClassroomSubject.where('classroom_subjects.subject_id = 1 or classroom_subjects.subject_id = 2 or classroom_subjects.subject_id = 17')
    @canoa = Academic::ClassroomSubject.where(subject_id: 16)
    @swiming =@swiming.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @vela =@vela.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @canoa =@canoa.joins(classroom: [:inscriptions]).where('school_year_id = ? ',@school_year.id)
    @date = {"Aprovados em Natação": @swiming.where("inscriptions.situation = 1").count('DISTINCT(student_id)'), "Aprovados em Vela": @vela.where("inscriptions.situation = 1").count('DISTINCT(student_id)'),"Aprovados em Canoa": @canoa.where("inscriptions.situation = 1").count('DISTINCT(student_id)')}
  end

  def age_distrubution
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
    today = Date.today
    @students =Student.joins(inscriptions: [:classroom]).where('school_year_id = ? ',@school_year.id).where("inscriptions.situation != 3 or inscriptions.situation != 4")
    @date = {'Crianças': @students.where('birthdate <= ?', today - 9.years).select('DISTINCT(students.id)').length,'Adolescentes': @students.where('birthdate < ?', today - 12.years).select('DISTINCT(students.id)').length,'Jovens': @students.where('birthdate < ?', today - 17.years).select('DISTINCT(students.id)').length}
  end

  def gender_distrubution
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
    
    @students =Student.joins(inscriptions: [:classroom]).where('school_year_id = ? ',@school_year.id).where("inscriptions.situation != 3 or inscriptions.situation != 4")
    @date = {'Masculino': @students.where(sex: "male").select('DISTINCT(students.id)').length,'Feminino': @students.where(sex: "female").select('DISTINCT(students.id)').length,'Outro': @students.where(sex: "other").select('DISTINCT(students.id)').length}
  end

  def student_grade
    @school_year_id = params[:school_year_id]
    @year = @school_year_id || Academic::SchoolYear.current.id || Academic::SchoolYear.first.id
    @subject_id = params[:subject_id]
    @student_id = params[:student_id]
    @subject = Academic::Subject.find(@subject_id) if @subject_id.present?
    @students =Student.joins(inscriptions: [:classroom]).where('school_year_id = ? ',@year).where("inscriptions.situation != 3 or inscriptions.situation != 4")
    return unless @subject_id.present?
    @presences = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where("subject_id = #{@subject.id} and school_year_id = #{@year}")
    @date_second = {"Conceito A": @presences.where(participation: 1 ).length,"Conceito B": @presences.where(participation: 2 ).length,"Conceito C": @presences.where(participation: 3 ).length,"Conceito D": @presences.where(participation: 4 ).length}
  end

  private
  
    def redirect_to_not_permit
      user = current_user
      unless  user.admin? or user.coordination? or user.pedagogue? or user.social_service? or user.administration?
        redirect_to '/app/views/403.html', notice: "Permissão negada"  
      end
    end
end
