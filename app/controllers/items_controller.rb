class ItemsController < ApplicationController
before_action :signed_in_user, only: [:edit, :new, :create, :update]
helper_method :sort_column, :sort_direction
protect_from_forgery

  def index
    @items = current_user.items.order("#{sort_column} #{sort_direction}")
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    current_user.items.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
  
  def edit
    @item = current_user.items.find(params[:id])
    @stores = current_user.stores.map{|store| store.title }.unshift('')
  end

  def new
    @stores = current_user.stores.map{|store| store.title }.unshift('')
  end

  def create
    params_date = Date.parse(item_params[:purchased_at])
    flash[:alert] = '店舗名を指定してください' if item_params[:store].blank?  && item_params[:title].blank?
    flash[:alert] = '今日以前の日付を指定してください' if Date.today <= params_date
    if item_params[:title].present?
      store = current_user.stores.create!(title: item_params[:title]) 
    else
      store = current_user.stores.where(title: item_params[:store])&.first
    end
    current_user.items.create!(
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
      store = current_user.stores.create!(title: item_params[:title]) 
    else
      store = current_user.stores.where(title: item_params[:store])&.first
    end
    current_user.items.find(params[:id]).update(
      store_id: store.id, 
      purchased_at: params_date,
      category: CATEGORIES.index(item_params[:category]), 
      price: item_params[:price], 
      description: item_params[:description]
    )
    redirect_to request.referer, notice: !flash[:alert] && '更新しました'
  end

  def destroy
    current_user.items.find(params[:id]).destroy
    redirect_to request.referer, notice: '削除しました'
  end



  private
  def item_params
    params.require(:item)
  end
end
