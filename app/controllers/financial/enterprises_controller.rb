class Financial::EnterprisesController < ApplicationController
  before_action :set_enterprise, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource class: Financial::Institution

  # GET /enterprises
  # GET /enterprises.json
  def index
    @enterprises = Financial::Institution.enterprise.paginate(:page => params[:page], :per_page => 20).order("LOWER(name)")
  end

  # GET /enterprises/new
  def new
    @enterprise = Financial::Institution.new
  end

  # GET /enterprises/1/edit
  def edit
  end

  # POST /enterprises
  # POST /enterprises.json
  def create
    @enterprise = Financial::Institution.new(enterprise_params)

    respond_to do |format|
      if @enterprise.save
        format.html { redirect_to enterprises_path, notice: 'Empresa criada com sucesso.' }
        format.json { render :show, status: :created, location: @enterprise }
      else
        format.html { render :new }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enterprises/1
  # PATCH/PUT /enterprises/1.json
  def update
    respond_to do |format|
      if @enterprise.update(enterprise_params)
        format.html { redirect_to enterprises_path, notice: 'Empresa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @enterprise }
      else
        format.html { render :edit }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enterprises/1
  # DELETE /enterprises/1.json
  def destroy
    puts @enterprise.class
    @enterprise.destroy
    respond_to do |format|
      format.html { redirect_to enterprises_path, notice: 'Empresa excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def list_enterprises
    render json: Financial::Institution.enterprise.pluck(:name, :id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enterprise
      @enterprise = Financial::Institution.find(params[:id])
    end

    # Never trustELECT "transactions".* FROM "transactions" WHERE "transactions"."institution_id" = ? parameters from the scary internet, only allow the white list through.
    def enterprise_params
      parameters = params.require(:enterprise).permit(:name, :kind, :status)
      parameters[:kind] = :enterprise
      return parameters
    end
end
