class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.string :name, null: false, index: true
      t.string :scientific_name, null: false
      t.decimal :price, null: false
      t.integer :available_quantity, null: false
      t.string :fun_fact, null: false
    end
  end
end
