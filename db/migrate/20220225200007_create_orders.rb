class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, null: false
      t.string :order_number, null: false
      t.string :address
      t.integer :total_price
    end

    add_index :orders, :order_number, unique: true
  end
end
