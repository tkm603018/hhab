class Expense < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30, allow_blank: true }
  validates :purchased_at, presence: true
  validates :price, presence: true
  validates :category, presence: true

  enum category: [
    'food', 
    'necessities', 
    'transpotation',
    'hobbies',
    'entertainment',
    'fashion',
    'medical',
    'university',
    'utility'
    ], _prefix: true
end
