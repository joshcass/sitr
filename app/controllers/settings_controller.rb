class SettingsController < ApplicationController
  def index
    @video_feed = VideoFeed.new
  end
end
