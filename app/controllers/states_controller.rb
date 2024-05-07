class StatesController < ApplicationController
  before_action :set_state, only: [:edit, :update, :destroy]
  before_action do 
    authorize! :manage, :secretary
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)

    if @state.save
      redirect_to states_path
    else
      redirect_to new_state_path
    end

  end

  def update
    if @state.update(state_params)
      redirect_to states_path
    else
      redirect_to edit_state_path(@state)
    end
  end

  def edit
  end

  def destroy
    @state.destroy
    flash.notice = @state.errors.full_messages.join('\n') if !@state.destroyed?
    redirect_to states_path

  end

  def index
    @states = State.all
  end

  private
    def state_params
      params.require(:state).permit(:name)
    end

    def set_state
      @state = State.find(params[:id])
    end

end
