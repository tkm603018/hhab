class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.bigint :user_id, comment: "ユーザーのid"
      t.string :title, null: false, comment: "購入店舗"
      t.date :purchased_at, null: false, comment: "購入日"
      t.integer :price, null: false, comment: "購入金額"

      t.timestamps
    end
  end
end
