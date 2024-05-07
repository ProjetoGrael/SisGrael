class ServiceSheetsController < ApplicationController
  before_action :set_service_sheet, only: [:edit, :update, :destroy, :show]
  before_action :set_student, only: [:new, :edit, :show]
  load_and_authorize_resource

  # GET /service_sheets 
  # GET /service_sheets.json
  def index
    if params[:term]
      if params[:sheet_kind] == 'Entrevista Profissionalizante'
        sheets = VocationalInterview.all.joins(:student).where("students.name ILIKE ?", "%#{params[:term]}%")
      elsif params[:sheet_kind] == 'Ficha de Atendimento'
        sheets = ServiceSheet.all.joins(:student).where("students.name ILIKE ?", "%#{params[:term]}%")
      else
        sheets = ServiceSheet.all.joins(:student).where("students.name ILIKE ?", "%#{params[:term]}%") + (VocationalInterview.all.joins(:student).where("students.name ILIKE ?", "%#{params[:term]}%"))
      end
      
      @sheets = sheets.paginate(page: params[:page], per_page: 20)
    else
      service_sheets = ServiceSheet.all.joins(:student).merge(Student.order(name: :asc))
      vocational_sheets = VocationalInterview.all.joins(:student).merge(Student.order(name: :asc))
      sheets = service_sheets + vocational_sheets

      @sheets = sheets.paginate(page: params[:page], per_page: 20)
    end
  end

  # GET /service_sheets/1
  # GET /service_sheets/1.json
  def show
    if @service_sheet.nil?
      redirect_to new_student_service_sheet_path @student
    end
  end

  # GET /service_sheets/new
  def new
    
    if !@student.service_sheet.nil?

      redirect_to student_service_sheet_path(@student, @student.service_sheet)
    else 
      @service_sheet = ServiceSheet.new
      @service_sheet.student_id = @student.id if @student.present?
      #carregando membros familiares
      @family_member = @service_sheet.family_members.new
      @relatives = @student.family_members.all
    end
  end
  
  # GET /service_sheets/1/edit
  def edit
  end

  # POST /service_sheets
  # POST /service_sheets.json
  def create

    @service_sheet = ServiceSheet.new(service_sheet_params)
    @student = @service_sheet.student
    respond_to do |format|
      if @service_sheet.save
        format.html { redirect_to student_service_sheet_path(@student, @service_sheet), notice: 'Ficha de Atendimento criada com sucesso.' }
        format.json { render :show, status: :created, location: @service_sheet }
      else
        format.html { render :new }
        format.json { render json: @service_sheet.errors, status: :unprocessable_entity }
      end
    end

    end

  # PATCH/PUT /service_sheets/1
  # PATCH/PUT /service_sheets/1.json
  def update
    respond_to do |format|
      if @service_sheet.update(service_sheet_params)
        format.html { redirect_to student_service_sheet_path(@service_sheet), notice: 'Ficha de Atendimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @service_sheet }
      else
        format.html { render :edit }
        format.json { render json: @service_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_sheets/1
  # DELETE /service_sheets/1.json
  def destroy
    @service_sheet.destroy
    respond_to do |format|
      format.html { redirect_to index_student_service_sheets_path, notice: 'Ficha de Atendimento excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def show_pdf
    @service_sheet = ServiceSheet.find(params[:id]) unless params[:id].nil?
    @title = "Ficha de Atendimento do aluno #{@service_sheet.student.name}"
    render pdf: @title, title: @title, orientation: 'Portrait'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_sheet
      @service_sheet = ServiceSheet.exists?(params[:id]) ? ServiceSheet.find(params[:id]) : nil
    end

    def set_student
      @student = Student.find(params[:student_id]) if !(params[:student_id]).nil?
      
    end

    def service_sheet_params
      params.require(:service_sheet).permit(
        :student_id,
        :dwell_time_address, 
        :marital_status, 
        :disabled_person, 
        :disabled_person_text, 
        :has_documentation, 
        :has_documentation_text, 
        :father, 
        :mother,
        :current_working,
        :salary,
        :working_situation,
        :working_situation_other, 
        :receives_benefit, 
        :receives_benefit_wich,
        :dwell_time_city, 
        :previously_resided_city, 
        :residence_status, 
        :residence_status_text, 
        :kind_of_residence, 
        :kind_of_residence_text, 
        :room_number, 
        :medication, 
        :medication_text, 
        :psychiatric_treatment, 
        :psychiatric_treatment_where, 
        :deficiency_in_family, 
        :deficiency_in_family_text, 
        :deficiency_in_family_who, 
        :health_more_info, 
        :protective_measures, 
        :protective_measures_text, 
        :socio_educational_measure, 
        :socio_educational_measure_text, 
        :socio_educational_measure_when, 
        :notes, 
        :referrals, 
        :responsible_technician,
        :medication_expense,
        :per_capta_income,
        :total_income
      )
    end

end
