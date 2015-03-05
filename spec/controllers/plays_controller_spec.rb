require 'rails_helper'

describe PlaysController do
  let(:user) {create(:user)}
  let(:authenticate) {allow(controller).to receive(:current_user).and_return(user)}
  let(:play) {create(:play, user: user)}

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
end
