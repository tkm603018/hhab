class Store < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
