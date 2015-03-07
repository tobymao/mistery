require 'rails_helper'

describe ScenariosController do
  let(:user) {create(:user)}
  let(:authenticate) {allow(controller).to receive(:current_user).and_return(user)}

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
end
