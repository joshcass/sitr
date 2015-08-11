class WelcomeController < ApplicationController
  skip_before_action :authorize

  def index
    if current_user
      redirect_to dashboard_index_path
    end
  end
end
