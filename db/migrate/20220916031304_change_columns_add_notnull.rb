class ChangeColumnsAddNotnull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :store_title, false, ''
  end
end
