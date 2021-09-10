class Api::V1::UsersController < ApplicationController
  # 追加
	before_action :authenticate_user

  # 削除
  # def index
  #   users = User.all
  #   render json: users.as_json(only: [:id, :name, :email, :created_at])
  # end

  # 追加
  def show
    render json: current_user.my_json
  end
  
  # 共通のJSONレスポンス
  def my_json
    as_json(only: [:id, :name, :email, :created_at])
  end

  private
end
