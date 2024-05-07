class Financial::OrganizationsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource class: Financial::Institution

  # GET /institutions
  # GET /institutions.json
  def index
    @institutions = Financial::Institution.organization.paginate(:page => params[:page], :per_page => 20).order("LOWER(name)")
  end

  # GET /institutions/new
  def new
    @institution = Financial::Institution.new
  end

  # GET /institutions/1/edit
  def edit
  end

  # POST /institutions
  # POST /institutions.json
  def create
    @institution = Financial::Institution.new(institution_params)

    respond_to do |format|
      if @institution.save
        format.html { redirect_to organizations_path, notice: 'Classe criada com sucesso.' }
        format.json { render :show, status: :created, location: @institution }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /institutions/1
  # PATCH/PUT /institutions/1.json
  def update
    respond_to do |format|
      if @institution.update(institution_params)
        format.html { redirect_to organizations_path, notice: 'Classe atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @institution }
      else
        format.html { render :edit }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /institutions/1
  # DELETE /institutions/1.json
  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to organizations_path, notice: 'Classe excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def list_organizations
    render json: Financial::Institution.organization.pluck(:name, :id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Financial::Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      parameters = params.require(:institution).permit(:name, :kind, :status)
      parameters[:kind] = :organization
      return parameters
    end
end
