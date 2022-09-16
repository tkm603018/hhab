class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.string :path, null: false, comment: 'パス'
      t.integer :status, limit: 1, default: 1, null: false, comment: 'ステータス'

      t.timestamps
    end
  end
end
