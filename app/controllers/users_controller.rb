class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :universes, :scenarios]
  before_action :authenticate, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user
      render :show, id: current_user.id
    else
      redirect_to action: :new
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/universes
  # GET /users/1/universes.json
  def universes
  end

  # GET /users/1/scenarios
  # GET /users/1/scenarios.json
  def scenarios
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    #TO DO: merge user
    #if current_user.guest
    #end

    if @user.save
      # login_user will handle redirect / response
      login_user(@user)
    else
      respond_to do |format|
        format.html {redirect_to new_user_url, flash: {error: @user.errors.full_messages}}
        format.json {render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to @user, notice: 'User was successfully updated.'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {redirect_to new_user_url, flash: {error: "Error updating user"}}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # /PUT /users/1
  # /PUT /users/1.json
  def reset_password
    password_reset = PasswordReset.find_by(token: params[:token])

    if !password_reset || !password_reset.token_valid?
      return render_bad_credentials
    end

    password_reset.used = true
    password_reset.save

    user = password_reset.user
    user.password = params[:password]
    user.save

    redirect_to login_path
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:login, :email, :password)
  end
end
