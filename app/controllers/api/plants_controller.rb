require 'json'

class Api::PlantsController < Api::ApiController
  def index
    plants = Plant.all

    render json: format_plants(plants.to_json), status: 200
  end

  private

  def format_plants(plants)
    plants.gsub(/,/, ",\n").gsub(/},/, "},\n")
  end
end