class Academic::HolidaysController < ApplicationController
  before_action :set_academic_holiday, only: [:show, :edit, :update]

  # GET /academic/holidays
  # GET /academic/holidays.json
  def index
    @school_year = Academic::SchoolYear.find(params[:school_year_id])
    @academic_holidays = @school_year.holidays
  end

  # GET /academic/holidays/new
  def new
    @academic_holiday = Academic::Holiday.new
  end

  # GET /academic/holidays/1/edit
  def edit
  end

  # POST /academic/holidays
  # POST /academic/holidays.json
  def create
    @academic_holiday = Academic::Holiday.new(academic_holiday_params)

    respond_to do |format|
      if @academic_holiday.save
        format.json { render json: @academic_holiday, status: :created, location: @academic_holiday }
      else
        format.json { render json: @academic_holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /academic/holidays/1
  # PATCH/PUT /academic/holidays/1.json
  def update
    respond_to do |format|
      if @academic_holiday.update(academic_holiday_params)
        format.html { redirect_to school_year_holidays_path(@academic_holiday.school_year_id), notice: 'Dia sem Aula atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @academic_holiday }
      else
        format.html { render :edit }
        format.json { render json: @academic_holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academic/holidays/1
  # DELETE /academic/holidays/1.json
  def destroy
    @academic_holiday = Academic::Holiday.find_by!(day: params[:id])
    school_year_id = @academic_holiday.school_year_id
    @academic_holiday.destroy
    respond_to do |format|
      format.html { redirect_to school_year_holidays_path(school_year_id), notice: 'Dia sem Aula excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_holiday
      @academic_holiday = Academic::Holiday.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def academic_holiday_params
      
      params.require(:body).require(:holiday).permit(:name, :day, :school_year_id)
    end
end
