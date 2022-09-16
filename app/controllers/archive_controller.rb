class ArchiveController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  helper_method :sort_column, :sort_direction

  def index
    @months = current_user.items.order("purchased_at desc").pluck(:purchased_at).map{|a| a.strftime("%Y-%m")}.group_by(&:itself).transform_values(&:size).to_a
  end

  def subindex
    @items = current_user.items
    @date = Date.parse("#{params[:slug]}-01")
    @list_items = @items.where(purchased_at: @date.all_month.map{|a|a.all_day}).order("#{sort_column} #{sort_direction}")

    # @pie_chart_colors = []
    # @category_total_price = []
    # @last_month = Date.today.months_ago(1)
    # incomes_sum = 0
    # [*0..8].each{|i|
    #   items_sum = @items.where(purchased_at: @date.all_month, category: i).pluck(:price).sum
    #   if 0 < items_sum && i != 8
    #     incomes_sum = incomes_sum + items_sum
    #     @pie_chart_colors.append(CATEGORIES_COLORS[i]) 
    #     @category_total_price.append([CATEGORIES[i], items_sum])
    #   end
    # }
    # @charts_title = "#{@last_month.year}年#{@last_month.month}月の結果"
    
    # @column_chart_colors = []
    # @dayly_total_price = []
    # @date.all_month.each{|day| 
    #   item = @items.where(purchased_at: day.all_day)
    #   income = item.where(category: CATEGORIES.length-1).pluck(:price).sum
    #   outcome = item.where.not(category: CATEGORIES.length-1).pluck(:price).sum
    #   inoutcome = income - outcome
    #   @column_chart_colors.append( inoutcome > 0 ? "#2979ff" : "#f50057")
    #   @dayly_total_price.append([day.day, inoutcome])
    # }

    # @pie_chart_params = {
    #   donut: true,
    #   suffix: "円",
    #   colors: @pie_chart_colors,
    #   # colors: ["#f50057", "#ffc400", "#f44336", "#8bc34a", "#4caf50", "#00bcd4", "#2979ff", "#4caf50", "#dddddd"],
    #   title: "合計#{incomes_sum}円",
    #   library: { # ここからHighchartsのオプション
    #       title: { # タイトル表示(ここでは、グラフの真ん中に配置して,viewでデータを渡しています。*後述)
    #         align: 'center',
    #         verticalAlign: 'middle',
    #       },
    #       chart: {
    #         backgroundColor: 'none',
    #         plotBorderWidth: 0, 
    #         plotShadow: false
    #       },
    #       plotOptions: {
    #         pie: {
    #           dataLabels: {
    #             enabled: true, 
    #             distance: -60, # ラベルの位置調節
    #             allowOverlap: false, # ラベルが重なったとき、非表示にする
    #             style: { #ラベルフォントの設定
    #               color: '#000', 
    #               fontSize: '0.9rem',
    #               textAlign: 'center', 
    #               # textOutline: 1, #デフォルトではラベルが白枠で囲まれていてダサいので消す
    #             }
    #           },
    #           size: '110%',
    #           innerSize: '60%', # ドーナツグラフの中の円の大きさ
    #           borderWidth: 0,
    #         }
    #       },
    #     }
    # }

    # @column_chart_params = {
    #   suffix: '円',
    #   colors: @column_chart_colors,
    # }
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    current_user.items.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
