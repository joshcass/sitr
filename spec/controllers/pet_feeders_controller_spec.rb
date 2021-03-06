require 'rails_helper'

describe PetFeedersController do
  let!(:user) { User.create(email: "email@example.com", time_zone: 'UTC', password: 'password') }

  before(:each) do
    session[:user_id] = user.id
  end

  context '#create' do
    it 'can create a pet feeder' do
      expect {
        post :create, pet_feeder: { url: 'http://www.my-feeder.com', name: 'Feeder 1'}
      }.to change{PetFeeder.count}.from(0).to(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end

  context '#update' do
    it 'can update a pet feeder' do
      pet_feeder = user.pet_feeders.create(url: 'http://www.my-feeder.com', name: 'Feeder 1')

      put :update, id: pet_feeder.id, pet_feeder: { url: 'http://www.another-feeder.com', name: 'Feeder 1'}

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
      expect(PetFeeder.find(pet_feeder.id).url).to eq('http://www.another-feeder.com')
    end
  end

  context '#destroy' do
    it 'can destroy a pet feeder' do
      pet_feeder = user.pet_feeders.create(url: 'http://www.my-feeder.com', name: 'Feeder 1')

      expect{
        delete :destroy, id: pet_feeder.id
      }.to change{PetFeeder.count}.from(1).to(0)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end


  context '#feed' do
    it 'can send a request to a pet feeder' do
      pet_feeder = user.pet_feeders.create(url: 'http://httpbin.org/post', name: 'Feeder 1', password: '' )

      post :feed, id: pet_feeder.id

      expect(response.status).to eq(200)
    end
  end
end
