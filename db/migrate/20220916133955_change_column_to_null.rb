class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :category, true
  end
end
