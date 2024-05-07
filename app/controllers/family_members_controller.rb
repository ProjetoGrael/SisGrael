class FamilyMembersController < ApplicationController
  before_action :family_member_params, only: [:edit, :update]
  before_action :set_family_member, only: [:show, :destroy]

  def new
  end

  def create
    @family_member = FamilyMember.new(family_member_params)
    respond_to do |format|
      if @family_member.save
        format.json { render json: @family_member, status: :created }
      else
        format.json { render json: @family_member.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def show      
  end

  def destroy
    @family_member.destroy
  end

  def list_student_relatives
    id = params[:id]
    student = Student.find(id)
    render json: student.family_members.pluck(
      :name, 
      :age, 
      :scholarity,
      :occupation, 
      :income,
      :id
    )
  end

  private

    def family_member_params
        params.require(:family_member).permit(
          :name,
          :age,
          :scholarity,
          :occupation,
          :income,
          :student_id
        )
    end

    def set_family_member
      @family_member = FamilyMember.find(params[:id])
    end

end