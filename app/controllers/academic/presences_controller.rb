class Academic::PresencesController < ApplicationController
  before_action :set_presence, only: [:update]

  def update
    if @presence.update(update_presence_params)
      render json: @presence, status: :ok
    else
      render json: @presence.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

    def update_presence_params
      params.require(:presence).permit(:situation)
    end

    def set_presence
      @presence = Academic::Presence.find(params[:id])
    end
end