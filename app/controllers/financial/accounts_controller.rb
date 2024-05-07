class Financial::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = if params[:term]
      Financial::Account.where("bank ILIKE (?)","%#{params[:term]}%").paginate(:page => params[:page], :per_page => 20).order("LOWER(bank)")
    else
      Financial::Account.paginate(:page => params[:page], :per_page => 20).order("LOWER(bank)")
    end
  end

  # GET /accounts/new
  def new
    @account = Financial::Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Financial::Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'Conta criada com sucesso.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to accounts_path, notice: 'Conta atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_path, notice: 'Conta excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def list_accounts
    accounts = Financial::Account.pluck(:number, :agency, :bank, :id)
    accounts = accounts.collect {|x| [x[2]+x[1]+x[0], x[3]]}
    render json: accounts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Financial::Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      parameters = params.require(:account).permit(:agency, :number, :bank, :current_value)
      parameters[:current_value] = monetary_string_to_decimal(parameters[:current_value])
      return parameters
    end
end
