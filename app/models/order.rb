class Order < ApplicationRecord
  belongs_to :customer
  has_many :plant_orders, dependent: :delete_all
  has_many :plants, through: :plant_orders

  scope :with_order_details, (lambda do |customer:, plant: nil|
    sql = "orders.customer_id = #{customer.id}"
    sql += " AND plant_orders.plant_id = #{plant.id}" if plant

    joins(:plant_orders).where(sql).includes(:plants)
  end)

  def plant_names
    plants.pluck(:name).join(', ')
  end

  def prettified_price
    Money.new(total_price, 'USD').format
  end
end