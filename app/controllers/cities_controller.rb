class CitiesController < ApplicationController
    before_action :set_city, only: [:edit, :update, :destroy]
    before_action do 
      authorize! :manage, :secretary
    end
    
    def new
      @city = City.new
    end
  
    def create
      @city = City.new(city_params)

      respond_to do |format|
        if @city.save
          format.html {redirect_to cities_path}
          format.json
        else
          format.html { render :new }
          format.json { render json: @city.errors, status: :unprocessable_entity }
        end
      end

    end
  
    def update
      if @city.update(city_params)
        redirect_to cities_path
      else
        redirect_to edit_city_path(@city)
      end
    end
  
    def edit
    end
  
    def destroy
      @city.destroy
      flash.notice = @city.errors.full_messages.join('\n') if !@city.destroyed?
      redirect_to cities_path
  
    end
  
    def index
      @cities = City.all
    end

    def list_cities
      id = params.permit(:state_id)
      id = id[:state_id]
      state = State.find(id)
      render json: state.cities.order('LOWER(name)').pluck(:name, :id)
    end
  
    private
      def city_params
        params.require(:city).permit(:name, :state_id)
      end
    
      def set_city
        @city = City.find(params[:id])
      end
end
