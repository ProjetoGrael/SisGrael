class Academic::StudentClassroomSubjectsController < ApplicationController
  before_action :set_student_classroom_subject, only: [:update]
  
  def update
    respond_to do |format|
      if @student_classroom_subject.update(student_classroom_subject_params)
        
        format.html { redirect_to @student_classroom_subject.classroom, notice: 'Curso atualizado com sucesso.' }
        format.json { render json: @student_classroom_subject, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @student_classroom_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def student_classroom_subject_params
      params.require(:student_classroom_subject).permit(:show)
    end
    def set_student_classroom_subject
      
      @student_classroom_subject = Academic::StudentClassroomSubject.find(params[:id])
      
    end

end