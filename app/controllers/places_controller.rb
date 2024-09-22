class PlacesController < ApplicationController
  before_action :set_place, only: %i[ show update destroy ]
  skip_before_action :authenticate, only: %i[ create index show ]

  # GET /places
  def index
    @places = Place.all

    render json: PlacesSerializer.new(Place.all).serializable_hash[:data], status: :accepted
  end

  # GET /places/1
  def show
    render json: PlacesSerializer.new(@place).serializable_hash[:data], status: :accepted
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:state, :city, :street, :number, :name, :description, :photo)
    end
end
