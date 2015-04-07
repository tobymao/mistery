class LoginHelp < ApplicationMailer

  def username_email(user)
    @user = user

    mail to: @user.email, subject: "Mistery.io Username", body: "Your Username is #{user.login}"
  end

  def password_email(user)
    @user = user

    random_password = Array.new(16).map { (65 + rand(58)).chr }.join
    @user.password = random_password
    @user.save

    mail to: user.email, subject: "Mistery.io Password", body: "Your password has been reset. Your new temporary password is #{random_password} . Please change your password after logging in"

  end
end