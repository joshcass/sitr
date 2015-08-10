class PetFeedersController < ApplicationController
  before_action :find_pet_feeder, except: [:create]

  def create
    pet_feeder = current_user.pet_feeders.create(valid_params)
    if pet_feeder.save
      redirect_to settings_path
    else
      flash[:error] = pet_feeder.errors.full_messages.join(" ")
      redirect_to settings_path
    end
  end

  def update
    if @pet_feeder.update(valid_params)
      redirect_to settings_path
    else
      flash[:error] = @pet_feeder.errors.full_messages.join(" ")
      redirect_to settings_path
    end
  end

  def destroy
    @pet_feeder.destroy
    redirect_to settings_path
  end

  def feed
   @pet_feeder.feed_now
   render json: Time.now.in_time_zone(current_user.time_zone).strftime('%-l:%M%p').to_json
  end

  private

  def valid_params
    params.require(:pet_feeder).permit(:url, :name)
  end

  def find_pet_feeder
    @pet_feeder = current_user.pet_feeders.find(params[:id])
  end
end
