class Item < ApplicationRecord
  belongs_to :user
  belongs_to :store, foreign_key: 'store_title', primary_key: 'title'
  with_options presence: true do
    validates :price
    validates :category
    validates :purchased_at
  end
  
  scope :sort_purchased_at_asc, -> { order(created_at: 'DESC') }

  class << self
    def categories
      ['food', 'necessaries', 'hobbies', 'transportation', 'fashion', 'helth', 'universiity', 'utility', 'account']
    end
  end
end
