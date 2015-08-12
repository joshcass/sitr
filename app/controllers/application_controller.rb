class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authorize

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
    redirect_to root_path, notice: 'Please log in or signup' unless current_user
  end

  def parse_time(time)
    ActiveSupport::TimeZone.new(current_user.time_zone).parse(time).utc
  end
end
