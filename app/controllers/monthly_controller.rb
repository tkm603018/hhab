class MonthlyController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    @utility_water = utility('水道代')
    @utility_gas = utility('ガス代')
  end

  private
  def utility(store_title)
    store = Store.where(user_id: current_user.id, title: store_title).first
    if store.present?
      @items = Item.where(user_id: current_user.id, store_id: store.id)
      output = @items.where(category: CATEGORIES.length-2).pluck(:purchased_at, :price)
      output.map{|x| ["#{x[0].year}/#{x[0].month}", x[1]]}
    end
  end

end
