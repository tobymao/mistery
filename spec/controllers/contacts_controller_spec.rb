require 'rails_helper'

describe ContactsController do
  let(:user) {create(:user)}
  let(:authenticate) {allow(controller).to receive(:current_user).and_return(user)}
  let(:scenario) {create(:scenario, user: user)}
  let(:contact) {create(:contact, scenario: scenario)}

  let(:auth_other) do
    allow(controller).to receive(:current_user).and_return(
      create(:user, login: 'a', email: 'a@a.com', password: 'a')
    )
  end

  let(:valid_attributes) {{
    name: "changed name",
    text: "changed text",
  }}

  let(:invalid_attributes) {{
    location_id: "blah"
  }}

  describe 'GET index' do
    context 'unathenticated' do
      before :each do
        auth_other
        get :index, {scenario_id: scenario.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context "authenticated" do
      before :each do
        authenticate
        get :index, {scenario_id: scenario.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe 'GET show' do
    context 'unathenticated' do
      before :each do
        get :show, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context "authenticated" do
      before :each do
        authenticate
        get :show, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe 'GET new' do
    context 'unathenticated' do
      before :each do
        get :new, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context "authenticated" do
      before :each do
        authenticate
        get :new, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe 'GET edit' do
    context 'unathenticated' do
      before :each do
        auth_other
        get :edit, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context "authenticated" do
      before :each do
        authenticate
        get :edit, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).to be_success}
    end
  end

  describe 'POST create' do
    context 'unathenticated' do
      before :each do
        post :create, {scenario_id: scenario.id, contact: valid_attributes}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
      end

      context 'valid params' do
        before :each do
          post :create, {scenario_id: scenario.id, contact: valid_attributes}
        end

        it {expect(response).to redirect_to([scenario, Contact.first])}

        subject(:my_contact) {Contact.first}
        it {expect(my_contact.name).to eq("changed name")}
        it {expect(my_contact.text).to eq("changed text")}
        it {expect(my_contact.scenario).to eq(scenario)}
      end

      context 'invalid params' do
        before :each do
          request.env["HTTP_REFERER"] = "back"
          post :create, {scenario_id: scenario.id, contact: invalid_attributes}
        end

        it {expect(Contact.count).to be(0)}
        it {expect(response).to redirect_to('back')}
      end
    end
  end

  describe 'PUT update' do
    context 'unathenticated' do
      before :each do
        put :update, {scenario_id: scenario.id, id: contact.id, contact: valid_attributes}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
      end

      context 'valid params' do
        before :each do
          put :update, {scenario_id: scenario.id, id: contact.id, contact: valid_attributes}
        end

        it {expect(response).to redirect_to([scenario, Contact.first])}

        subject(:my_contact) {Contact.first}
        it {expect(my_contact.name).to eq("changed name")}
        it {expect(my_contact.text).to eq("changed text")}
        it {expect(my_contact.scenario).to eq(scenario)}
      end
    end
  end

  describe "DELETE destroy" do
    context 'unauthenticated' do
      before :each do
        delete :destroy, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(401)}
    end

    context 'authenticated' do
      before :each do
        authenticate
      end

      it "should raise without contact" do
        expect{delete :destroy, {scenario_id: scenario.id, id: 1}}.to raise_error
      end

      before :each do
        delete :destroy, {scenario_id: scenario.id, id: contact.id}
      end

      it {expect(response).to redirect_to(scenario_contacts_url(scenario))}
      it {expect(Contact.count).to be(0)}
    end
  end
end
