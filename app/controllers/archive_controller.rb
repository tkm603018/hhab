class ArchiveController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  helper_method :sort_column, :sort_direction

  def index
    @months = current_user.items.order("purchased_at desc").group_by{|a|"#{a.purchased_at.year}-#{sprintf("%02d", a.purchased_at.month)}"}.map{|a|[a[0], a[1].count]}
    @months = Kaminari.paginate_array(@months).page(current_page).per(current_limit(10))
  end

  def subindex
    @items = current_user.items
    @date = Date.parse("#{params[:slug]}-01")
    @all_month = ["#{@date} 00:00:00.000000000 JST +09:00".."#{@date.end_of_month} 23:59:59 +0900"]
    @list_items = current_user.items.where(purchased_at: @all_month).order("#{sort_column} #{sort_direction}")
    @list_items = Kaminari.paginate_array(@list_items).page(current_page).per(current_limit(10))

    @charts_title = "今月(#{@date.year}年#{@date.month}月)の結果"
    @last_month_items = current_user.items.where(purchased_at: @all_month)
    @categories = current_user.categories.published.order(order: 'asc')
    @categories_title_path = @categories.pluck(:title,:path)
    @items = @last_month_items.group(:category_path).sum(:price)

    @categories_sum = @categories_title_path.map{|a| @items[a[1]] }
    gon.labels = @categories_title_path.map{|a| !!@items[a[1]] && a[0]}.filter{|a|a != false}
    gon.data = @categories_sum.filter{|a|a != nil}
    gon.colors = gon.data.map{|a| "##{Random.bytes(3).unpack1('H*')}55" }

    @items_dayly_sum = @last_month_items.order(purchased_at: 'asc').group("Date(purchased_at)").sum(:price)
    gon.bar_labels = @items_dayly_sum.map{|a|a[0].day}
    gon.items_dayly_sum = @items_dayly_sum.map{|a|a[1]}
    gon.bar_colors = gon.items_dayly_sum.map{|a| "##{Random.bytes(3).unpack1('H*')}55" }
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    current_user.items.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
