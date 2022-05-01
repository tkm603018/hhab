class ApplicationController < ActionController::Base
  include SessionsHelper
  CATEGORIES = ['food', 'necessaries', 'hobbies', 'transportation', 'fashion', 'helth', 'universiity', 'utility', 'account']

  private

  def signed_in_user
    unless signed_in?
      flash[:alert] = 'サインインするか登録してください'
      redirect_to root_path
    end
  end
end
