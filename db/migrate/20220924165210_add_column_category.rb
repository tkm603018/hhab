class AddColumnCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :color, :string, default: '#000000', null: false
  end
end
