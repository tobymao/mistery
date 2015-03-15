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

  private
  def login_params
    params.require(:login).permit(:login, :password)
  end
end
