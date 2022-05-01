class OverviewController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    @items = Item.where(user_id: current_user.id)
    @category_total_price = [*0..8].map{|i| [CATEGORIES[i], @items.where(category: i).pluck(:price).sum]}
    days = Date.today.months_ago(1).all_month
    @days = days.map{|day| 
      item = @items.where(purchased_at: day.all_day)
      income = item.where(category: CATEGORIES.length-1).pluck(:price).sum
      outcome = item.where.not(category: CATEGORIES.length-1).pluck(:price).sum
      [day.day, income - outcome]}
    @days_color = @days.map{|x| x[1] > 0 ? '#2979ff' : '#f50057' }
  end
end
