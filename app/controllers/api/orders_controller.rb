class Api::OrdersController < ActionController::Base
  def test
    response = 'Poop'

    render json: response
  end
end