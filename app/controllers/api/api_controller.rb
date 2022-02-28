class Api::ApiController < ActionController::Base
  class InsufficientInventory < StandardError; end
  class NonexistantOrder < StandardError; end

  #the default landing page if you navigate to the root route
  def welcome
    message = "Welcome to the tree and leaf plant shop! Below is a list of actions. "
    message = message + "Note that all routes should be prepended with /api:"

    response = { "#{message}": available_actions }.to_json.gsub("""..", "\n""..")

    render json: response, status: 200
  end

  private

  def available_actions
    {
      "../plants" => 'GET - returns a list of all the plants, including quantities and fun facts',
      "../orders" => 'POST - creates an order (customer_name, plant_name, quantity, and address are required params)',
      "../orders/retrieve_by_customer" => 'GET - retrieves an order (customer_name is required, plant name is optional)',
      "../orders/retrieve_by_number" => 'GET - retrieves an order (order_number is required param)'
    }
  end
end