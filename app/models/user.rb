class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation:true, on: :create
  validates :name, presence: true, length: { maximum: 15 }
  validates :description, length: { maximum: 255 }
  enum status: ['inactive', 'active'], _prefix: true
end
