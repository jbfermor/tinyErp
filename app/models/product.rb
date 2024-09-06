class Product < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  has_many :buy_lines, dependent: :destroy
  has_many :sell_lines, dependent: :destroy
  has_many :reception_lines, dependent: :destroy
  has_many :inventory_movements, dependent: :destroy
  has_many :partial_deliveries, dependent: :destroy

  # Define enums for state
  enum state: { Activo: 0, Inactivo: 1 }

  # Validations
  validates :product_name, presence: true
  validates :buy_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :buy_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :min_stock, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

end
