class API::V1::TeamController < ApplicationController
  respond_to     :json
  skip_before_filter :verify_authenticity_token

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def all
    begin
      @team = Team.all

      @response = {
        :status => '200',
        :data => {
          :teams => @team
        }
      }
    rescue Exception => e
      @response = {
        :status => '500',
        :data => {
          :error => 'O_o'
        }
      }
    end

    render json: @response
  end

  def team
    begin
      @team = Team.find(params[:id])
      @members = User.where(:team_id => params[:id])

      teamMembers = Array.new
      @members.each do |member|
        buildMembers = member
        teamMembers.push buildMembers
      end

      @response = {
        :status => '200',
        :data => {
          :team => @team,
          :member_count => @team.users.count,
          :members => teamMembers
        }
      }
    rescue Exception => e
      @response = {
        :status => '500',
        :data => {
          :error => 'O_o'
        }
      }
    end

    render json: @response
  end

  def invite
    begin
      UserMailer.hacker_invite(params[:by_who], params[:hacker_id]).deliver

      @response = {
        :status => '200',
        :data => ':)'
      }
    rescue Exception => e
      @response = {
        :status => '500',
        :data => {
          :error => 'O_o'
        }
      }
    end

    render json: @response
  end

  def join
    @hacker = User.find(params[:hacker_id])
    @team = Team.find(params[:team_id])

    @hacker.update_attributes(
      :team_id => @team.id
    )

    redirect_to team_path(@team.slug)
  end

  def currently_presenting
    @presenting = Presenting.last
    @team = Team.find(@presenting.team_id)

    begin
      @response = {
        :status => '200',
        :data => {
          :team => @presenting,
          :team_info => @team
        }
      } 
    rescue Exception => e
      @response = {
        :status => '500'
      } 
    end

    render json: @response
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

end
