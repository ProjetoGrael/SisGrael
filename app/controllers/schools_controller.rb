class SchoolsController < ApplicationController
  before_action :set_school, only: [:edit, :update, :destroy]
  before_action do 
    authorize! :manage, :secretary
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html {redirect_to schools_path}
        format.json
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    if @school.update(school_params)
      redirect_to schools_path
    else
      redirect_to edit_school_path(@school)
    end
  end

  def edit
  end

  def destroy
    @school.destroy
    flash.notice = @school.errors.full_messages.join('\n') if !@school.destroyed?
    redirect_to schools_path

  end

  def index
    @schools = if params[:term]
      School.where("name ILIKE (?)", "%#{params[:term]}%").order('LOWER(name)').paginate(page: params[:page], per_page: 20)
    else
      School.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
    end
  end

  def list_schools
    schools = School.order('LOWER(name)')
    render json: schools.pluck(:name, :id)
  end

  private

  def school_params
    params.require(:school).permit(:name)
  end

  def set_school
    @school = School.find(params[:id])
  end

end
