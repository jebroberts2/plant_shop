class OrderProcessorService
  attr_accessor :customer, :plant, :quantity, :address

  def initialize(customer:, plant:, quantity:, address:)
    @customer = customer
    @plant = plant
    @quantity = quantity.to_i
    @address = address
  end

  # Processes an order and returns a formatted array of the order details
  def process!
    new_quantity = plant.available_quantity - quantity

    raise Api::ApiController::InsufficientInventory unless new_quantity >= 0

    ActiveRecord::Base.transaction do
      # If we extended this service to handle multiple plant types and quantities in one order, we could wrap the
      # PlantOrder creation in a loop through all the plants. We'd want to consider the transaction structure also --
      # would we want whole the order to fail if we can't supply one of the items in the desired quantity? Questions for
      # later...
      order = Order.create!(customer: customer, address: address, order_number: order_number)
      PlantOrder.create!(plant: plant, order: order, quantity: quantity, price: price)
      plant.update(available_quantity: new_quantity)
    end

    { order_number: order_number, plant: plant.name, price: Money.new(price).format }
  end

  def price
    @price ||= plant.price * quantity
  end

  # This is probably ovrkill for an ordr number, but it's a quick way to guarantee uniqueness. I could also use the
  # primary key id for this field, but that seems somewhat crude
  def order_number
    @order_number ||= SecureRandom.uuid
  end
end
