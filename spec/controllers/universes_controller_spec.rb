require 'rails_helper'

describe UniversesController do
  let(:user) {create(:user)}
  let(:universe) {create(:universe, user: user)}
  let(:authenticate) {allow(controller).to receive(:current_user).and_return(user)}

  let(:valid_attributes) {{
    name: "changed name",
    description: "changed description",
    locations_csv: "ambie, a1\n toby \n",
  }}

  let(:deleted_location) {{
    name: "changed name",
    description: "changed description",
    locations_csv: "ambie, a1",
  }}

  let(:invalid_attributes) {{
    name: nil
  }}


  describe "GET index" do
    it "should return success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "should raise without universe" do
      expect{get :show, {id: 1}}.to raise_error
    end

    context 'with universe' do
      before :each do
        get :show, {id: universe.id}
      end

      it {expect(response).to be_success}
      it {expect(assigns(:universe)).to eq(universe)}
    end
  end

  describe "GET new" do
    context 'unathenticated' do
      before :each do
        get :new
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(302)}
    end

    context "authenticated" do
      before :each do
        authenticate
        get :new
      end

      it {expect(response).to be_success}
    end
  end

  describe "GET edit" do
    context 'unauthenticated' do
      before :each do
        get :edit, {id: universe.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(302)}
    end

    context 'authenticated' do
      before :each do
        create(:location, universe: universe)
        authenticate
      end

      it "should raise without universe" do
        expect{get :edit, {id: 1}}.to raise_error
      end

      context 'with universe' do
        before :each do
          get :edit, {id: universe.id}
        end

        it {expect(response).to be_success}
        it {expect(assigns(:universe)).to eq(universe)}
      end
    end
  end

  describe "POST create" do
    context 'unauthenticated' do
      before :each do
        post :create, {universe: valid_attributes}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(302)}
    end

    context 'authenticated' do
      before :each do
        authenticate
      end

      context 'valid params' do
        before :each do
          post :create, {universe: valid_attributes}
        end

        it {expect(Universe.count).to be(1)}
        it {expect(Location.count).to be(2)}
        it {expect(response).to redirect_to(Universe.first)}

        subject(:my_universe) {Universe.first}
        it {expect(my_universe.name).to eq("changed name")}
        it {expect(my_universe.locations.first.group).to eq("a1")}
        it {expect(my_universe.locations.first.name).to eq("ambie")}
        it {expect(my_universe.locations.second.group).to be_nil}
        it {expect(my_universe.locations.second.name).to eq("toby")}
      end

      context 'invalid params' do
        before :each do
          request.env["HTTP_REFERER"] = "back"
          post :create, {universe: invalid_attributes}
        end

        it {expect(Universe.count).to be(0)}
        it {expect(Location.count).to be(0)}
        it {expect(response).to redirect_to('back')}
      end
    end
  end

  describe "PUT update" do
    it "should raise without universe" do
      authenticate
      expect{put :update, {id: 1}}.to raise_error
    end

    context 'unauthenticated' do
      before :each do
        put :update, {id: universe.id, universe: valid_attributes}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(302)}
    end

    context 'authenticated' do
      before :each do
        authenticate
      end

      context 'valid params' do
        before :each do
          put :update, {id: universe.id, universe: valid_attributes}
        end

        it {expect(response).to redirect_to(universe)}

        subject(:my_universe) {Universe.find(universe.id)}
        it {expect(my_universe.name).to eq("changed name")}
        it {expect(my_universe.description).to eq("changed description")}
        it {expect(my_universe.locations.first.group).to eq("a1")}
        it {expect(my_universe.locations.first.name).to eq("ambie")}

        context 'twice' do
          before :each do
            put :update, {id: universe.id, universe: valid_attributes}
          end

          it {expect(Universe.count).to be(1)}
          it {expect(Location.count).to be(2)}
        end

        context 'deleted location' do
          before :each do
            put :update, {id: universe.id, universe: deleted_location}
          end

          it {expect(Universe.count).to be(1)}
          it {expect(Location.count).to be(1)}
        end
      end

      context 'invalid params' do
        before :each do
          request.env["HTTP_REFERER"] = "back"
          put :update, {id: universe.id, universe: invalid_attributes}
        end

        subject(:my_universe) {Universe.find(universe.id)}
        it {expect(my_universe.name).to eq("test name")}
        it {expect(my_universe.description).to eq("test description")}
      end
    end
  end

  describe "DELETE destroy" do
    context 'unauthenticated' do
      before :each do
        delete :destroy, {id: universe.id}
      end

      it {expect(response).not_to be_success}
      it {expect(response.status).to eq(302)}
    end

    context 'authenticated' do
      before :each do
        authenticate
      end

      it "should raise without universe" do
        expect{delete :destroy, {id: 1}}.to raise_error
      end

      before :each do
        delete :destroy, {id: universe.id}
      end

      it {expect(response).to redirect_to(universes_url)}
      it {expect(Universe.count).to be(0)}
    end
  end
end
