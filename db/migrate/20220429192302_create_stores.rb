class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.bigint :user_id, null: false, comment: 'userテーブルのid'
      t.string :title, null: false, comment: '購入した店舗の名称'
      t.string :description, comment: '備考'

      t.timestamps
    end
  end
end
