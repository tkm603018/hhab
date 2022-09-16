class AddColumnCategoryPath < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :category_path, :string, null: false
  end
end
