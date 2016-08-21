require 'rails_helper'

RSpec.describe PicsController, type: :controller do

  describe "grams#destroy" do
    it "shouldn't allow users who didn't create the pic to destroy it" do
      DatabaseCleaner.clean
      pic = FactoryGirl.create(:pic)
      user = FactoryGirl.create(:user)
      sign_in user 

      delete :destroy, id: pic.id 
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users destroy a pic" do
      DatabaseCleaner.clean 
      pic = FactoryGirl.create(:pic)
      delete :destroy, id: pic.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow a user to destroy pics" do
      DatabaseCleaner.clean 
      pic = FactoryGirl.create(:pic)
      sign_in pic.user 
      delete :destroy, id: pic.id 
      expect(response).to redirect_to root_path
      pic = Pic.find_by_id(pic.id)
      expect(pic).to eq nil 
    end

    it "should return a 404 message if we cannot find a pic with the id that is specified" do
      DatabaseCleaner.clean 
      user = FactoryGirl.create(:user)
      sign_in user 
      delete :destroy, id: 'FakeID'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "pics#update" do
    it "shouldn't let users who didn't create the pic update it" do
      DatabaseCleaner.clean
      pic = FactoryGirl.create(:pic)
      user = FactoryGirl.create(:user)
      sign_in user 

      patch :update, id: pic.id, pic: { message: 'Updated' }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users create a pic" do
      DatabaseCleaner.clean 
      pic = FactoryGirl.create(:pic)
      patch :update, id: pic.id, pic: { message: "Hello" }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update pics" do
      DatabaseCleaner.clean 
      pic = FactoryGirl.create(:pic, message: "Original Message")
      sign_in pic.user 

      patch :update, id: pic.id, pic: { message: "New Message" }
      expect(response).to redirect_to root_path
      pic.reload
      expect(pic.message).to eq "New Message"
    end

    it "should have http 404 error if the pic cannot be found" do
      DatabaseCleaner.clean
      user = FactoryGirl.create(:user)
      sign_in user

      patch :update, id: "FakeID", pic: { message: "New Message" }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      DatabaseCleaner.clean
      pic = FactoryGirl.create(:pic, message: "Original Message")
      sign_in pic.user 

      patch :update, id: pic.id, pic: { message: ""}
      expect(response).to have_http_status(:unprocessable_entity)
      pic.reload
      expect(pic.message).to eq "Original Message"
    end
  end

  describe "pics#edit" do
    it "shouldn't let a user who did not create the pic edit a pic" do
      DatabaseCleaner.clean
      pic = FactoryGirl.create(:pic)
      user = FactoryGirl.create(:user)
      sign_in user 

      get :edit, id: pic.id 
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users edit a pic" do
      DatabaseCleaner.clean 
      pic = FactoryGirl.create(:pic) 
      get :edit, id: pic.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the pic is found" do
      DatabaseCleaner.clean
      pic = FactoryGirl.create(:pic)
      sign_in pic.user 

      get :edit, id: pic.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the pic is not found" do
      DatabaseCleaner.clean 
      user = FactoryGirl.create(:user)
      sign_in user 

      get :edit, id: 'FakeID'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "pics#show action" do
    it "should successfully show the page if the pic is found" do
      DatabaseCleaner.clean
      pic = FactoryGirl.create(:pic)
      get :show, id: pic.id
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error if the pic is not found" do
      get :show, id: 'FakeID'
      expect(response).to have_http_status(:not_found)
    end
  end

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

    it "should successfully show the new pic form" do
      DatabaseCleaner.clean
      user = FactoryGirl.create(:user)
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
      DatabaseCleaner.clean
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, pic: {message: 'Lookin Good!'}
      expect(response).to redirect_to root_path

      pic = Pic.last
      expect(pic.message).to eq('Lookin Good!')
      expect(pic.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      DatabaseCleaner.clean
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, pic: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end
