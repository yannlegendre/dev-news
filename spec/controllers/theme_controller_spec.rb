require 'rails_helper'

RSpec.describe ThemesController, type: :controller do
  describe "GET #index (page d'accueil)" do
    before(:each) do
      get :index
    end
    it "request should respond with status 200" do
      expect(response.status).to eq(200)
    end
    it "request should render the index view" do
      expect(response.status).to render_template("index")
    end
  end
end
