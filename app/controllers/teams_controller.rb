class TeamsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_team, only: [:edit, :update, :destroy]
  before_action :set_team_friendly, only: [:show]

  respond_to :html, :js

  layout 'clean'

  def index
    @teams = Team.all
    @new_team = Team.new
    respond_with(@teams)
  end

  def show
    @memberCount = @team.users.count
    @video = HTTParty.get("http://cameratag.com/api/v4/videos/#{@team.video}.json?api_key=#{ENV['CAMERATAG_API']}")
    respond_with(@team)
  end

  def new
    @team = Team.new
    respond_with(@team)
  end

  def edit
    if current_user.id == @team.admin
      @admin = User.find(@team.admin)
      if @team.video.present?
        @video = HTTParty.get("http://cameratag.com/api/v4/videos/#{@team.video}.json?api_key=#{ENV['CAMERATAG_API']}")
      end
    else
      redirect_to teams_path
    end
  end

  def create
    @team = Team.new(team_params)
    flash[:notice] = 'Team was successfully created.' if @team.save
    respond_with(@team)
  end

  def update
    if current_user.id == @team.admin
      flash[:notice] = 'Team was successfully updated.' if @team.update(team_params)
      respond_with(@team)
    else
      redirect_to teams_path
    end
  end

  def destroy
    @team.destroy
    respond_with(@team)
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def set_team_friendly
      @team = Team.friendly.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :repo, :video, :admin, :avatar, :btc_address, :bio, :project_name)
    end
end
