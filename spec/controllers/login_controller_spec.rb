require 'rails_helper'

describe LoginController do
  let(:user) {create(:user)}

  let(:valid_attributes) {{
    login: 'test',
    password: 'password',
  }}

  let(:bad_password) {{
    login: 'test',
    password: 'wrong',
  }}

  before :each do
    request.env["HTTP_REFERER"] = "back"
  end

  describe "GET index" do
    before :each do
      get :index
    end

    it {expect(response).to be_success}
  end

  describe "POST login" do
    context 'with user' do
      before :each do
        user
      end

      it 'should redirect root with valid info' do
        post :login, {login: valid_attributes}
        expect(response).to redirect_to(root_path)
      end

      it 'should redirect back with invalid info' do
        post :login, {login: bad_password}
        expect(response).to redirect_to('back')
      end
    end

    context 'without user' do
      before :each do
        post :login, {login: valid_attributes}
      end

      it {expect(response).to redirect_to('back')}
    end
  end
end
