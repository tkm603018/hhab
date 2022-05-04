class UsersController < ApplicationController

  def create
    user = User.find_by(email: params[:user][:email])
    return redirect_to new_user_path, alert: '登録済です' if user
    
    user = User.new(
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
      name: params[:user][:name]
    )
    if user.valid?
      user.save
      redirect_to admin_path, notice: '登録しました'
    else
      redirect_to admin_path, alert: user.errors.messages
    end
  end

  def update
    user = User.find(params[:id])
    if user&.update(user_params)
      redirect_to request.referer, notice: 'プロフィールを変更しました'
    else
      redirect_to request.referer, alert: 'プロフィールを変更できませんでした 文字制限を確認してください'
    end
  end

  private
  def user_params
    params.permit(:name, :description)
  end
end
