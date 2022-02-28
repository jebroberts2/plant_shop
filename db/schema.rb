# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_27_215438) do

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_customers_on_name", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "order_number", null: false
    t.string "address"
    t.integer "total_price"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["order_number"], name: "index_orders_on_order_number", unique: true
  end

  create_table "plant_orders", force: :cascade do |t|
    t.integer "plant_id", null: false
    t.integer "order_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", null: false
    t.index ["order_id"], name: "index_plant_orders_on_order_id"
    t.index ["plant_id"], name: "index_plant_orders_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name", null: false
    t.string "scientific_name", null: false
    t.decimal "price", null: false
    t.integer "available_quantity", null: false
    t.string "fun_fact", null: false
    t.index ["name"], name: "index_plants_on_name"
  end

end
