class CategoriesController < ApplicationController
  before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  protect_from_forgery

  def index
    @subjects = current_user.categories.order(order: "asc")
    @subjects = @subjects.page(current_page).per(current_limit(10))
  end

  def new
  end

  def create
    current_user.categories.create(category_params)
    redirect_to new_category_path, notice: '作成しました'
  end

  def edit
    @subject = Category.find(params[:id])
  end

  def update
    current_user.categories.find(params[:id]).update!(category_params)
    redirect_to categories_path, notice: '更新しました'
  end
  
  def set_random_color
    @categories = current_user.categories.published.order(order: "asc")
    @colors = @categories.map{|a| "##{Random.bytes(3).unpack1('H*')}55" }
    @categories.map.with_index(0) { |a, index| a.update(color: @colors[index])}
    redirect_to categories_path, notice: '更新しました'
    # ["#f8bcba","#f2c642","#98df35","#38e947","#37e4b9","#aacff7","#c8c6f9","#e5bdf9","#f8b9d7"]
  end

  def destroy
    current_user.categories.find(params[:id]).destroy
    redirect_to categories_path, notice: '削除しました'
  end

  private
    def category_params
      params.require(:category).permit(:title, :path, :color, :income, :order, :status)
    end
end
