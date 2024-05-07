class Academic::InscriptionsController < ApplicationController
  before_action :set_academic_inscription, only: [:show, :edit, :update, :destroy, :inactive]

  # POST /academic/inscriptions
  # POST /academic/inscriptions.json

  def new
    @inscription = Academic::Inscription.new

    school_year = Academic::SchoolYear.current
    @classrooms = school_year.classrooms.pluck(:fantasy_name, :id)
  end

  def create
    @academic_inscription = Academic::Inscription.new(academic_inscription_params)
    
    if @academic_inscription.valid?
      @academic_inscription.save
      
      unless Academic::SubjectHistory.create_from_inscription(@academic_inscription, params[:inscription][:classroom_subjects])
        flash.notice = "Ocorreu um problema com a Inscrição. Por favor tente novamente."
        student = @academic_inscription.student
        @academic_inscription.destroy
        redirect_to student
      end
        flash.notice = "Inscrição feita com sucesso."
    else
      unless @academic_inscription.valid?
        flash.notice = @academic_inscription.errors.full_messages[0]
      else
        flash.notice = "Ocorreu um problema com a Inscrição. Por favor tente novamente."
      end
    end
    redirect_to @academic_inscription.student
  end

  # PATCH/PUT /academic/inscriptions/1
  # PATCH/PUT /academic/inscriptions/1.json
  def update
    respond_to do |format|
      if @academic_inscription.update(academic_inscription_params)
        format.html { redirect_to @academic_inscription, notice: 'Inscrição atualizada com sucesso.' }
        format.json { render json: @academic_inscription, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @academic_inscription.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def inactive
    @academic_inscription.update_attributes(active: false)
    respond_to do |format|
      format.html{redirect_to @academic_inscription.classroom, notice: 'Inscrição excluída com sucesso'}
    end
  end

  # DELETE /academic/inscriptions/1
  # DELETE /academic/inscriptions/1.json
  def destroy
    classroom = @academic_inscription.classroom
    @academic_inscription.destroy
    respond_to do |format|
      format.html { redirect_to classroom, notice: 'Inscrição excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_inscription
      @academic_inscription = Academic::Inscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def academic_inscription_params
      params.require(:inscription).permit(:student_id, :classroom_id, :counsel_opinion, :situation)
    end
end
