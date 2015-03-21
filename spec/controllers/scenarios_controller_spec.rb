require 'rails_helper'

describe ScenariosController do
  let(:user) {create(:user)}
  let(:authenticate) {allow(controller).to receive(:current_user).and_return(user)}
  let(:scenario) {create(:scenario, user: user)}
  let(:published_scenario) {create(:scenario, user: user, published: true)}

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
        get :show, {id: scenario.id}
      end

      it {expect(response).not_to be_success}
    end

    context 'unauthenticated and published' do
      before :each do
        get :show, {id: published_scenario.id}
      end

      it {expect(response).to be_success}
    end

    context 'authenticated' do
      before :each do
        authenticate
        get :show, {id: scenario.id}
      end

      it {expect(response).to be_success}
    end
  end
end
