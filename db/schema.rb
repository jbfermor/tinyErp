# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_08_25_121146) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "nif"
    t.string "commercial_name"
    t.string "contact_person"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "province"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bios_on_user_id"
  end

  create_table "buy_lines", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "buy_id", null: false
    t.bigint "product_id", null: false
    t.integer "product_quantity"
    t.decimal "total_buy_line"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_id"], name: "index_buy_lines_on_buy_id"
    t.index ["product_id"], name: "index_buy_lines_on_product_id"
    t.index ["user_id"], name: "index_buy_lines_on_user_id"
  end

  create_table "buys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.decimal "total_buy"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_buys_on_supplier_id"
    t.index ["user_id"], name: "index_buys_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "nif"
    t.string "name"
    t.string "surname1"
    t.string "surname2"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "province"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "inventory_movements", force: :cascade do |t|
    t.integer "movement_type"
    t.integer "movement_subtype"
    t.integer "quantity"
    t.integer "stock_final"
    t.string "reason"
    t.bigint "product_id", null: false
    t.bigint "partial_delivery_id"
    t.bigint "sell_line_id"
    t.bigint "products_return_line_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partial_delivery_id"], name: "index_inventory_movements_on_partial_delivery_id"
    t.index ["product_id"], name: "index_inventory_movements_on_product_id"
    t.index ["products_return_line_id"], name: "index_inventory_movements_on_products_return_line_id"
    t.index ["sell_line_id"], name: "index_inventory_movements_on_sell_line_id"
    t.index ["user_id"], name: "index_inventory_movements_on_user_id"
  end

  create_table "partial_deliveries", force: :cascade do |t|
    t.integer "qty_delivered"
    t.bigint "reception_line_id", null: false
    t.bigint "reception_id", null: false
    t.bigint "product_id", null: false
    t.bigint "supplier_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_partial_deliveries_on_product_id"
    t.index ["reception_id"], name: "index_partial_deliveries_on_reception_id"
    t.index ["reception_line_id"], name: "index_partial_deliveries_on_reception_line_id"
    t.index ["supplier_id"], name: "index_partial_deliveries_on_supplier_id"
    t.index ["user_id"], name: "index_partial_deliveries_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.string "product_name"
    t.text "product_description"
    t.integer "stock"
    t.decimal "buy_price", precision: 10, scale: 2
    t.decimal "sell_price", precision: 10, scale: 2
    t.integer "min_stock"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "products_return_lines", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "total_return"
    t.integer "state"
    t.bigint "products_return_id", null: false
    t.bigint "product_id", null: false
    t.bigint "sell_id", null: false
    t.bigint "sell_line_id", null: false
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_products_return_lines_on_customer_id"
    t.index ["product_id"], name: "index_products_return_lines_on_product_id"
    t.index ["products_return_id"], name: "index_products_return_lines_on_products_return_id"
    t.index ["sell_id"], name: "index_products_return_lines_on_sell_id"
    t.index ["sell_line_id"], name: "index_products_return_lines_on_sell_line_id"
    t.index ["supplier_id"], name: "index_products_return_lines_on_supplier_id"
    t.index ["user_id"], name: "index_products_return_lines_on_user_id"
  end

  create_table "products_returns", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "customer_id", null: false
    t.bigint "sell_id"
    t.integer "state", default: 0
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_products_returns_on_customer_id"
    t.index ["sell_id"], name: "index_products_returns_on_sell_id"
    t.index ["user_id"], name: "index_products_returns_on_user_id"
  end

  create_table "reception_lines", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.bigint "buy_id", null: false
    t.bigint "buy_line_id", null: false
    t.bigint "reception_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity_to_receive"
    t.integer "quantity_received"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_id"], name: "index_reception_lines_on_buy_id"
    t.index ["buy_line_id"], name: "index_reception_lines_on_buy_line_id"
    t.index ["product_id"], name: "index_reception_lines_on_product_id"
    t.index ["reception_id"], name: "index_reception_lines_on_reception_id"
    t.index ["supplier_id"], name: "index_reception_lines_on_supplier_id"
    t.index ["user_id"], name: "index_reception_lines_on_user_id"
  end

  create_table "receptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.bigint "buy_id", null: false
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_id"], name: "index_receptions_on_buy_id"
    t.index ["supplier_id"], name: "index_receptions_on_supplier_id"
    t.index ["user_id"], name: "index_receptions_on_user_id"
  end

  create_table "sell_lines", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "sell_id", null: false
    t.bigint "product_id", null: false
    t.integer "product_quantity"
    t.decimal "total_sell_line"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sell_lines_on_product_id"
    t.index ["sell_id"], name: "index_sell_lines_on_sell_id"
    t.index ["user_id"], name: "index_sell_lines_on_user_id"
  end

  create_table "sells", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "customer_id"
    t.decimal "total_sell"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_sells_on_customer_id"
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "nif"
    t.string "commercial_name"
    t.string "contact_person"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "province"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commercial_name"], name: "index_suppliers_on_commercial_name", unique: true
    t.index ["nif"], name: "index_suppliers_on_nif", unique: true
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "role", default: "super_user"
    t.bigint "super_user_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["super_user_id"], name: "index_users_on_super_user_id"
  end

  create_table "worker_bios", force: :cascade do |t|
    t.string "nif"
    t.string "name"
    t.string "surname1"
    t.string "surname2"
    t.string "address"
    t.string "city"
    t.string "postal"
    t.string "province"
    t.string "phone"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_worker_bios_on_user_id"
  end

  add_foreign_key "bios", "users"
  add_foreign_key "buy_lines", "buys"
  add_foreign_key "buy_lines", "products"
  add_foreign_key "buy_lines", "users"
  add_foreign_key "buys", "suppliers"
  add_foreign_key "buys", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "inventory_movements", "partial_deliveries"
  add_foreign_key "inventory_movements", "products"
  add_foreign_key "inventory_movements", "products_return_lines"
  add_foreign_key "inventory_movements", "sell_lines"
  add_foreign_key "inventory_movements", "users"
  add_foreign_key "partial_deliveries", "products"
  add_foreign_key "partial_deliveries", "reception_lines"
  add_foreign_key "partial_deliveries", "receptions"
  add_foreign_key "partial_deliveries", "suppliers"
  add_foreign_key "partial_deliveries", "users"
  add_foreign_key "products", "suppliers"
  add_foreign_key "products", "users"
  add_foreign_key "products_return_lines", "customers"
  add_foreign_key "products_return_lines", "products"
  add_foreign_key "products_return_lines", "products_returns"
  add_foreign_key "products_return_lines", "sell_lines"
  add_foreign_key "products_return_lines", "sells"
  add_foreign_key "products_return_lines", "suppliers"
  add_foreign_key "products_return_lines", "users"
  add_foreign_key "products_returns", "customers"
  add_foreign_key "products_returns", "sells"
  add_foreign_key "products_returns", "users"
  add_foreign_key "reception_lines", "buy_lines"
  add_foreign_key "reception_lines", "buys"
  add_foreign_key "reception_lines", "products"
  add_foreign_key "reception_lines", "receptions"
  add_foreign_key "reception_lines", "suppliers"
  add_foreign_key "reception_lines", "users"
  add_foreign_key "receptions", "buys"
  add_foreign_key "receptions", "suppliers"
  add_foreign_key "receptions", "users"
  add_foreign_key "sell_lines", "products"
  add_foreign_key "sell_lines", "sells"
  add_foreign_key "sell_lines", "users"
  add_foreign_key "sells", "customers"
  add_foreign_key "sells", "users"
  add_foreign_key "suppliers", "users"
  add_foreign_key "users", "users", column: "super_user_id"
  add_foreign_key "worker_bios", "users"
end
