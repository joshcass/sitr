require 'rails_helper'

describe VideoFeedsController do
  before(:each) do
    @user = User.create(name: "Boba Fett", screen_name: "bobafett", uid: '1234')
    session[:user_id] = @user.id
  end

  context '#create' do
    it 'can create a video feed' do
      expect {
        post :create, video_feed: { url: 'http://www.sweet-feed.com', location: 'My House'}
      }.to change{VideoFeed.count}.from(0).to(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end

  context '#update' do
    it 'can update a video feed' do
      video_feed = @user.video_feeds.create(url: 'http://www.sweet-feed.com', location: 'My House')

      put :update, id: video_feed.id, video_feed: { url: 'http://www.lame-feed.com', location: 'My House'}

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
      expect(VideoFeed.find(video_feed.id).url).to eq('http://www.lame-feed.com')
    end
  end

  context '#destroy' do
    it 'can destroy a video feed' do
      video_feed = @user.video_feeds.create(url: 'http://www.sweet-feed.com', location: 'My House')

      expect{
        delete :destroy, id: video_feed.id
      }.to change{VideoFeed.count}.from(1).to(0)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end
end
