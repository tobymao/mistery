class LoginHelp < ApplicationMailer

  def username_email(user)
    @user = user

    mail to: user.email, subject: "Mistery.io Username", body: "Your Username is #{user.login}"
  end

  def password_email(user)
    @user = user

    mail to: user.email, subject: "Mistery.io Password", body: "Your Password is #{user.password}"
  end
end