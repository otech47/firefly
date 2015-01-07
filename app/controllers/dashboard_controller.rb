class DashboardController < ApplicationController
	before_action :authenticate_user!
  layout 'clean'

  def welcome
  end

  def profile
  	@hacker = User.find(params[:id])
    @video = HTTParty.get("http://cameratag.com/api/v4/videos/#{@hacker.team.video}.json?api_key=#{ENV['CAMERATAG_API']}")
  end
end
