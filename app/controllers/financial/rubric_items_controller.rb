class Financial::RubricItemsController < ApplicationController
  before_action :set_rubric_item, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /rubric_items/1
  def show
  end

  # GET /rubric_items/new
  def new
    @rubric_item = Financial::RubricItem.new
  end

  # GET /rubric_items/1/edit
  def edit
  end

  # POST /rubric_items
  # POST /rubric_items.json
  def create
    @rubric_item = Financial::RubricItem.new(rubric_item_params)
    @rubric = Financial::Rubric.find(params[:rubric_item][:rubric_id])
    
    new_value = @rubric_item.value

    respond_to do |format|
      if @rubric.current_value < new_value
        format.html { redirect_to @rubric, notice: 'Valor supera saldo de Rubrica.' }
        format.json { render json: @rubric_item.errors, status: :unprocessable_entity }
      else
        if @rubric_item.save
          @rubric.adjust_current_value(new_value)
          format.html { redirect_to @rubric, notice: 'Item de Rubrica criado com sucesso.' }
          format.json { render :show, status: :created, location: @rubric_item }
        else
          format.html { redirect_to @rubric, notice: @rubric_item.errors.full_messages.join('. ') }
          format.json { render json: @rubric_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /rubric_items/1
  # PATCH/PUT /rubric_items/1.json
  def update
    new_value = rubric_item_params[:value]
    rubric = @rubric_item.rubric
    values_diference = new_value - @rubric_item.value

    respond_to do |format|
      if rubric.current_value <= values_diference
        format.html { redirect_to rubric, notice: 'Valor supera saldo de Rubrica.' }
        format.json { render json: @rubric_item.errors, status: :unprocessable_entity }
      else
        if @rubric_item.update(rubric_item_params)
          rubric.adjust_current_value(values_diference)
          format.html { redirect_to @rubric_item.rubric, notice: 'Item de Rubrica atualizado com sucesso.' }
          format.json { render :show, status: :ok, location: @rubric_item }
        else
          debugger
          format.html { render :edit }
          format.json { render json: @rubric_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /rubric_items/1
  # DELETE /rubric_items/1.json
  def destroy
    rubric = @rubric_item.rubric
    rubric.adjust_current_value(-@rubric_item.value)
    @rubric_item.destroy

    respond_to do |format|
      format.html { redirect_to @rubric_item.rubric, notice: 'Item de Rubrica excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rubric_item
      @rubric_item = Financial::RubricItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rubric_item_params
      parameters = params.require(:rubric_item).permit(:numeration, :description, :value, :rubric_id)
      parameters[:value] = monetary_string_to_decimal(parameters[:value])
      return parameters
    end
end
