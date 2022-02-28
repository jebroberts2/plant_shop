class CreatePlantOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :plant_orders do |t|
      t.belongs_to :plant, null: false
      t.belongs_to :order, null: false
      t.integer :quantity, null: false
      t.decimal :price, null: false
    end
  end
end
