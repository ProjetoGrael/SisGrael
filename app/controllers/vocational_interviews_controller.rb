class VocationalInterviewsController < ApplicationController
  before_action :set_vocational_interview, only: [:edit, :update, :destroy, :show]
  before_action :set_student_by_params, only: [:new, :show]
  before_action :set_student_by_owned, only: [:edit]
  before_action do
    authorize! :manage, VocationalInterview
  end
  
  def index
    @vocational_interviews = VocationalInterview.all.joins(:student).merge(Student.order(name: :asc))
  end

  # GET /vocational_interviews/1
  # GET /vocational_interviews/1.json
  def show
    if @vocational_interview.nil?
      redirect_to new_student_vocational_interview_path(:student_id => @student.id)
    end
  end

  # GET /vocational_interviews/new
  def new
    if !@student.vocational_interview.nil?
      redirect_to student_vocational_interview_path(:id => @student.vocational_interview)
    else
      @vocational_interview = VocationalInterview.new
      @vocational_interview.student_id = @student.id if @student.present?
    end
  end

  # GET /vocational_interviews/1/edit
  def edit
    
  end

  # POST /vocational_interviews
  # POST /vocational_interviews.json
  def create
    @vocational_interview = VocationalInterview.new(vocational_interview_params)
    @student = @vocational_interview.student
    respond_to do |format|
      if @vocational_interview.save!
        format.html { redirect_to student_vocational_interview_path( student_id: @student.id, id: @vocational_interview.id), notice: 'Entrevista Profissionalizante criada com sucesso.' }
        format.json { render :show, status: :created, location: @vocational_interview }
      else
        format.html { render :new }
        format.json { render json: @vocational_interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vocational_interviews/1
  # PATCH/PUT /vocational_interviews/1.json
  def update
    respond_to do |format|
      if @vocational_interview.update(vocational_interview_params)
        format.html { redirect_to student_vocational_interview_path(id: @vocational_interview.id,student_id: @vocational_interview.student_id), notice: 'Entrevista Profissionalizante atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @vocational_interview }
      else
        format.html { render :edit }
        format.json { render json: @vocational_interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vocational_interviews/1
  # DELETE /vocational_interviews/1.json
  def destroy
    @vocational_interview.destroy
    respond_to do |format|
      format.html { redirect_to index_student_service_sheets_path, notice: 'Entrevista Profissionalizante excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def show_pdf
    if params[:id] != nil
      @vocational_interview = VocationalInterview.find(params[:id])
    else

    end
    @title = "Entrevista Profissionalizante do aluno #{@vocational_interview.student.name}"
    respond_to do |format|
      format.pdf do
        render pdf: @title,
        title: @title,
        orientation: 'Portrait'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vocational_interview
      @vocational_interview = VocationalInterview.exists?(params[:id]) ? VocationalInterview.find(params[:id]) : nil
    end

    
    def set_student_by_owned
      @student = @vocational_interview.student if @vocational_interview.student.present?
    end

    def set_student_by_params
      @student = Student.find(params[:student_id]) if !(params[:student_id]).nil?
    end

    def vocational_interview_params
      params.require(:vocational_interview).permit(
          :enrolled_in_the_course,
          :social_name,
          :last_attended_educational_institution,
          :repetition,
          :special_needs,
          :live_with,
          :housing_condition,
          :urban_infrastructure,
          :motivation,
          :already_attended,
          :already_attended_when,
          :already_attended_which_other,
          :already_attended_difference_other,
          :nautical_experience,
          :nautical_experience_text,
          :already_attended_to_other,
          :already_attended_to_other_text,
          :project_access,
          :number_transport,
          :have_income,
          :work,
          :work_wich,
          :father_works,
          :mother_works,
          :step_father_works,
          :step_mother_works,
          :brothers_works,
          :grandparents_works,
          :other_works,
          :workers_in_family_other,
          :working_time,
          :microsoft_office_knowledge,
          :internet_surfer,
          :social_networks,
          :social_networks_text,
          :family_life,
          :reveal_about_family_text,
          :concluding_remarks,
          :student_id,
          :created_at,
          :updated_at,
          ### Tudo comentado não pertence mais à tabela; Suas migrações foram comentadas anteriormente.
          # :canoeing,
          # :ambiental_programs,
          # :professional_courses,
          # :swimming,
          # :sailing,
          # :professional_courses_text,
          # :maide_difference_performance,
          # :maide_difference_relationships,
          # :maide_difference_problem_solutions,
          # :maide_difference_comunity,
          :recreation_doing,
          # :internet_surfer_text,
          # :project_access_text,
          # :user_id,
          :student_id,
          :other_motivation,
          :ethnicity,
          :amount_repetitions
        )
    end
end
