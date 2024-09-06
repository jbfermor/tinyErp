class Supplier < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :buys, dependent: :destroy
  has_many :receptions, dependent: :destroy
  has_many :partial_deliveries, dependent: :destroy

  validates :nif, presence: true, uniqueness: true
  validates :commercial_name, presence: true, uniqueness: true
  # other validations as needed
end
