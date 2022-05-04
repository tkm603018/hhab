class SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path, notice: 'サインイン中'
    else
      redirect_to root_path, alert: '未登録です'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
