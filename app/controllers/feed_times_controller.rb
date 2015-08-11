class FeedTimesController < ApplicationController
  before_action :find_pet_feeder
  before_action :find_feed_time, except: [:create]

  def create
    time = parse_time(valid_params[:time])
    feed_time = @pet_feeder.feed_times.new(time: time)
    if feed_time.save
      redirect_to settings_path
    else
      flash[:error] = feed_time.errors.full_messages.join(" ")
      redirect_to settings_path
    end
  end

  def update
    if @feed_time.update(valid_params)
      redirect_to settings_path
    else
      flash[:error] = @feed_time.errors.full_messages.join(" ")
      redirect_to settings_path
    end
  end

  def destroy
    @feed_time.destroy
    redirect_to settings_path
  end

  private

  def find_pet_feeder
    @pet_feeder = current_user.pet_feeders.find(params[:pet_feeder_id])
  end

  def find_feed_time
    @feed_time = @pet_feeder.feed_times.find(params[:id])
  end

  def valid_params
    params.require(:feed_time).permit(:time)
  end
end
