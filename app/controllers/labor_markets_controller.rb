class LaborMarketsController < ApplicationController
  before_action :set_labor_market, only: [:show, :edit, :update, :destroy]
  autocomplete :student, :name, full: true
  load_and_authorize_resource

  # GET /labor_markets
  # GET /labor_markets.json
  def index
    @labor_markets = LaborMarket.all
  end

  # GET /labor_markets/1
  # GET /labor_markets/1.json
  def show
  end

  # GET /labor_markets/new
  def new
    @labor_market = LaborMarket.new
  end

  # GET /labor_markets/1/edit
  def edit
  end

  # POST /labor_markets
  # POST /labor_markets.json
  def create
    @labor_market = LaborMarket.new(labor_market_params)

    respond_to do |format|
      if @labor_market.save
        format.html { redirect_to @labor_market, notice: 'Labor market was successfully created.' }
        format.json { render :show, status: :created, location: @labor_market }
      else
        format.html { render :new }
        format.json { render json: @labor_market.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labor_markets/1
  # PATCH/PUT /labor_markets/1.json
  def update
    respond_to do |format|
      if @labor_market.update(labor_market_params)
        format.html { redirect_to @labor_market, notice: 'Labor market was successfully updated.' }
        format.json { render :show, status: :ok, location: @labor_market }
      else
        format.html { render :edit }
        format.json { render json: @labor_market.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labor_markets/1
  # DELETE /labor_markets/1.json
  def destroy
    @labor_market.destroy
    respond_to do |format|
      format.html { redirect_to labor_markets_url, notice: 'Labor market was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def page

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_labor_market
      @labor_market = LaborMarket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def labor_market_params
      params.require(:labor_market).permit(:year, :student_id, :date_closure, :date_start, :date_exit, :company, :company_address, :student_occupation_area, :student_office, :contact_name, :contact_office, :contact_email, :company_phone_number, :hiring_kind)
    end
end
