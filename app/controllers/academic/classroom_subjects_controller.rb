class Academic::ClassroomSubjectsController < ApplicationController
  before_action :set_classroom_subject, only: [:show, :update, :destroy,:generate_schedule, :schedule_date,:edit, :promote]
  load_and_authorize_resource
  include Academic::ClassroomSubjectsHelper
  def list_classroom_subjects
    classroom = Academic::Classroom.find(params[:classroom_id])
    leveled_classroom_subjects = classroom.classroom_subjects.select { |el| el.subject.leveled }
    
    render json: leveled_classroom_subjects.map {|el| [el.subject.name, el.subject.subject_levels.pluck(:name, :id), el.id]}
  end

  def index
    @teacher = Academic::Teacher.find(params[:teacher_id])
    
    @old_classroom_subjects, @current_classroom_subjects = get_classroom_subject(@teacher)
  
  end

  def promote
    @classroom_subject.classroom.update_attributes(main_id: @classroom_subject.id)
    redirect_to @classroom_subject.classroom, notice: 'Disciplina promovida com sucesso'
  end

  def new
    @classroom_subject = Academic::ClassroomSubject.new
    @classroom = Academic::Classroom.find(params[:classroom_id])
  end

  def show
  end

  def edit
  end
  # POST /classroom_subjects
  # POST /classroom_subjects.json
  def create
    @classroom_subject = Academic::ClassroomSubject.new(classroom_subject_params)

    respond_to do |format|
      if @classroom_subject.save
        format.html { redirect_to @classroom_subject.classroom, notice: 'Curso criado com sucesso.' }
        format.json { render :show, status: :created, location: @classroom_subject }
      else
        format.html { render :new }
        format.json { render json: @classroom_subject.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /classroom_subjects/1
  # PATCH/PUT /classroom_subjects/1.json
  def update
    respond_to do |format|
      if @classroom_subject.update(classroom_subject_params)
        format.html { redirect_to @classroom_subject.classroom, notice: 'Curso atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @classroom_subject }
      else
        format.html { render :edit }
        format.json { render json: @classroom_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classroom_subjects/1
  # DELETE /classroom_subjects/1.json
  def destroy
    classroom = @classroom_subject.classroom
    @classroom_subject.destroy
    respond_to do |format|
      format.html { redirect_to classroom, notice: 'Curso excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def schedule_date
    @inscriptions = @classroom_subject.classroom.inscriptions.joins(:student).order('LOWER(name)').not_evaded
    respond_to do |format|
      format.pdf do
        render pdf: 'schedule.pdf.erb',
        title: 'Curso '+ @classroom_subject.subject.name,
        orientation: 'Landscape'
      end
    end
  end
  

  def generate_schedule
    @inscriptions = @classroom_subject.classroom.inscriptions.joins(:student).order('LOWER(name)').not_evaded
    @lessons_by_month = {}
    @classroom_subject.lessons.each do |lesson|
      if(@lessons_by_month[lesson.day.to_s[0,7]] == nil)
        @lessons_by_month[lesson.day.to_s[0,7]] = []
      end
      @lessons_by_month[lesson.day.to_s[0,7]].push(lesson)
    end
    respond_to do |format|
      format.pdf do
        render ({
          pdf: 'schedule.pdf.erb', 
          title: 'Curso '+ @classroom_subject.subject.name,
          orientation: 'Landscape'
        })
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom_subject
      @classroom_subject = Academic::ClassroomSubject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_subject_params
      params.require(:classroom_subject).permit(
        :classroom_id,
        :subject_id,
        :teacher_id,
        :start_time,
        :finish_time,
        :lesson_on_monday,
        :lesson_on_tuesday,
        :lesson_on_wednesday,
        :lesson_on_thursday,
        :lesson_on_friday
        )
    end
end
