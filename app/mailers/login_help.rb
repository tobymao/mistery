class LoginHelp < ApplicationMailer
  include Rails.application.routes.url_helpers

  def username_email(user)
    mail(
      to: user.email,
      subject: "Mistery.io Username",
      body: "Your Username is #{user.login}"
    )
  end

  def password_email(user, password_reset)
    params = {token: password_reset.token}
    mail(
      to: user.email,
      subject: "Mistery.io Password",
      body: "Click this link to reset your password. #{reset_password_url(params)}"
    )
  end
end
