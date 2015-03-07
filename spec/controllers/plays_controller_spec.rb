require 'rails_helper'

describe PlaysController do
  let(:user) {create(:user)}
  let(:authenticate) {allow(controller).to receive(:current_user).and_return(user)}
  let(:scenario) {create(:scenario)}
  let(:play) {create(:play, user: user)}
  let(:location) {create(:location)}

  let(:valid_attributes) {{
    scenario_id: scenario.id
  }}

  let(:invalid_attributes) {{
    scenario_id: 1
  }}

  describe "GET index" do
    context 'unauthenticated' do
      before :each do
        get :index
      end

      it {expect(response).to be_success}
    end

    context 'authenticated' do
      before :each do
        authenticate
        get :index
      end

      it {expect(response).to be_success}
    end
  end

  describe "GET show" do
    context 'unauthenticated' do
      before :each do
        get :show, {id: play.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
        get :show, {id: play.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe "POST create" do
    context 'unauthenticated' do
      before :each do
        post :create, {play: valid_attributes}
      end

      it {expect(response).to redirect_to(Play.first)}
    end

    context 'authenticated' do
      before :each do
        authenticate
        post :create, {play: valid_attributes}
      end

      it {expect(response).to redirect_to(Play.first)}
    end
  end

  describe 'GET visit' do
    context 'unauthenticated' do
      before :each do
        get :visit, {id: play.id, location_id: location.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
        get :visit, {id: play.id, location_id: location.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe 'POST book' do
    context 'unauthenticated' do
      before :each do
        post :book, {id: play.id, location_id: location.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
        post :book, {id: play.id, location_id: location.id}
      end

      it {expect(response.status).to eq(302)}
    end
  end

  describe 'GET result' do
    context 'unauthenticated' do
      before :each do
        get :result, {id: play.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
        get :result, {id: play.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe 'POST finish' do
    context 'unauthenticated' do
      before :each do
        post :finish, {id: play.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
        post :finish, {id: play.id}
      end

      it {expect(response.status).to eq(302)}
    end
  end
end
