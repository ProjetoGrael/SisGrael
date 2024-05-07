class Financial::TransactionCategoriesController < ApplicationController
  before_action :set_transaction_category, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /transaction_categories
  # GET /transaction_categories.json
  def index
    @transaction_categories = Financial::TransactionCategory.paginate(:page => params[:page], :per_page => 20).order('LOWER(description)')
  end

  # GET /transaction_categories/new
  def new
    @transaction_category = Financial::TransactionCategory.new
  end

  # GET /transaction_categories/1/edit
  def edit
  end

  # POST /transaction_categories
  # POST /transaction_categories.json
  def create
    @transaction_category = Financial::TransactionCategory.new(transaction_category_params)

    respond_to do |format|
      if @transaction_category.save
        format.html { redirect_to transaction_categories_path, notice: 'Categoria de Transação criada com sucesso.' }
        format.json { render :show, status: :created, location: @transaction_category }
      else
        format.html { render :new }
        format.json { render json: @transaction_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_categories/1
  # PATCH/PUT /transaction_categories/1.json
  def update
    respond_to do |format|
      if @transaction_category.update(transaction_category_params)
        format.html { redirect_to transaction_categories_path, notice: 'Categoria de Transação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @transaction_category }
      else
        format.html { render :edit }
        format.json { render json: @transaction_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_categories/1
  # DELETE /transaction_categories/1.json
  def destroy
    @transaction_category.destroy
    respond_to do |format|
      format.html { redirect_to transaction_categories_url, notice: 'Categoria de Transação excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def list_transaction_categories
    render json: Financial::TransactionCategory.pluck(:description, :id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_category
      @transaction_category = Financial::TransactionCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_category_params
      params.require(:transaction_category).permit(:description)
    end
end
