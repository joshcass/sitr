require 'rails_helper'

describe VideoFeed do
  before(:each) do
    @user = User.create(email: "email@example.com", time_zone: 'UTC', password: 'password')
    @video_feed = @user.video_feeds.create(location: 'Living Room', url: 'http://www.example.com')
  end

  context 'validations' do
    it 'is invalid without a url' do
      video_feed = @user.video_feeds.new(location: 'Kitchen', url: '')

      expect(video_feed).to be_invalid
    end

    it 'must have a real url' do
      video_feed = @user.video_feeds.new(location: 'Kitchen', url: 'http://wwwexamplecom')

      expect(video_feed).to be_invalid
    end

    it 'must have a unique location' do
      video_feed = @user.video_feeds.new(location: 'Living Room', url: 'http://www.google.com')

      expect(video_feed).to be_invalid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      expect(@video_feed.user).to eq(@user)
    end
  end
end
