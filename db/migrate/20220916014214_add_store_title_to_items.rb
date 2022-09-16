class AddStoreTitleToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :store_title, :string
  end
end
