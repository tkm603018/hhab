class SessionsController < ApplicationController
  protect_from_forgery
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to admin_path, notice: 'サインイン中'
    else
      redirect_to admin_path, alert: '未登録です'
    end
  end

  def destroy
    sign_out
    redirect_to admin_path
  end

end
