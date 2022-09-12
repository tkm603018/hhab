class UserMailer < ApplicationMailer

  def account_activation(props)
    @user = props[:props]
    mail to: @user.email, subject: "Account activation"
  end

  def password_reset(props)
    @user = props[:props]
    mail to: @user.email, subject: "Password reset"
  end
end
