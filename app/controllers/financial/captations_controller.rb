class Financial::CaptationsController < ApplicationController
  before_action :set_captation, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /captations/1
  # GET /captations/1.json
  def show
  end

  # GET /captations/new
  def new
    @captation = Financial::Captation.new
  end

  # GET /captations/1/edit
  def edit
  end

  # POST /captations
  # POST /captations.json
  def create
    @captation = Financial::Captation.new(captation_params)
    @project = Financial::Project.find(params[:captation][:project_id])

    respond_to do |format|
      if @captation.save
        @project.total_value += @captation.value
        @project.current_value += @captation.value
        @project.save

        format.html { redirect_to @project, notice: 'Captação criada com sucesso.' }
        format.json { render :show, status: :created, location: @captation }
      else
        format.html { redirect_to @project, notice: 'Não foi possível criar a Captação.' }
        format.json { render json: @captation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /captations/1
  # PATCH/PUT /captations/1.json
  def update
    respond_to do |format|
      valorAntigo = @captation.value
      valorAtual = BigDecimal.new(captation_params[:value])
      project = Financial::Project.find(@captation.project_id)

      if @captation.update(captation_params)
        project.current_value += valorAtual - valorAntigo
        project.total_value += valorAtual - valorAntigo
        project.save

        format.html { redirect_to project, notice: 'Captação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @captation }
      else
        format.html { render :edit }
        format.json { render json: @captation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /captations/1
  # DELETE /captations/1.json
  def destroy
    project = @captation.project
    project.total_value -= @captation.value
    project.current_value -= @captation.value
    project.save

    @captation.destroy
    respond_to do |format|
      format.html { redirect_to project, notice: 'Captação excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_captation
      @captation = Financial::Captation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def captation_params
      parameters = params.require(:captation).permit(:source, :value, :project_id)
      parameters[:value] = monetary_string_to_decimal(parameters[:value])
      return parameters
    end
end
