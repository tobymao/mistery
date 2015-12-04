class LocationsController < ApplicationController
  # POST /locations
  # POST /locations
  def create
    @location = Location.new(question_params)
    return render_bad_credentials unless @location.universe.user == current_user

    respond_to do |format|
      if @location.save
        format.html { redirect_to :back }
      end
    end
  end

  private
  def require_permission
    render_bad_credentials unless @owner
  end

  def question_params
    params.require(:location).permit(:name, :group, :universe_id)
  end
end
