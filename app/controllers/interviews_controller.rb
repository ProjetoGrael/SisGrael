class InterviewsController < ApplicationController
  autocomplete :student, :name, full: true
  before_action :set_interviews, only: [:create, :new]
  before_action :set_interview, only: [:show, :destroy]
  def create
    @interview = Interview.new(interview_params)
    respond_to do |format|
      if @interview.save
        format.html { redirect_to new_interview_path, notice: 'Entrevista criada com sucesso' }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def new
    @interview = Interview.new
  end

  def index
    aux_array = []
    user = User.find(params[:user_id])
    free_times = user.free_times.where('day >= ?', Date.today).order(:day)
    free_times.each { |free_time| aux_array.push(free_time.format_hash) }

    @free_times = aux_array
    @interviews = user.interviews.where('date_of_interview >= ?', Date.today).order(:date_of_interview)
    @free_time = FreeTime.new
  end

    #def delete
    #    @interview = Interview.find(params[:id])
    #    @interview.destroy
    #    respond_to do |format|
    #        format.html {redirect_to interview_index_path(@interview.user_id)}
    #    end
    #end

  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to new_interview_path, notice: 'Entrevista excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def interview_params
      params.require(:interview).permit(:student_name, :student_id, :user_id, :reason, :time_of_interview, :date_of_interview, :kind)
    end

    def set_interview
      @interview = Interview.find(params[:id])
    end

    def set_interviews
      @interviews = Interview.where('date_of_interview >= ?', Date.today).order('date_of_interview DESC')
    end

end
