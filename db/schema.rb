# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_29_192302) do

  create_table "items", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "userテーブルのid"
    t.bigint "store_id", null: false, comment: "storeテーブルのid"
    t.integer "price", null: false, comment: "価格"
    t.integer "category", null: false, comment: "購入したした物のカテゴリ"
    t.datetime "purchased_at", null: false, comment: "購入したした日時"
    t.text "description", comment: "備考"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stores", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "userテーブルのid"
    t.string "title", null: false, comment: "購入した店舗の名称"
    t.string "description", comment: "備考"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "氏名"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", null: false, comment: "パスワード"
    t.string "description", comment: "備考"
    t.integer "status", default: 0, comment: "ユーザー情報公開ステータス"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
