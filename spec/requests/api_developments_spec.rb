require 'rails_helper'
require 'byebug'

RSpec.describe "ApiDevelopments", type: :request do
  #include_context "db_cleanup_each"
  def parsed_body
    JSON.parse(response.body)
  end

  describe "RDBMS-backed" do
    before(:each) { City.delete_all }
    after(:each) { City.delete_all }

    it "create RDBMS-backed model" do
      #object=FactoryGirl.create(:city, :name=>"test")
      object=City.create(:name=>"test")
      expect(City.find(object.id).name).to eq("test")
    end

    it "expose RDBMS-backed API resource" do
      #object=FactoryGirl.create(:city, :name=>"test")
      object=City.create(:name=>"test")
      expect(cities_path).to eq("/api/cities")
      get city_path(object.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
    end
  end

  describe "MongoDB-backed" do
    it "create MongoDB-backed model" do
      #object=FactoryGirl.create(:bar, :name=>"test")
      object=State.create(:name=>"test")
      expect(State.find(object.id).name).to eq("test")
    end

    it "expose MongoDB-backed API resource" do
      #object=FactoryGirl.create(:bar, :name=>"test")
      object=State.create(:name=>"test")
      expect(states_path).to eq("/api/states")
      get state_path(object.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq(object.name)
      expect(parsed_body).to include("created_at")
      expect(parsed_body).to include("id"=>object.id.to_s)
    end
  end
end
