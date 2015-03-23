class LoginHelp < ApplicationMailer

  def username_email(user)
    @user = user

    mail to: "cscampbell@gmail.com", subject: "Your Username is Bob", body: "asdfw"
    #mail to: user.email, subject: "Your Username is #{user.login}"
    #user.username
  end

  def password_email(user)
    @user = user
    @greeting = "Hi"

    mail to: "cscampbell@gmail.com"
  end
end