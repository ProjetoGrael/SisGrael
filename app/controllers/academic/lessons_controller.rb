class Academic::LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /lessons
  # GET /lessons.json
  def index
    year = params[:year].to_i
    month = params[:month].to_i
    @classroom_subject = Academic::ClassroomSubject.find(params[:classroom_subject_id])
    @lessons = @classroom_subject.lessons.order('day').paginate(page: params[:page], per_page: 10)
    beginer = Date.new(year, month, 1)
    final = beginer.end_of_month
    temp = @classroom_subject.lessons.order('day').where('day >= ?', beginer).where('day <= ?',final)
    @lessons = temp unless temp.empty?
    @lessons = @lessons.where("day <= ?", Time.now.to_date) #Validação para só mostrar as aulas anteriores ao dia de hoje
    @pagination = true if temp.empty? 
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @presences = @lesson.presences.joins(:student).where.not(students:{status: "evaded"}).where.not(students:{status: "desisted"}).order('LOWER(name)')
  end

  # GET /lessons/new
  def new
    @lesson = Academic::Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  def save_all   
    there_is_erro = false
    array = params.require(:presences)
    array.each do |item|
      data = item[:presence]
      presence = Academic::Presence.find(data[:id])
      unless presence.update_attributes(situation: data[:situation],participation: data[:participation])
        there_is_erro = true
      end
    end
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Academic::Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Aula criada com sucesso.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Aula atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    classroom_subject = @lesson.classroom_subject
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to classroom_subject_lessons_path(classroom_subject, Date.current.year, Date.current.month), notice: 'Aula excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Academic::Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:notes, :observations, :day, :classroom_subject_id)
    end
end
