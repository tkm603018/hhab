class AddColumnIncome < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :income, :boolean, default: false, null: false
  end
end
