class Category < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', primary_key: 'id'
  has_many :items, foreign_key: 'path'
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :path
    validates :status
  end

  validates :path, uniqueness: {
    scope: :user_id,
  }

  enum status: {
    draft:      0,  # 下書き
    opened:     1,  # 公開済み
    closed:     2,  # 非公開
  }

  scope :published, -> { where( status: :opened ) }
  scope :incomed, -> { where( income: true ) }
  scope :outcomed, -> { where( income: false ) }
end
