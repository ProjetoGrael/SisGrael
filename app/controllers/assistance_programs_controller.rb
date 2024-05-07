class AssistanceProgramsController < ApplicationController
    before_action :set_program, only: [:edit, :update, :destroy]
    
    def new
      @program = AssistanceProgram.new
    end

    def create_student_program

      @program_aid = ProgramAid.new(program_aid_params)
      
      respond_to do |format|
        if @program_aid.save
          format.json {render json: @program_aid, status: :created }
        else
          format.json { render json: @program_aid.errors.full_messages, status: :unprocessable_entity }
        end
      end 
  
    end

    def create
      @program = AssistanceProgram.new(program_params)

      respond_to do |format|
        if @program.save
          format.json { render json: @program, status: :created }
        else
          format.json { render json: @program.errors.full_messages, status: :unprocessable_entity }
        end
      end

    end
  
    def update
      if @program.update(program_params)
        redirect_to assistance_programs_path
      else
        redirect_to edit_assistance_program_path(@program)
      end
    end
  
    def edit
    end
  
    def destroy_user_program
      @program_aid = ProgramAid.find(params[:id])
      @program_aid.destroy
    end

    def destroy
      @program.destroy
    end
  
    def index
      @programs = AssistanceProgram.all
    end

    def list_student_programs
      # id = params.permit(:student_id)
      # id = id[:student_id]
      id = params[:id]
      student = Student.find(id)
      assistance_programs = student.assistance_programs
      list_array = []

      assistance_programs.each do |program|
        name = program.name
        program_aid = program.program_aids.where(["student_id = ?", id]).first
        value = program_aid.value
        program_aid_id = program_aid.id
        array = [name, value, program_aid_id]

        list_array.push(array)

      end

      render json: list_array

    end

    def list_all_programs
      programs = AssistanceProgram.all
      render json: programs.order('LOWER(name)').pluck(:name, :id)
    end
  
    private
      def program_params
        params.require(:assistance_program).permit(
          :name
          )
      end

      def program_aid_params
        params.require(:program_aid).permit(
          :student_id,
          :assistance_program_id,
          :value
        )
      end
    
      def set_program
        @program = AssistanceProgram.find(params[:id])
      end
end
