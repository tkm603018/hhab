class ChangeStoreIdToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :items, :store_id, true
  end

  def down
    change_column_null :items, :store_id, false
  end
end
