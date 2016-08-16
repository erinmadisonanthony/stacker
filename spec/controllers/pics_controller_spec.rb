require 'rails_helper'

RSpec.describe PicsController, type: :controller do
  describe "pics#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "pics#new action" do
    it "should successfully show the new pic" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
