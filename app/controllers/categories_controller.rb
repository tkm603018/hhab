class CategoriesController < ApplicationController
  before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  protect_from_forgery

  def index
    @subjects = current_user.categories.published.order("updated_at DESC")
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

  def destroy
    current_user.categories.find(params[:id]).destroy
    redirect_to categories_path, notice: '削除しました'
  end

  private
    def category_params
      params.require(:category).permit(:title, :path, :income, :order, :status)
    end
end
