class SettingsController < ApplicationController
  def index
    @video_feed = VideoFeed.new
    @pet_feeder = PetFeeder.new
  end
end
