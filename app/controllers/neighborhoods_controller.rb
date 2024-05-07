class NeighborhoodsController < ApplicationController
    before_action :set_neighborhood, only: [:edit, :update, :destroy]
    before_action do 
      authorize! :manage, :secretary
    end
    
    def new
      @neighborhood = Neighborhood.new
    end
  
    def create
      @neighborhood = Neighborhood.new(neighborhood_params)

      respond_to do |format|
        if @neighborhood.save
          format.html {redirect_to neighborhoods_path}
          format.json
        else
          format.html { render :new }
          format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
        end
      end
  
    end
  
    def update
      if @neighborhood.update(neighborhood_params)
        redirect_to neighborhoods_path
      else
        redirect_to edit_neighborhood_path(@neighborhood)
      end
    end
  
    def edit
    end
  
    def destroy
      @neighborhood.destroy
      flash.notice = @neighborhood.errors.full_messages.join('\n') if !@neighborhood.destroyed?
      redirect_to neighborhoods_path
  
    end
  
    def index
      @neighborhoods = Neighborhood.all
    end

    def list_neighborhoods
      id = params.permit(:city_id)
      id = id[:city_id]
      city = City.find(id)
      render json: city.neighborhoods.order('LOWER(name)').pluck(:name, :id)
    end
  
    private
  
    def neighborhood_params
      params.require(:neighborhood).permit(:name, :city_id)
    end
  
    def set_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end
end
