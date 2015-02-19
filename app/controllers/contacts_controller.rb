class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :set_scenario
  before_action :require_permission

  # GET /scenario/:id/contacts
  # GET /scenarios/:id//contacts.json
  def index
    @contacts = @scenario.contacts
  end

  # GET /scenarios/:id/contacts/1
  # GET /scenarios/:id/contacts/1.json
  def show
  end

  # GET /scenarios/:id/contacts/new
  def new
    @contact = Contact.new
  end

  # GET /scenarios/:id/contacts/1/edit
  def edit
  end

  # POST /scenarios/:id/contacts
  # POST /scenarios/:id/contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.scenario = @scenario

    respond_to do |format|
      if @contact.save
        format.html { redirect_to [@scenario, @contact], notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenarios/:id/contacts/1
  # PATCH/PUT /scenarios/:id/contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to [@scenario, @contact], notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/:id/contacts/1
  # DELETE /scenarios/:id/contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_scenario
      @scenario = Scenario.find(params[:scenario_id])
    end

    def require_permission
      render_bad_credentials root unless @scenario.user == current_user
    end

    def contact_params
      params.require(:contact).permit(:name, :text, :location_id)
    end
end
