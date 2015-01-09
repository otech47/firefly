class DashboardController < ApplicationController
	before_action :authenticate_user!, :except => [:profile, :participants, :foreveralone]
  layout 'clean'

  def welcome
    @hackers = User.where(:admin => false).count
    @teams = Team.count
    @observers = Observer.count

    @noTeam = User.where(:admin => false, :team_id => nil).count
  end

  def profile
  	@hacker = User.friendly.find(params[:id])
    if @hacker.team_id.present? && @hacker.team.video.present?
      @video = HTTParty.get("http://cameratag.com/api/v4/videos/#{@hacker.team.video}.json?api_key=#{ENV['CAMERATAG_API']}")
    end
  end

  def foreveralone
    @noTeam = User.where(:admin => false, :team_id => nil)
  end

  def participants
    @participants = User.where(:admin => false)
  end
end
