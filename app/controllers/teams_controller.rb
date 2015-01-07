class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  layout 'clean'

  def index
    @teams = Team.all
    @new_team = Team.new
    respond_with(@teams)
  end

  def show
    @video = HTTParty.get("http://cameratag.com/api/v4/videos/#{@team.video}.json?api_key=#{ENV['CAMERATAG_API']}")
    respond_with(@team)
  end

  def new
    @team = Team.new
    respond_with(@team)
  end

  def edit
    @admin = User.find(@team.admin)
    if @team.video.present?
      @video = HTTParty.get("http://cameratag.com/api/v4/videos/#{@team.video}.json?api_key=#{ENV['CAMERATAG_API']}")
    end
  end

  def create
    @team = Team.new(team_params)
    flash[:notice] = 'Team was successfully created.' if @team.save
    respond_with(@team)
  end

  def update
    flash[:notice] = 'Team was successfully updated.' if @team.update(team_params)
    respond_with(@team)
  end

  def destroy
    @team.destroy
    respond_with(@team)
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :repo, :video, :admin, :avatar)
    end
end
