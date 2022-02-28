class Plant < ApplicationRecord
  has_many :plant_orders, dependent: :delete_all
  has_many :orders, through: :plant_order
end