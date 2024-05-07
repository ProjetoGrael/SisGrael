class Financial::RubricsController < ApplicationController
  before_action :set_rubric, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /rubrics/1
  # GET /rubrics/1.json
  def show
    @rubric_items = if params[:term]
      @rubric.rubric_items.where("description ILIKE (?)","%#{params[:term]}%").paginate(:page => params[:page], :per_page => 20)
    else
      @rubric.rubric_items.paginate(:page => params[:page], :per_page => 20)
    end
  end

  # GET /rubrics/new
  def new
    @rubric = Financial::Rubric.new
  end

  # GET /rubrics/1/edit
  def edit
  end

  # POST /rubrics
  # POST /rubrics.json
  def create
    @rubric = Financial::Rubric.new(rubric_params)
    @project = Financial::Project.find(params[:rubric][:project_id])
    
    values_diference = @rubric.value
    @rubric.adjust_values(values_diference)

    respond_to do |format|
      if @project.current_value < @rubric.value
        format.html { redirect_to @project, notice: "Valor supera o saldo do projeto." }
        format.json { render json: @rubric.errors, status: :unprocessable_entity }
      else
        if @rubric.save
          @project.adjust_current_value(values_diference)

          format.html { redirect_to @project, notice: 'Rubrica criada com sucesso.' }
          format.json { render :show, status: :created, location: @rubric }
        else
          format.html { redirect_to @project, notice: @rubric.errors.full_messages.join('. ') }
          format.json { render json: @rubric.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /rubrics/1
  # PATCH/PUT /rubrics/1.json
  def update
    new_value = rubric_params[:value]
    project = @rubric.project
    values_diference = new_value - @rubric.value
    @rubric.adjust_values(values_diference)

    respond_to do |format|
      if project.current_value <= values_diference
        format.html { redirect_to project, notice: "Valor supera o saldo do projeto." }
        format.json { render json: @rubric.errors, status: :unprocessable_entity }
      else
        if @rubric.update(rubric_params)
          project.adjust_current_value(values_diference)

          format.html { redirect_to project, notice: 'Rubrica atualizada com sucesso.' }
          format.json { render :show, status: :ok, location: @rubric }
        else
          format.html { render :edit }
          format.json { render json: @rubric.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /rubrics/1
  # DELETE /rubrics/1.json
  def destroy
    project = @rubric.project
    project.adjust_current_value(-@rubric.value)
    @rubric.destroy

    respond_to do |format|
      format.html { redirect_to project, notice: 'Rubrica excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rubric
      @rubric = Financial::Rubric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rubric_params
      parameters = params.require(:rubric).permit(:description, :classification, :value, :project_id)
      parameters[:value] = monetary_string_to_decimal(parameters[:value])
      return parameters
    end
end
