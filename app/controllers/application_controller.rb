class ApplicationController < ActionController::Base
  include SessionsHelper
  # CATEGORIES = ['food', 'necessaries', 'hobbies', 'transportation', 'fashion', 'helth', 'universiity', 'utility', 'account']
  CATEGORIES = ['食費', '日用品', '交通費', '趣味・娯楽', '服・美容', '健康・医療', '大学・部費・教材', '水道・光熱費', '口座']
  CATEGORIES_COLORS = ["#f50057", "#ffc400", "#f44336", "#8bc34a", "#4caf50", "#00bcd4", "#2979ff", "#4caf50", "#dddddd"]

  def utility(user, store_title)
    store = Store.where(user_id: user.id, title: store_title).first
    if store.present?
      @items = Item.where(user_id: user.id, store_id: store.id)
      output = @items.where(category: CATEGORIES.length-2).pluck(:purchased_at, :price)
      output.map{|x| ["#{x[0].year}/#{x[0].month}", x[1]]}
    end
  end

  private

  def signed_in_user
    unless signed_in?
      flash[:alert] = 'サインインするか登録してください'
      redirect_to admin_path
    end
  end
end
