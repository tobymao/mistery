class Payments::ProfilesController < ApplicationController
  before_action :authenticate
  before_action :set_profile, only: [:update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profile = current_user.payment_profile || Payments::Profile.new(email: current_user.login)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    profile = Payments::Profile.new(profile_params)
    profile.user = current_user

    respond_to do |format|
      if profile.save
        format.html {redirect_to payments_profiles_path}
      else
        format.html {redirect_to :back, flash: {error: "Error saving payment profile"}}
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html {redirect_to payments_profiles_path}
      else
        format.html {redirect_to :back, flash: {error: "Error saving payment profile"}}
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
  end

  private
  def set_profile
    @profile = Payments::Profile.find(params[:id])
  end

  def profile_params
    params.require(:payments_profile).permit(:email)
  end
end
