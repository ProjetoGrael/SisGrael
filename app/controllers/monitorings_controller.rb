class MonitoringsController < ApplicationController
  include GeneralReportHelper
  before_action :redirect_to_not_permit, except: %i[sport_monitoring pdf_of_concel]

  def school_year_info
    @classrooms = Academic::SchoolYear.find(params[:school_year_id]).classrooms
    @school_year = Academic::SchoolYear.find_by(id: params[:school_year_id ]) || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @subject_histories = Academic::SubjectHistory.joins(classroom_subject: :classroom).where.not(final_counsel: nil).where(classroom_subjects: {classrooms: {school_year_id: @school_year.id}})
    @inscriptions = @school_year.inscriptions.active
    @students_evaded = @school_year.students.select{|s| s.status == "desisted" or s.status == "evaded"}

    title = "Informações dos alunos do #{@school_year.name}"
    @url = request.original_url
    respond_to do |format|
      format.pdf do  
        render pdf: title,
        title: title
      end
    end
  end

  def concept
    @school_year = Academic::SchoolYear.current
    @lessons = Academic::Presence.all.joins(lesson: [classroom_subject: [:classroom]]).where('school_year_id = ? ', @school_year.id)
    @inscriptions = Academic::Inscription.all.joins(:classroom,:student).order('name').where('school_year_id = ?', @school_year.id)
  end

  def pdf_of_concel
    @url = request.original_url
    @school_year = Academic::SchoolYear.find_by(id: params[:school_year_id]) || Academic::SchoolYear.find_by(id: Academic::SchoolYear.current.id) || Academic::SchoolYear.find_by(id: Academic::SchoolYear.first)
    @inscriptions = @school_year.inscriptions.active
    @students_evaded = @school_year.students.select{|s| s.status == "desisted" or s.status == "evaded"}
    @subject_histories = Academic::SubjectHistory.joins(classroom_subject: :classroom).where.not(final_counsel: nil).where(classroom_subjects: {classrooms: {school_year_id: @school_year.id}})
       
    title = "Informações gerais sobre #{@school_year.name}"
    respond_to do |format|
      format.pdf do
        render pdf: title,
        title: title
      end
    end
  end

  def school_year_monitoring
    @inscriptions = Academic::Inscription.all.joins(:classroom).where('school_year_id =  ?',Academic::SchoolYear.current.id)
    @school_years = Academic::SchoolYear.all
  end

  def instructor_monitoring
    @school_year = Academic::SchoolYear.current
    @presences = Academic::Presence.joins(lesson: [classroom_subject: :classroom]).where('school_year_id = ?', @school_year.id)
    @inscriptions = Academic::Inscription.all.joins(:classroom).where('school_year_id = ?', @school_year.id)
    respond_to do |format|
      format.xlsx do
      end
    end
  end

  def student_monitoring
    @students = Student.all
    @inscriptions = Academic::Inscription.all.joins(:classroom).where('school_year_id =  ?',Academic::SchoolYear.current.id)
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="relatorio-geral.xlsx"'
      end
    end
  end

  def student_panel
  end

  def sport_monitoring
    @inscriptions = Academic::Inscription.all.active.joins(:classroom,:student).where('school_year_id =  ?',Academic::SchoolYear.current.id).order('name')

    respond_to do |format|
      format.xlsx do
        render title: "Relatorio para o ministerio de esporte"
      end
    end
  end

  def student_places
    @students = Student.all
    respond_to do |format|
      format.xlsx do
      end
    end
  end

  def student_monitoring_individual
    @students = Student.all
    respond_to do |format|
      format.xlsx do
      end
    end
  end

  def per_school_year
    @inscriptions = Academic::Inscription.all.joins(:classroom).where('school_year_id =  ?',Academic::SchoolYear.current.id)

    @school_year = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @subjects = Academic::Subject.all
    @classroom_subjects = Academic::ClassroomSubject.joins(:classroom, :subject).where('classroom.school_year_id' == @school_year)
    respond_to do |format|
      format.xlsx do 
      end
    end
  end

  def council
    @school_year = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @inscriptions = Academic::Inscription.joins(:classroom).where('school_year_id = ?', @school_year)
    @ins_len = @inscriptions.length
    @subject_histories = Academic::SubjectHistory.joins(classroom_subject: :classroom).where('classroom_subject.classroom.school_year_school_year_id' == @school_year)
    @sub_his_len = @subject_histories.where.not("final_counsel < 1 or final_counsel > 4").length
    
    respond_to do |format|
      format.xlsx do
      end
    end
  end

  def social_service_monitoring
    respond_to do |format|
      format.xlsx do
      end
    end
  end

  def monitoring_labor_market_insertion
    @labor_markets = LaborMarket.all
    years = []
    LaborMarket.all.each do |lm|
      if lm.year != nil
        years.append(lm.year)
      end
    end
    @years = years.uniq

    respond_to do |format|
      format.xlsx do
      end
    end
  end

  def page_general_monitoring
    @school_years = Academic::SchoolYear.all
  end

  def general_monitoring
    @school_year_one = Academic::SchoolYear.find_by(id: params[:school_year_id_one])
    @school_year_two = Academic::SchoolYear.find_by(id: params[:school_year_id_two])
    @school_year_three = Academic::SchoolYear.find_by(id: params[:school_year_id_three])
    @school_year_four = Academic::SchoolYear.find_by(id: params[:school_year_id_four])

    @general_data = params[:general_data]
    @council_monitoring = params[:council_monitoring]
    @instructor_monitoring = params[:instructor_monitoring]
    @social_service_monitoring = params[:social_service_monitoring]
    @student_profile = params[:student_profile]

    @cities = City.all
    @neighborhoods = Neighborhood.all

    @instructors = Academic::Teacher.all

    @subjects = Academic::Subject.all

    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="Relatório-Geral.xlsx"'
      end
    end
  end

  def next_classroom
    @school_year = Academic::SchoolYear.find_by(id: params[:id]) or Academic::SchoolYear.current or Academic::SchoolYear.first
    @inscriptions = @school_year.inscriptions.active
    respond_to do |format|
      format.xlsx do
        file_name = "proxima-turma-do-periodo-#{@school_year.name}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=#{file_name}"
      end
    end
  end

  private
    def redirect_to_not_permit
      user = current_user
      unless  user.admin? or user.coordination? or user.pedagogue? or user.social_service? or user.administration?
        redirect_to '/app/views/403.html', notice: "Permissão negada"  
    end
  end
end
