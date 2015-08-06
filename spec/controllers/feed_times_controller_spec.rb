require 'rails_helper'

describe FeedTimesController do
  before(:each) do
    @user = User.create(name: "Boba Fett", screen_name: "bobafett", uid: '1234')
    @pet_feeder = @user.pet_feeders.create(name: 'Feeder 1', url: 'http://pet-feeder.com')
    session[:user_id] = @user.id
  end

  context '#create' do
    it 'can create a feed time' do
      expect {
        post :create, pet_feeder_id: @pet_feeder.id, feed_time: { time: '3:30PM'}
      }.to change{FeedTime.count}.from(0).to(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end

  context '#update' do
    it 'can update a feed time' do
      feed_time = @pet_feeder.feed_times.create(time: '3:30PM')

      put :update, pet_feeder_id: @pet_feeder.id, id: feed_time.id, feed_time: { time: '6:30PM'}

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
      expect(FeedTime.find(feed_time.id).time.strftime('%I:%M%p')).to eq('06:30PM')
    end
  end

  context '#destroy' do
    it 'can destroy a feed time' do
      feed_time = @pet_feeder.feed_times.create(time: '3:30PM')

      expect{
        delete :destroy, pet_feeder_id: @pet_feeder.id ,id: feed_time.id
      }.to change{FeedTime.count}.from(1).to(0)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end
end
