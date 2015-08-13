class NestController < ApplicationController
  def create
    Nest.from_omniauth(request.env['omniauth.auth'], current_user)
    redirect_to settings_path
  end

  def destroy
    nest = Nest.find(params[:id])
    nest.destroy
    redirect_to settings_path
  end
end
