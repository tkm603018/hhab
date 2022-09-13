class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'パスワードのリセット手順が記載されたメールが送信されました'
      redirect_to admin_path
    else
      flash.now[:danger] = 'このメールアドレスは登録されていません'
      render new_password_reset_path
    end
  end

  def edit
  end

  def update
    if params[:password].empty?
      flash[:alert] = 'パスワードを入力してください'
      render 'edit'
    elsif params[:password_confirmation].empty?
      flash[:alert] = '確認用パスワードを入力してください'
      render 'edit'
    elsif !(params[:password] == params[:password_confirmation])
      flash[:alert] = 'パスワード と 確認用パスワード が一致しません'
      render 'edit'
    elsif @user.update(user_params)
      sign_in(@user)
      flash[:success] = 'パスワードがリセットされました。'
      redirect_to admin_url
    end
  end

  private

    def user_params
      params.permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:token]))
        redirect_to admin_url
      end
    end

    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = 'パスワードのリセットの有効期限が切れています。'
        redirect_to new_password_reset_url
      end
    end
end
