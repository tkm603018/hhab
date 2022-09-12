class AccountActivationsController < ApplicationController
  include SessionsHelper

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:token])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      sign_in(user)
      flash[:success] = "Account activated!"
      redirect_to admin_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to admin_url
    end
  end
end
