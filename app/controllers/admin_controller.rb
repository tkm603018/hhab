class AdminController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    return nil unless current_user
    @last_month = Date.today.last_month.all_month.first
    @charts_title = "先月(#{@last_month.year}年#{@last_month.month}月)"
    @last_month_items = current_user.items.where(purchased_at: ["#{@last_month} 00:00:00.000000000 JST +09:00".."#{@last_month.end_of_month} 23:59:59 +0900"])

    @categories = current_user.categories.published.order(order: 'asc')
    @categories_title_path = @categories.pluck(:title,:path)
    @items = @last_month_items.group(:category_path).sum(:price)

    @categories_sum = @categories_title_path.map{|a| @items[a[1]] }
    gon.labels = @categories_title_path.map{|a| !!@items[a[1]] && a[0]}.filter{|a|a != false}
    gon.data = @categories_sum.filter{|a|a != nil}
    gon.colors = gon.data.map{|a| "##{Random.bytes(3).unpack1('H*')}55" }

    @items_dayly = @last_month_items.order(:purchased_at).group_by{|a|a.purchased_at.day}
    @items_dayly_sum = @items_dayly.map{|a|[a[0], a[1].sum{|b|b.price}]}
    gon.bar_labels = @items_dayly_sum.map{|a|a[0]}
    gon.items_dayly_sum = @items_dayly_sum.map{|a|a[1]}
  end
end
