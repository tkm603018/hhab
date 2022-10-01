class Category < ApplicationRecord
  belongs_to :user
  has_many :items, foreign_key: 'category_path', primary_key: 'path'
  

  with_options presence: true do
    validates :title
    validates :path
    validates :status
    validates :color
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

  def status_label
    if self.status == 'draft'
      '下書き'
    elsif self.status == 'opened'
      '公開済み'
    elsif self.status == 'closed'
      '非公開'
    end
  end
end
