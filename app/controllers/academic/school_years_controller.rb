class Academic::SchoolYearsController < ApplicationController
  before_action :set_school_year, only: [:show, :edit, :update, :destroy,:school_year_info, :calendary]
  load_and_authorize_resource

  # GET /school_years
  # GET /school_years.json
  def index
    @school_years = Academic::SchoolYear.order(:start)
  end

  def calendary
    @days = []
    @date = []
    time = @school_year.start + params[:current_month].to_i.month
    time = (time - time.day.day) + 1 if params[:current_month].to_i.month != 0
    @week_day = time.wday
    @month = time.mon
    @month_name = "#{month_translate time.mon} de #{time.year}"
    @current_month = params[:current_month].to_i
    while time.mon == @month
      @days.push(time.day)
      @date.push(time)
      
      time += 1.day
    end
  end
  # GET /school_years/new
  def new
    @school_year = Academic::SchoolYear.new
  end

  # GET /school_years/1/edit
  def edit
  end

  # POST /school_years
  # POST /school_years.json
  def create
    @school_year = Academic::SchoolYear.new(school_year_params)

    respond_to do |format|
      if @school_year.save
        format.html { redirect_to school_years_path, notice: 'Período Letivo criado com sucesso.' }
        format.json { render :show, status: :created, location: @school_year }
      else
        format.html { render :new }
        format.json { render json: @school_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_years/1
  # PATCH/PUT /school_years/1.json
  def update
    respond_to do |format|
      if @school_year.update(school_year_params)
        format.html { redirect_to school_years_path, notice: 'Período Letivo atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @school_year }
      else
        format.html { render :edit }
        format.json { render json: @school_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_years/1
  # DELETE /school_years/1.json
  def destroy
    @school_year.destroy
    respond_to do |format|
      format.html { redirect_to school_years_url, notice: 'Período Letivo excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def generate_info_of_school_year
    @inscriptions = @school_year.inscriptions.active
    respond_to do |format|
       format.csv{ send_data @school_year.csv_info_school_year, filename: "informacao-dos-alunos-do-periodo-#{@school_year.name}.csv"}
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_year
      @school_year = Academic::SchoolYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_year_params
      params.require(:school_year).permit(:name, :start, :final, :status, :capacity, :background_image)
    end

    def month_translate id_mon
      return "Janeiro" if id_mon == 1
      return "Fevereiro" if id_mon == 2
      return "Março" if id_mon == 3
      return "Abril" if id_mon == 4
      return "Maio" if id_mon == 5
      return "Junho" if id_mon == 6
      return "Julho" if id_mon == 7
      return "Agosto" if id_mon == 8
      return "Setembro" if id_mon == 9
      return "Outubro" if id_mon == 10
      return "Novembro" if id_mon == 11
      return "Dezembro" if id_mon == 12


    end
end
