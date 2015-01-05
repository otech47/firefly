class DashboardController < ApplicationController
	before_action :authenticate_user!
  layout 'clean'

  def welcome
  end

  def profile
  	@hacker = User.find(params[:id])
  end
end
