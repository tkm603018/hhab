class UserMailer < ApplicationMailer

  def account_activation(props)
    @user = props[:props]
    mail to: @user.email, subject: "アカウントの有効化"
  end

  def password_reset(props)
    @user = props[:props]
    mail to: @user.email, subject: "パスワードリセット"
  end
end
