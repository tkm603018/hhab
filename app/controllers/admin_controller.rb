class AdminController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    return nil unless current_user
    last_month = Date.today.last_month.all_month
    @charts_title = "先月(#{last_month.first.year}年#{last_month.first.month}月)"
    @last_month_items = current_user.items.where(purchased_at: ["#{last_month.first} 00:00:00.000000000 JST +09:00".."#{last_month.first.end_of_month} 23:59:59 +0900"])

    categories = current_user.categories.published.order(order: 'asc')
    categories_title_path = categories.pluck(:title, :path, :color)
    items = @last_month_items.group(:category_path).sum(:price)

    gon.data = categories_title_path.map{|a| items[a[1]] == nil ? 0 : items[a[1]]}
    categories_title_path_transposed = categories_title_path.transpose
    gon.labels = categories_title_path_transposed[0]
    gon.polar_area_colors = categories_title_path_transposed[2]


    days = last_month.map{|a|[a.day, 0, 0]}.transpose
    incomed_items_transpose = @last_month_items.where(category_path: categories.incomed.pluck(:path)).map{|items| [items.purchased_at.day, items.price]}.transpose
    outcomed_items_transpose = @last_month_items.where(category_path: categories.outcomed.pluck(:path)).map{|items| [items.purchased_at.day, items.price]}.transpose
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


    items = current_user.items.where(category_path: categories.outcomed.pluck(:path))
    subjects = items.order("purchased_at asc").group_by{|a|"#{a.purchased_at.year}-#{sprintf("%02d", a.purchased_at.month)}"}.map{|a|a}.transpose
    return unless subjects.any?
    outcomed_label = subjects[0]
    outcomed_total_price = subjects[1].map{|a|a.pluck(:price).sum}

    items = current_user.items.where(category_path: categories.incomed.pluck(:path))
    subjects = items.order("purchased_at asc").group_by{|a|"#{a.purchased_at.year}-#{sprintf("%02d", a.purchased_at.month)}"}.map{|a|a}.transpose
    incomed_label = subjects[0]
    incomed_total_price = subjects[1].map{|a|a.pluck(:price).sum}

    min = current_user.items.minimum(:purchased_at)
    max = current_user.items.maximum(:purchased_at)
    diff = diff_months(min, max).abs
    @months_diff = diff
    gon.months_diff = diff
    @months_count = [*0..diff].reverse
    today = Date.today
    months_transpose = @months_count.map{|a|["#{today.months_ago(a).year}-#{sprintf("%02d", today.months_ago(a).month)}", 0]}.transpose
    months = months_transpose[0].map{|a|[a, incomed_label.include?(a) ? incomed_total_price[incomed_label.find_index(a).to_i] : 0, outcomed_label.include?(a) ? outcomed_total_price[outcomed_label.find_index(a).to_i] : 0]}.transpose

    gon.line_labels = months[0]
    gon.incomed_monthly_sum = months[1]
    gon.outcomed_monthly_sum = months[2]
  end

  private
    def diff_months(base, past)
      adjusted_value = base.day >= past.day ? 1 : 0
      ((base.year * 12) + base.month) - ((past.year * 12) + past.month) + adjusted_value
    end
end
