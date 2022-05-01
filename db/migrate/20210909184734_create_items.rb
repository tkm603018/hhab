class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.bigint :user_id, null: false, comment: 'userテーブルのid'
      t.bigint :store_id, null: false, comment: 'storeテーブルのid'
      t.integer :price, null: false, comment: '価格'
      t.integer :category, null: false, comment: '購入したした物のカテゴリ'
      t.datetime :purchased_at, null: false, comment: '購入したした日時'
      t.text :description, comment: '備考'

      t.timestamps
    end
  end
end
