class ApplicationController < ActionController::Base
  include SessionsHelper
  # CATEGORIES = ['food', 'necessaries', 'hobbies', 'transportation', 'fashion', 'helth', 'universiity', 'utility', 'account']
  CATEGORIES = ['食費', '日用品', '交通費', '趣味・娯楽', '服・美容', '健康・医療', '大学・部費・教材', '水道・光熱費', '口座']
  CATEGORIES_COLORS = ["#f50057", "#ffc400", "#f44336", "#8bc34a", "#4caf50", "#00bcd4", "#2979ff", "#4caf50", "#dddddd"]

  private

  def signed_in_user
    unless signed_in?
      flash[:alert] = 'サインインするか登録してください'
      redirect_to root_path
    end
  end
end
