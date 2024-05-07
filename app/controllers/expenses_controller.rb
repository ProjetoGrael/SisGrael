class ExpensesController < ApplicationController
  before_action :set_expense, only: [:destroy]

  def list_student_expenses
    student = Student.find(params[:id])
    expenses = student.expenses
    render json: expenses.pluck(
      :name, 
      :value,
      :id
    )
  end
  
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.json { render json: @expense, status: :created }
      else
        format.json { render json: @expense.errors.full_messages, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @expense.destroy
  end

  private
  def expense_params
      params.require(:expense).permit(
        :name,
        :value,
        :student_id
      )
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

end
