class NestController < ApplicationController
  def create
    auth_info = request.env['omniauth.auth']
    Nest.create(token: auth_info.credentials.token, expiration: auth_info.credentials.expires_at, user_id: current_user.id)
    redirect_to settings_path
  end

  def destroy
    nest = Nest.find(params[:id])
    nest.destroy
    redirect_to settings_path
  end
end
