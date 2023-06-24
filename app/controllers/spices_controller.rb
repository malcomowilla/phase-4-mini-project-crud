class SpicesController < ApplicationController
rescue_from  ActiveRecord::RecordNotFound, with: :spice_not_found 
rescue_from   ActionController::RoutingError, with: :routing_error

    def index
        spices = Spice.all
        render json:spices
    end
    def show
        spice = find_spice
        render json: spice
        # raise ActionController::RoutingError, "Route not found"


    end
    def create
        spice = Spice.create(spices_params)
        render json:spice, status: :created
    end

        def update
            spice = find_spice
            spice.update(spices_params)
            render json:spice
        end

        def destroy
            spice = find_spice
            spice.destroy
            head :no_content
        end
    private
        def routing_error
            render json:{error: "routing error"}, status: :not_found
        end
    def find_spice
        Spice.find(params[:id])
    end
    def spices_params
        params.permit(:title, :image, :description, :notes, :rating )
    end

    def spice_not_found
        render json: {error: "Spice not found"}, status: :not_found
    end

end
