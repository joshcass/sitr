class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
    end
    redirect_to dashboard_index_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
