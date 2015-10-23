class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create]

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new valid_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_index_path
    else
      flash.now[:error] = @user.errors.full_messages.join(" ")
      render 'users/new'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
  end

  private

  def valid_params
    params.require(:user).permit(:email, :password, :password_confirmation, :time_zone)
  end
end

