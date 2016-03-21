require 'rails_helper'

describe FeedTime do
  before(:each) do
    @user = User.create(email: "email@example.com", time_zone: 'UTC', password: 'password')
    @pet_feeder = @user.pet_feeders.create(name: 'Feeder 1', url: 'http://www.example.com', last_feeding: 1.hour.ago)
    @feed_time = @pet_feeder.feed_times.create(time: 1.day.ago)
  end

  context 'validations' do
    it 'is invalid without a time' do
      feed_time = @pet_feeder.feed_times.new(time: '')
      expect(feed_time).to be_invalid
    end

    it 'must have a unique time' do
      feed_time = @pet_feeder.feed_times.new(time: @feed_time.time)
      expect(feed_time).to be_invalid
    end
  end

  context 'associations' do
    it 'belongs to a pet feeder' do
      expect(@feed_time.pet_feeder).to eq(@pet_feeder)
    end
  end

  context 'methods' do
    it 'can parse the feed time to today' do
      expect(@feed_time.time_today.day).to eq(Time.zone.now.day)
    end
  end
end
