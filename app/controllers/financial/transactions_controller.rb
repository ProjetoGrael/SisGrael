class Financial::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Financial::Transaction.all.reverse_order.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Financial::Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Financial::Transaction.new(transaction_params)
    contaBanco = @transaction.account

    respond_to do |format|
      if @transaction.save
        contaBanco.current_value -= @transaction.value
        contaBanco.save

        format.html { redirect_to @transaction, notice: 'Transação criada com sucesso.' }
        format.json { render :show, status: :created, location: @transaction }
      
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    valorAntigo = @transaction.value
    valorNovo = BigDecimal.new(transaction_params[:value])
    diferencaValores = valorNovo - valorAntigo
    
    contaBanco = @transaction.account

    respond_to do |format|
      if @transaction.update(transaction_params)
        contaBanco.current_value -= diferencaValores
        contaBanco.save
        
        format.html { redirect_to @transaction, notice: 'Transação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    contaBanco = @transaction.account
    contaBanco.current_value += @transaction.value
    contaBanco.save

    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transação excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  # GET /transactions/form_costs/:cost_type
  def form_costs
    cost_type = params[:cost_type]
    if cost_type == "project"
      @projects = Financial::Project.all
    elsif cost_type == "fixed_cost"
      @fixed_costs = Financial::FixedCost.all
    end
  end

  # GET /transactions/form_rubrics/:project_id
  def form_rubrics
    project = Financial::Project.find(params[:project_id])
    @rubrics = project.rubrics
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Financial::Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      parameters = params.require(:transaction).permit(:value, :transaction_date, :payer_id, :receiver_id, :account_id, :cost_type, :cost_id, :description, :transaction_category_id)
      parameters[:value] = monetary_string_to_decimal(parameters[:value])
      return parameters
    end
end
