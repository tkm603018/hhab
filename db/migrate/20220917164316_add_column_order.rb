class AddColumnOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :order, :integer, default: 0, null: false
  end
end
