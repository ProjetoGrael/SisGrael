class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :social_service, :generate_term, :edit, :update, :destroy]
  before_action :can_read_student?, only: [:index, :show]
  before_action :can_manage_student?, except: [:index, :show, :social_service]
  autocomplete :school, :name, full: true
  # GET /students
  # GET /students.json
  def index
    
    @inscriptions = Academic::Inscription.active.order('(student_id)').joins(:classroom).where(classrooms: {school_year_id: Academic::SchoolYear.current.id}) if Academic::Inscription.active.nil?
    
    @students = if params[:term].present? and params[:last_name].present?
      
      students = Student.where("name ILIKE (?)", "#{params[:term]}%").or(Student.where('registration_number ILIKE (?)',"%#{params[:term]}%")).or(Student.where('cpf ILIKE (?)',"%#{params[:term]}%")).or(Student.where('name ILIKE (?)',"_%#{params[:last_name]}%"))
      students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
 
    elsif params[:last_name].present?
        students = Student.where('name ILIKE (?)',"_%#{params[:last_name]}%")
        students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
    elsif params[:term].present?
      students = Student.where("name ILIKE (?)", "#{params[:term]}%").or(Student.where('registration_number ILIKE (?)',"%#{params[:term]}%")).or(Student.where('cpf ILIKE (?)',"%#{params[:term]}%"))
      students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)

    else
      Student.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @current_inscriptions = @student.inscriptions.active.joins(:classroom).where('school_year_id = ?', Academic::SchoolYear.current.id)
    @previous_inscriptions = @student.inscriptions.active.joins(:classroom).where('classrooms.school_year_id != ?', Academic::SchoolYear.current).order(:created_at)


    respond_to do |format|
      format.html
      format.json { render json: @student}
    end
  end
  
  #GET alunos/:id/assistencia-social
  def social_service
    authorize! :read, :social_service
  end

  def generate_cpf_csv
    @student = Student.all
    respond_to do |format|
      format.xlsx do 
      end
    end
  end

  def generate_term
    respond_to do |format|
      format.pdf do
        render pdf: 'term.pdf.erb',
        title: 'termo - '+@student.name
      end
    end
  end

  #Função da página com o histórico de todos os alunos renovados
  def renewable_students
    respond_to  do |format|
      format.html do
        @academic = Academic::SchoolYear.find(params[:school_year_id])
        @renewed_students = renewed_students(@academic)
      end
      format.xlsx do
        @academic = Academic::SchoolYear.find(params[:school_year_id])
        @renewed_students = renewed_students(@academic)
      end
    end
  end

  def renewable_students_json
    @academic = Academic::SchoolYear.find(params[:school_year_id])
    @renewed_students = renewed_students(@academic)
    render json: @renewed_students
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    invert_checklist
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    invert_checklist
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Aluno criado com sucesso.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      @student.assign_attributes(student_params)
      @student.active_inscription&.update(student_status: @student.status)
      invert_checklist
      if @student.save
        format.html { redirect_to @student, notice: 'Aluno atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @student }
      else

        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Aluno excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    #Função que adiciona todos os estudantes que foram renovados no ano letivo passado por parametro
    def renewed_students(ano_letivo)
      list_renewed_students = []
      ano_letivo.classrooms.each do |classroom|
        classroom.inscriptions.each do |inscription|
          if inscription.renewed_bool
            list_renewed_students.push(inscription.student)
          end
        end
      end
      #o método .uniq remove todos os elementos duplicados
      return list_renewed_students.uniq.sort_by{|student| student.name}
    end

    def can_read_student?
      if @student.present?
        authorize! :read, @student
      else
        authorize! :read, Student
      end
    end

    def can_manage_student?
      if @student.present?
        authorize! :manage, @student
      else
        authorize! :manage, Student
      end
    end

    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      parameters = params.require(:student).permit(
        :city_id,
        :neighborhood_id,
        :school_id,
        :state_id,
        :year,
        :semester,
        :photo,
        :name,
        :birthdate,
        :sex,
        :ethnicity,
        :nationality,
        :naturalness,
        :rg,
        :issuing_agency,
        :issuing_date,
        :cpf,
        :address,
        :cep,
        :sub_neighborhood,
        :email,
        :phone,
        :mobile_phone,
        :project_indication,
        :project_indication_description,
        :medication,
        :school_shift,
        :grade,
        :father_name,
        :father_cpf,
        :father_email,
        :father_phone,
        :mother_name,
        :mother_cpf,
        :mother_email,
        :mother_phone,
        :responsible_name,
        :responsible_cpf,
        :responsible_email,
        :responsible_phone,
        :number_residents,
        :family_income,
        :nis,
        :annotations,
        :working,
        :company,
        :rg_missing,
        :cpf_missing,
        :responsible_rg_missing,
        :responsible_cpf_missing,
        :address_proof_missing,
        :term_signed_missing,
        :school_declaration_missing,
        :medical_certificate_missing,
        :birth_certificate_missing,
        :historic_missing,
        :status,
        :specific_school_level,
        :completed,
        :medical_report,
        :behavior,
        :difficulties,
        :kinship,
        :father_responsible,
        :mother_responsible,
        :student_responsible,
        :other_relative_responsible,
        :photo_and_video_permited
        )
      if parameters[:family_income]
        parameters[:family_income] = monetary_string_to_decimal(parameters[:family_income])
      end
      return parameters
    end

    def invert_checklist
      @student.rg_missing = !@student.rg_missing
      @student.cpf_missing = !@student.cpf_missing
      @student.responsible_rg_missing = !@student.responsible_rg_missing
      @student.responsible_cpf_missing = !@student.responsible_cpf_missing
      @student.address_proof_missing = !@student.address_proof_missing
      @student.term_signed_missing = !@student.term_signed_missing
      @student.school_declaration_missing = !@student.school_declaration_missing
      @student.medical_certificate_missing = !@student.medical_certificate_missing
      @student.birth_certificate_missing = !@student.birth_certificate_missing
      @student.historic_missing = !@student.historic_missing
    end 
end
