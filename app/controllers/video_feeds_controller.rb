class VideoFeedsController < ApplicationController
  before_action :find_video_feed, except: [:create]

  def create
    video_feed = current_user.video_feeds.new(valid_params)
    if video_feed.save
      redirect_to settings_path
    else
      flash[:error] = video_feed.errors.full_messages.join(" ")
      redirect_to settings_path
    end
  end

  def update
    if @video_feed.update(valid_params)
      redirect_to settings_path
    else
      flash[:error] = video_feed.errors.full_messages.join(" ")
      redirect_to settings_path
    end
  end

  def destroy
    @video_feed.destroy
    redirect_to settings_path
  end

  private

  def find_video_feed
    @video_feed = current_user.video_feeds.find(params[:id])
  end

  def valid_params
    params.require(:video_feed).permit(:url, :location)
  end
end
