class PartialDelivery < ApplicationRecord
  belongs_to :reception_line
  belongs_to :reception
  belongs_to :product
  belongs_to :supplier
  belongs_to :user

  has_many :inventory_movements, dependent: :destroy

  validates :qty_delivered, presence: true
end
