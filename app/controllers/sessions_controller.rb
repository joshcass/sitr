class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    user = User.find_by(email: valid_params[:email])
    if user
      if user.authenticate(valid_params[:password])
        session[:user_id] = user.id
        redirect_to dashboard_index_path
      else
        flash[:error] = "Login Failed"
        redirect_to root_path
      end
    else
      @user = User.new(valid_params)
      render 'users/new'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def valid_params
    params.require(:user).permit(:email, :password)
  end
end
