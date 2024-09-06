class WorkerBio < ApplicationRecord
  belongs_to :user

  validates :nif, presence: true

end
