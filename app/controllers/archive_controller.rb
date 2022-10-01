class ArchiveController < ApplicationController
  before_action :signed_in_user, only: [:index, :subindex, :new, :create]
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

    @charts_title = "#{@date.year}年#{@date.month}月"
    @last_month_items = current_user.items.where(purchased_at: @all_month)
    @categories = current_user.categories.published.order(order: 'asc')
    @categories_title_path = @categories.pluck(:title,:path, :color)
    @items = @last_month_items.group(:category_path).sum(:price)

    @categories_sum = @categories_title_path.map{|a| @items[a[1]] == nil ? 0 : @items[a[1]]}
    @categories_title_path_transposed = @categories_title_path.transpose
    gon.labels = @categories_title_path_transposed[0]
    gon.data = @categories_sum
    gon.polar_area_colors = @categories_title_path_transposed[2]

    days = @date.all_month.map{|a|[a.day, 0, 0]}.transpose
    incomed_items_transpose = @last_month_items.where(category_path: @categories.incomed.pluck(:path)).map{|items| [items.purchased_at.day, items.price]}.transpose
    outcomed_items_transpose = @last_month_items.where(category_path: @categories.outcomed.pluck(:path)).map{|items| [items.purchased_at.day, items.price]}.transpose
    if incomed_items_transpose.any?
      incomed_items_transpose[0].each.with_index(0) do |d, index|
        days[1][d-1] = days[1][d-1] + incomed_items_transpose[1][index]
      end
    end
    if outcomed_items_transpose.any?
      outcomed_items_transpose[0].each.with_index(0) do |d, index|
        days[2][d-1] = days[2][d-1] + outcomed_items_transpose[1][index]
      end
    end
    
    gon.bar_labels = days[0]
    gon.incomed_items_dayly_sum = days[1]
    gon.outcomed_items_dayly_sum = days[2]
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    current_user.items.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
