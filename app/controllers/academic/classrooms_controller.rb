class Academic::ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :final_evaluation, :table_of_secretary]
  before_action :set_school_year, only: [:new, :index]
  load_and_authorize_resource

  def list_classrooms
    id = params.permit(:school_year_id)
    id = id[:school_year_id]
    school_year = Academic::SchoolYear.find(id)
    classrooms = school_year.classrooms.map{|t| [t.fantasy_name, t.id]}
    classrooms = classrooms.sort_by {|t| t[0].downcase}

    render json: classrooms
  end

  # GET /classrooms
  # GET /classrooms.json
  def index
    if params[:term] != "" && params[:term]
      @classrooms = @school_year.classrooms.where("fantasy_name ILIKE (?)", "%#{params[:term]}%").order('LOWER(fantasy_name)')
    elsif params[:teacher_id] != "" && params[:teacher_id]
      if params[:subject_id] != "" && params[:subject_id]
        @classrooms = @school_year.classrooms.joins(:classroom_subjects).where(["teacher_id = ? and subject_id = ?", params[:teacher_id], params[:subject_id]])
      else
        @classrooms = @school_year.classrooms.joins(:classroom_subjects).where("teacher_id = ?", params[:teacher_id])
      end
    else
      @classrooms = @school_year.classrooms
    end

    if current_user.instructor?
      @classrooms = []
      classroom_subjects = Academic::ClassroomSubject.where(teacher: Academic::Teacher.where(user_id: current_user.id))
      classroom_subjects.each do |cs|
        @classrooms.push(cs.classroom)
      end
      @classrooms = @classrooms.uniq
    end

    @teachers = Academic::Teacher.where(active: true).joins(:user).order('name')
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    if current_user.instructor? && current_user.teacher.present?
      classroom_subjects_with_current_user = Academic::ClassroomSubject.where(
        classroom_id: @classroom.id,
        teacher_id: current_user.teacher.id
      )
      unless classroom_subjects_with_current_user.any?
        throw CanCan::AcessDenied
      end
    end
    @inscriptions = @classroom.inscriptions.active.joins(:student).order('LOWER(name)')
  end

  # GET /classrooms/new
  def new
    @classroom = Academic::Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Academic::Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Turma foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Turma foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    school_year = @classroom.school_year
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to school_year_classrooms_path(school_year), notice: 'Turma foi excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def final_evaluation
    @classroom_subjects = @classroom.classroom_subjects
    @main_classroom_subject = Academic::ClassroomSubject.find(@classroom.main_id) if @classroom.main_id.present?
    @inscriptions = @classroom.inscriptions.active.joins(:student).order('LOWER(name)')
    @subjects = Academic::Subject.all
  end

 def table_of_secretary
    @classroom_subjects = @classroom.classroom_subjects
    @inscriptions = @classroom.inscriptions.active.joins(:student).order('LOWER(name)')
  end

  def frequency_list
    @month = params[:month]
    #Validando @month para ter um 0 na frente caso seja mês menor que 10
    if(@month.length == 1)
      @month = "0" + @month
    end
    @classroom = Academic::Classroom.find(params[:classroom_id])
    @classroom_subjects = @classroom.classroom_subjects

    @title = "Pauta de #{helpers.enum_months(@month)} da turma #{@classroom.fantasy_name} do período letivo #{@classroom.school_year.name}"
    respond_to do |format|
      format.pdf do
        render pdf: @title, title: @title, orientation: 'Landscape'
      end
    end
  end

  def save_all
    with_errors = false

    inscriptions = params.require(:inscriptions)
    inscriptions.each do |item|
      inscription = Academic::Inscription.find(item[:inscription_id])
      params = item[:params]
      unless inscription.update_attributes(
        counsel_opinion: params[:counsel_opinion], 
        situation: params[:situation], 
        subject_level_id: params[:subject_level_id], 
        subject_id: params[:subject_id]
      )
        with_errors = true 
      end
    end
  
    subject_histories = params.require(:subject_histories)
    subject_histories.each do |item|
      params = item[:params]
      subject_history = Academic::SubjectHistory.find(item[:subject_history_id])
      unless subject_history.update_attributes(
        presence: params[:presence], 
        justified_absences: params[:justified_absences], 
        partial_counsel: params[:partial_counsel], 
        final_counsel: params[:final_counsel]
      )
        with_errors = true
      end
    end
    
    unless @classroom.update_attributes(opinion: params[:class_opinion])
      with_errors = true 
    end
      
    respond_to do |format|
      if with_errors
        format.json { head :no_content }
      else
        format.json { render json: @classroom, status: :ok, location: @classroom }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Academic::Classroom.find(params[:id])
    end

    def set_school_year
      @school_year = Academic::SchoolYear.find(params[:school_year_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:fantasy_name, :status, :school_year_id)
    end

end
