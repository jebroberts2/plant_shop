class Api::OrdersController < Api::ApiController
  before_action :set_current_customer!, except: [:retrieve_by_number]
  before_action :validate_order_params!, only: [:create]
  before_action :set_plant, only: [:create]
  skip_before_action :verify_authenticity_token

  rescue_from InsufficientInventory, with: :render_insufficient_inventory
  rescue_from NonexistantOrder, with: :render_nonexistant_order

  def create
    order_details = OrderProcessorService.new(order_details_hash).process!

    response = { message: "Order successful!" }.merge(order_details)

    render json: response.to_json, status: 200
  end

  # Retrieves a group of orders with a particular set of attributes
  # Note: this operation probably belongs in a customers controller (lookup all orders by customer) which we don't have
  def retrieve_by_customer
    set_plant if params[:plant_name]

    orders = Order.with_order_details(order_details_hash.slice(:customer, :plant))

    raise NonexistantOrder unless orders.present?

    render json: orders, each_serializer: OrderSerializer, status: 200
  end

  # retrieves the order by customer. We might want to consider merging this
  def retrieve_by_number
    order = Order.find_by(order_number: params[:order_number])

    raise NonexistantOrder unless order

    render json: order, serializer: OrderSerializer, status: 200
  end

  private

  # Stores a hash of order details for the controller
  def order_details_hash
    { customer: @current_customer, plant: @plant, quantity: params[:quantity], address: params[:address] }
  end

  # Renders and insufficient inventory error
  def render_insufficient_inventory
    message = "Sorry, we don't have enough inventory to complete your request. "
    message += "Please check the /plants route for current inventory levels"
    render json: message, status: 404
  end

  # Renders a nonexistant order error
  def render_nonexistant_order
    render json: 'Yeah, looks like no orders exist with those attributes...', status: 404
  end

  # Memoizes the plant for the order
  def set_plant
    @plant ||= Plant.find_by!(name: params[:plant_name])
  rescue ActiveRecord::RecordNotFound
    render json: "Oops! Looks like we don't sell those. To see our full stock list, visit the /plant route", status: 404
  end

  # Sets the current customer and creates a new one if there is no customer with that name already in the db.
  # Todo: Move to application controller and create a login and more robust authentication. It's only here now because
  # I'm not requiring the user id in the application controller
  def set_current_customer!
    raise unless params[:customer_name]

    @current_customer ||= Customer.find_by(name: params[:customer_name]) ||
      Customer.create!(name: params[:customer_name])
  rescue StandardError
    render json: 'You must supply a customer name!', status: 404
  end

  # Validates a set of order params for completeness.
  # Note: This is NOT for security purposes and doesn't actually sanitize the params. It simply is a home rolled version
  # of params.require, which is available for active record params.
  def validate_order_params!
    missing_fields = []

    required_order_fields.each do |field|
      missing_fields.push(field) unless params[field]
    end

    raise unless missing_fields.blank?
  rescue StandardError
    render json: "You are missing the following params in your request: #{missing_fields}", status: 404
  end

  def required_order_fields
    %w(plant_name quantity address)
  end
end
