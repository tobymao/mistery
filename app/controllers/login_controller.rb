class LoginController < ApplicationController

  # GET /login
  def index
  end

  # POST /login
  def login
    params = login_params
    user = User.find_by(login: params[:login])

    if !user || user.password != params[:password]
      redirect_to :back, flash: {error: "Wrong username or password"}
    else
      login_user(user)
    end
  end

  # GET /reset_password
  def reset_password
    @password_reset = PasswordReset.find_by(token: params[:token])
  end

  # POST /logout
  def logout
    Session.where(user: current_user).destroy_all
    redirect_to root_path
  end

  # GET /forgot_username
  def forgot_username
  end

  # GET /forgot_password
  def forgot_password
  end

  # POST /send_username
  def send_username
    user = User.find_by(email: params[:email])

    if !user
      redirect_to :back, flash: {error: "This email is not registered"}
    else
      LoginHelp.username_email(user).deliver_now
      redirect_to :back, notice: "Username sent to #{user.email}"
    end
  end

  # POST /send_password
  def send_password
    user = User.find_by(email: params[:email])

    if !user
      redirect_to :back, flash: {error: "This email is not registered"}
    else
      password_reset = PasswordReset.create(user: user, token: SecureRandom.hex)
      LoginHelp.password_email(user, password_reset).deliver_now
      redirect_to :back, notice: "Password Reset Link sent to #{user.email}"
    end
  end

  private
  def login_params
    params.require(:login).permit(:login, :password)
  end

end
