class Academic::TeacherSkillsController < ApplicationController
  before_action :set_teacher_skill, only: [:destroy]
  load_and_authorize_resource

  # GET /teacher_skills/new
  def new
    @teacher_skill = Academic::TeacherSkill.new
    @teacher_skill.teacher_id ||= params[:teacher_id]
  end

  # POST /teacher_skills
  # POST /teacher_skills.json
  def create
    @teacher_skill = Academic::TeacherSkill.new(teacher_skill_params)

    respond_to do |format|
      if @teacher_skill.save
        format.html { redirect_to @teacher_skill.teacher, notice: 'Habilidade do Educador criada com sucesso.' }
        format.json { render :show, status: :created, location: @teacher_skill }
      else
        format.html { render :new }
        format.json { render json: @teacher_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher_skills/1
  # DELETE /teacher_skills/1.json
  def destroy
    teacher = @teacher_skill.teacher
    @teacher_skill.destroy
    respond_to do |format|
      format.html { redirect_to teacher, notice: 'Habilidade do Educador excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_skill
      @teacher_skill = Academic::TeacherSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_skill_params
      params.require(:teacher_skill).permit(:teacher_id, :subject_id)
    end
end
