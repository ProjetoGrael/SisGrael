class Academic::TeachersController < ApplicationController
  before_action :set_teacher, only: [:teacher_subjects, :subjects,:panel, :show, :edit, :update, :destroy, :disable]
  load_and_authorize_resource
  include Academic::TeachersHelper
  def list_teachers
    id = params.permit(:subject_id)[:subject_id]
    subject = Academic::Subject.find(id)
    teachers = subject.teachers.active.map{ |t| [t.name, t.id] }
    teachers = teachers.sort_by {|t| t[0].downcase }

    render json: teachers
  end

  def new_form
    @teacher = Academic::Teacher.new
  end


  def post_new_form
    @user = User.new(user_params)
    @user.kind = "instructor"
    respond_to do |format|
      if @user.save
        @teacher = Academic::Teacher.new(second_teacher_params)
        @teacher.user_id = @user.id
        
        if @teacher.save
          format.html { redirect_to @teacher, notice: 'Educador foi criado com sucesso.' }
          format.json { render :show, status: :created, location: @teacher }
        else
          @user.destroy
          format.html { render :new_form }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        
      else
        format.html { render :new_form }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    
  end




  def teacher_subjects
  end

  def panel
  end

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = if params[:term]
      # A maneira padrao nao funciona nesse caso
      @teachers = Academic::Teacher.joins(:user).where("name ILIKE (?)", "%#{params[:term]}%")
    else
      @teachers = Academic::Teacher.all.sort_by { |t| t.name.downcase }
    end
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Academic::Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Academic::Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Educador foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: 'Educador foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET /educadres/:id/select_disciplinas
  def subjects
    render json: {subjects: @teacher.subjects.order(:name)}
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Educador foi excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def disable
    @teacher.update_attributes(active: false)
    @teacher.user.update_attributes(banned?: true)
    # sign_out @teacher.user
    
    redirect_to teachers_path

  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Academic::Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(
        :user_id,
        :birth,
        :active,
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
        :phone,
        :mobile_phone
      )
    end

    def user_params
      params.permit(:name, :email, :password, :picture, :signature)
    end

    def second_teacher_params
      params.permit(
        
        :birth,
        :active,
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
        :phone,
        :mobile_phone
      )
    end
end
