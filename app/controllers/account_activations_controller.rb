class AccountActivationsController < ApplicationController
  include SessionsHelper

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:token])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      sign_in(user)
      flash[:success] = "アカウントが有効化されました！"
      redirect_to logged_in_url
    else
      flash[:danger] = "アカウント有効化リンクが間違っています。"
      redirect_to login_url
    end
  end
end
