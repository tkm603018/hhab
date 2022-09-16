class Store < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, uniqueness: { scope: :user_id }, length: { minimum: 1, maximum: 30 }
  has_many :items, foreign_key: 'title'

  scope :by_store_like, lambda { |title|
    where('title LIKE :value', { value: "%#{title}%"})
  }
end
