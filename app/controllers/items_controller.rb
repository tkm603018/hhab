class ItemsController < ApplicationController
before_action :signed_in_user, only: [:new, :create]
helper_method :sort_column, :sort_direction

  def index
    @items = Item.order("#{sort_column} #{sort_direction}")
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
  
  def show
    @item = Item.find(params[:id])
    @stores = Store.where(user_id: current_user.id)
    @stores = @stores.map{|store| store.title }.unshift('')
  end

  def new
    @stores = Store.where(user_id: current_user.id)
    @stores = @stores.map{|store| store.title }.unshift('')
  end

  def create
    params_date = Date.parse(item_params[:purchased_at])
    flash[:alert] = '店舗名を指定してください' if item_params[:store].blank?  && item_params[:title].blank?
    flash[:alert] = '今日以前の日付を指定してください' if Date.today <= params_date
    if item_params[:title].present?
      store = Store.create!(user_id: current_user.id, title: item_params[:title]) 
    else
      store = Store.where(user_id: current_user.id, title: item_params[:store])&.first
    end
    Item.create!(
      user_id: current_user.id, 
      store_id: store.id, 
      purchased_at: params_date,
      category: CATEGORIES.index(item_params[:category]), 
      price: item_params[:price], 
      description: item_params[:description]
    )
    redirect_to new_item_path, notice: !flash[:alert] && '登録しました'
  end

  def update
    params_date = Date.parse(item_params[:purchased_at])
    flash[:alert] = '店舗名を指定してください' if item_params[:store].blank?  && item_params[:title].blank?
    flash[:alert] = '今日以前の日付を指定してください' if Date.today <= params_date
    if item_params[:title].present?
      store = Store.create!(user_id: current_user.id, title: item_params[:title]) 
    else
      store = Store.where(user_id: current_user.id, title: item_params[:store])&.first
    end
    Item.find(params[:id]).update(
      store_id: store.id, 
      purchased_at: params_date,
      category: CATEGORIES.index(item_params[:category]), 
      price: item_params[:price], 
      description: item_params[:description]
    )
    redirect_to items_path, notice: !flash[:alert] && '更新しました'
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to request.referer, notice: '削除しました'
  end



  private
  def item_params
    params.require(:item)
  end
end
