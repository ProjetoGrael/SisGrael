class FreeTimesController < ApplicationController
  before_action :set_free_time, only: [:show, :edit, :update, :destroy]

  # GET /free_times
  # GET /free_times.json
  def index
    @free_times = FreeTime.all
  end

  # GET /free_times/1
  # GET /free_times/1.json
  def show
  end

  # GET /free_times/new
  def new
    @free_time = FreeTime.new
  end

  # GET /free_times/1/edit
  def edit
  end

  def get_free_time
    free_times = FreeTime.where('day >= ?', Date.today).order(:day).joins(:user).select(:day, :start_at, :finish_at, :user_id)
    aux_array = []
    free_times.each do |ft|
      aux_array.push({ day: ft.day, start_at: ft.start_at.strftime("%H:%M"), finish_at: ft.finish_at.strftime("%H:%M"), 
                       user_name: User.find(ft.user_id).name, user_id: ft.user_id })
    end
    @free_times = aux_array

    render json: @free_times
  end
  # POST /free_times
  # POST /free_times.json
  def create
    @free_time = FreeTime.new(free_time_params)
    @free_time.user = current_user
    
    @free_times = set_free_times
    @interviews = current_user.interviews.where('date_of_interview >= ?', Date.today).order(:date_of_interview)
    
    respond_to do |format|
      if @free_time.save
        format.html { redirect_to index_interview_path(current_user), notice: 'Free time was successfully created.' }
        format.json { redirect_to :social_service_index, status: :created, location: @free_time }
      else
        format.html { render 'interviews/index' }
        format.json { render json: @free_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /free_times/1
  # PATCH/PUT /free_times/1.json
  def update
    respond_to do |format|
      if @free_time.update(free_time_params)
        format.html { redirect_to @free_time, notice: 'Free time was successfully updated.' }
        format.json { render :show, status: :ok, location: @free_time }
      else
        format.html { render :edit }
        format.json { render json: @free_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /free_times/1
  # DELETE /free_times/1.json
  def destroy
    @free_time.destroy
    respond_to do |format|
      format.html { redirect_to index_interview_path(current_user), notice: 'Free time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_free_time
      @free_time = FreeTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def free_time_params
      params.require(:free_time).permit(:day, :start_at, :finish_at)
    end

    def set_free_times
      aux_array = []
      current_user.free_times.where('day >= ?', Date.today).order(:day).each{|free_time| aux_array.push(free_time.format_hash)}
      return aux_array
    end
end
