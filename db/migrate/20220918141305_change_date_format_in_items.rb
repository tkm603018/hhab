class ChangeDateFormatInItems < ActiveRecord::Migration[6.1]
  def up
    change_column :items, :purchased_at, :datetime
  end

  def down
    change_column :items, :purchased_at, :date
  end
end
