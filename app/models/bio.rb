class Bio < ApplicationRecord
  belongs_to :user

  has_many :workers

  validates :nif, presence: true
  validates :commercial_name, presence: true
  
end
