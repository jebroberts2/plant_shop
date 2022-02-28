class PlantSerializer < ActiveModel::Serializer
  attributes :id, :name, :scientific_name, :price, :available_quantity
end
