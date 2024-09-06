class ProductsReturn < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  belongs_to :sell, optional: true

  has_many :products_return_lines, dependent: :destroy

  validates :user, :customer, presence: true

  enum state: { "Pendiente": 0, "Devuelto": 1 }

end
