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
    response = @pet_feeder.feed_now
    if response.success?
      render json: @pet_feeder.last_feeding.in_time_zone(current_user.time_zone).strftime('%-l:%M%p').to_json
    else
      render nothing: true, status: response.code
    end
  end

  private

  def valid_params
    params.require(:pet_feeder).permit(:url, :name, :token, :username, :password)
  end

  def find_pet_feeder
    @pet_feeder = current_user.pet_feeders.find(params[:id])
  end
end
