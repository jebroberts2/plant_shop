class OrderSerializer < ActiveModel::Serializer
  attributes :order_number, :plant_names
  attribute :prettified_price, key: :price
end
