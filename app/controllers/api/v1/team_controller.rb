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