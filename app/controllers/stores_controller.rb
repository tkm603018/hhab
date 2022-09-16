class StoresController < ApplicationController
before_action :signed_in_user, only: [:index, :show, :create, :destroy]
protect_from_forgery

  def index
    stores = current_user.stores.select(:id, :title)
    render json: stores
  end

  def show
    stores = current_user.stores.by_store_like(store_params[:title]).select(:id, :title)
    render json: stores
  end

  def create
    store = current_user.stores.create(title: store_params[:title])
    render json: {data: store}
  end

  def destroy
    stores = current_user.stores.find_by(title: store_params[:title]).destroy
    render json: stores
  end

  private
    def store_params
      params.permit(:title)
    end
end
