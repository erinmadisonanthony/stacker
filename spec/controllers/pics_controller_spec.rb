require 'rails_helper'

RSpec.describe PicsController, type: :controller do
  describe "pics#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "pics#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new pic" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "pics#create action" do
    it "should require users to be logged in" do
      post :create, pic: {message: 'YOLO'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new pic in the database" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      
      post :create, pic: {message: 'Lookin Good!'}
      expect(response).to redirect_to root_path

      pic = Pic.last
      expect(pic.message).to eq('Lookin Good!')
      expect(pic.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      
      post :create, pic: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
