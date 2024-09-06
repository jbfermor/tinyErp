class Customer < ApplicationRecord
  belongs_to :user
  has_many :sells, dependent: :destroy
  has_many :pruducts_returns, dependent: :destroy

  validates :name, :surname1, presence: true
  validates :nif, uniqueness: true

end
