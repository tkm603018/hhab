class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_page, :current_limit
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

  def current_page
    (params[:page].presence || 1).to_i
  end

  def current_limit( default=10 )
    (params[:limit].presence || default).to_i
  end

  private

  def signed_in_user
    unless signed_in?
      flash[:alert] = 'サインインするか登録してください'
      redirect_to admin_path
    end
  end

  def no_category
    unless User.find(current_user.id).categories.published.count > 0
      flash[:alert] = 'カテゴリーを作成してください'
      redirect_to new_category_path
    end
  end

  def no_store
    unless User.find(current_user.id).stores.count > 0
      flash[:alert] = '店舗名・用途を作成してください'
      # redirect_to new_item_path
    end
  end
end
