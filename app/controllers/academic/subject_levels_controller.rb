class Academic::SubjectLevelsController < ApplicationController
  before_action :set_subject_level, only: [:edit, :update, :destroy]

  def new
    @subject_level = Academic::SubjectLevel.new
    @subject_level.subject_id = params[:subject_id]
  end

  def edit
  end

  def create
    @subject_level = Academic::SubjectLevel.new(create_subject_level_params)
    respond_to do |format|
      if @subject_level.save
        format.html { redirect_to @subject_level.subject, notice: 'Nivel adicionado com sucesso!' }
      else
        format.html { render :new }
        format.json { render json: @subject_level.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @subject_level.update(update_subject_level_params)
        format.html { redirect_to @subject_level.subject, notice: 'Nivel atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    subject = @subject_level.subject
    @subject_level.destroy
    respond_to do |format|
      format.html { redirect_to subject, notice: 'Nivel excluído com sucesso.' }
    end
  end

  private
    def create_subject_level_params
      params.require(:subject_level).permit(:name, :order, :subject_id, :active)
    end

    def update_subject_level_params
      params.require(:subject_level).permit(:name, :order, :active)
    end

    def set_subject_level
      @subject_level = Academic::SubjectLevel.find(params[:id])
    end
end
