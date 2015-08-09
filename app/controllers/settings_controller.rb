class SettingsController < ApplicationController
  def index
    @video_feed = VideoFeed.new
    @pet_feeder = PetFeeder.new
    @feed_time = FeedTime.new
  end
end
