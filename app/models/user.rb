class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  belongs_to :super_user, class_name: "User", optional: true
  
  has_one :bio, dependent: :destroy
  has_one :worker_bio, dependent: :destroy

  validates :role, presence: true

  accepts_nested_attributes_for :bio
  accepts_nested_attributes_for :worker_bio

  
  enum role: { admin: "admin", super_user: "super_user", worker: "worker" }

  after_create :assign_role

  has_many :workers, class_name: "User", foreign_key: "super_user_id", dependent: :destroy
  has_many :suppliers, dependent: :destroy
  has_many :buys, dependent: :destroy
  has_many :buy_lines, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :receptions, dependent: :destroy
  has_many :reception_lines, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :sells, dependent: :destroy
  has_many :sell_lines, dependent: :destroy
  has_many :inventory_movements, dependent: :destroy
  has_many :partial_deliveries, dependent: :destroy
  has_many :products_returns, dependent: :destroy
  has_many :products_return_lines, dependent: :destroy

  def assign_role
    self.role = "super_user" unless self.worker?
  end

  def admin?
    role == "admin"
  end

  def super_user?
    role == "super_user"
  end

  def worker?
    role == "worker"
  end

end
