class LoginController < ApplicationController

  # GET /login
  def index
  end

  # POST /login
  def login
    params = login_params
    user = User.find_by_login(params[:login])

    if !user || user.password != params[:password]
      redirect_to :back, flash: {error: "Wrong username or password"}
    else
      login_user(user)
    end
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
  end

  # POST /send_password
  def send_password
    params = send_password_params
    user = User.find_by_email(params[:email])

    if !user
      redirect_to :back, flash: {error: "Wrong email"}
    else
      redirect_to :back, flash: {error: "Password sent"}
    end
  end

  private
  def login_params
    params.require(:login).permit(:login, :password)
  end

  def send_password_params
   params.require(:email)
  end

end
