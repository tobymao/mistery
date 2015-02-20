require 'csv'

class UniversesController < ApplicationController
  before_action :authenticate, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_universe, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /universes
  # GET /universes.json
  def index
    @universes = Universe.all
  end

  # GET /universes/1
  # GET /universes/1.json
  def show
  end

  # GET /universes/new
  def new
  end

  # GET /universes/1/edit
  def edit
    @locations_csv = CSV.generate do |csv|
      @universe.locations.each do |location|
        csv << [location.name, " #{location.address}"]
      end
    end
  end

  # POST /universes
  # POST /universes.json
  def create
    @universe = Universe.new(universe_params)
    @universe.user = current_user

    respond_to do |format|
      if @universe.save
        format.html {redirect_to @universe, notice: 'Universe was successfully created.'}
        format.json {render :show, status: :created, location: @universe}
      else
        format.html {redirect_to :back, flash: {error: "Error saving universe"}}
        format.json {render json: @universe.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /universes/1
  # PATCH/PUT /universes/1.json
  def update
    respond_to do |format|
      if @universe.update(universe_params)
        format.html {redirect_to @universe, notice: 'Universe was successfully updated.'}
        format.json {render :show, status: :ok, location: @universe}
      else
        format.html {redirect_to :back, flash: {error: "Error saving universe"}}
        format.json {render json: @universe.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /universes/1
  # DELETE /universes/1.json
  def destroy
    @universe.destroy
    respond_to do |format|
      format.html { redirect_to universes_url, notice: 'Universe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_universe
    @universe = Universe.find(params[:id])
    @owner = @universe.user == current_user
  end

  def require_permission
    render_bad_credential unless @owner
  end

  # Parse CSV if :locations_csv is populated.
  # Add the location to :locations_attributes
  # Find missing locations and add destroy records to the hash
  # Returns sanitized params.
  def universe_params
    p = params.dup
    p[:universe][:locations_attributes] ||= []

    all_locations = @universe.try(:locations) || []
    included_locations = []

    # Parse CSV
    CSV.parse(p[:universe].delete(:locations_csv)).each do |row|
      name = row[0]
      address = row[1]

      next if name.nil? || address.nil?

      location_hash = {
        name: name.strip,
        address: address.strip,
      }

      if match = all_locations.find{|location| location.address == address}
        location_hash[:id] = match.id
        included_locations << match.id
      end

      p[:universe][:locations_attributes] << location_hash
    end if p[:universe][:locations_csv]

    # Find Missing Records
    removed_location = all_locations.map(&:id)-included_locations
    removed_location.each do |id|
      p[:universe][:locations_attributes] << {
        id: id,
        _destroy: true,
      }
    end

    p.require(:universe).permit(:name, :description, locations_attributes: [:id, :name, :address, :_destroy])
  end
end
