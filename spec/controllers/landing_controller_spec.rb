require 'rails_helper'

describe LandingController do
  describe "GET index" do
    before :each do
      get :index
    end

    it {expect(response).to be_success}
  end
end
