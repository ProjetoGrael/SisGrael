class Academic::SubjectHistoriesController < ApplicationController
  before_action :set_subject_history, only: [:update, :destroy]

  #Função para toda vez que clicar no botão de resolver as faltas do aluno, a hora ser atualizada,
  # e só passar a contabilizar a partir dessa data novamente
  def update_date_resolved_absence
    @student = Student.find(params[:student_id])

    classroom_subject = Academic::ClassroomSubject.find(params[:classroom_subject_id])

    subject_history = Academic::SubjectHistory.find_by(inscription_id: Academic::Inscription.where(student: @student), classroom_subject_id: classroom_subject.id)

    subject_history.date_resolved_absence = Time.now
    subject_history.save

    redirect_to new_occurrence_path(student_id: @student.id)
  end

  def final_evaluation
    @classroom_subject = Academic::ClassroomSubject.find(params[:id])
    @classroom = @classroom_subject.classroom
    @students = @classroom.students.all
  end

  def list_history
    student = Student.find(params[:student_id])
    @subject_histories = student.subject_histories.sort_by {|t| t.school_year.name }

    @subject_histories = @subject_histories.map { |el| {
      school_year: el.school_year.name,
      classroom: el.classroom.fantasy_name,
      subject: el.subject.name,
      teacher: el.teacher.name,
      presence: el.presence,
      justified_absences: el.justified_absences,
      partial_counsel: el.partial_counsel,  
      final_counsel: el.final_counsel,
      council_opinion: el.counsel_opinion
      }
    }

    respond_to do |format|
      format.json { render json: @subject_histories, status: :ok }
    end
  end

  # POST /subject_histories
  # POST /subject_histories.json
  def create
    @subject_history = Academic::SubjectHistory.new(subject_history_params)

    respond_to do |format|
      if @subject_history.save
        format.html { redirect_to @subject_history, notice: 'Registro do Histórico criado com sucesso.' }
        format.json { render :show, status: :created, location: @subject_history }
      else
        format.html { render :new }
        format.json { render json: @subject_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subject_histories/1
  # PATCH/PUT /subject_histories/1.json
  def update
    respond_to do |format|
      if @subject_history.update(subject_history_params)
        format.html { redirect_to @subject_history, notice: 'Registro do Histórico atualizado com sucesso.' }
        format.json { render json: @subject_history, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @subject_history.errors.full_messages, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /subject_histories/1
  # DELETE /subject_histories/1.json
  def destroy
    @subject_history.destroy
    respond_to do |format|
      format.html { redirect_to subject_histories_url, notice: 'Registro do Histórico excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject_history
      @subject_history = Academic::SubjectHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_history_params
      params.require(:subject_history).permit(
        :student_id,
        :classroom_subject_id,
        :presence,
        :justified_absences,
        :partial_counsel,
        :final_counsel,
        :counsel_opinion,
        :situation,
        :done
      )
    end
end
