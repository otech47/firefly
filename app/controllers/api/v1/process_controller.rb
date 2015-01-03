class API::V1::ProcessController < ApplicationController
  respond_to     :json
  skip_before_filter :verify_authenticity_token
 
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cameratag
    request.body.rewind
    payload = JSON.parse request.body.read
 
    @team = Team.find(payload['metadata']['team_id'])

    @team.update_attributes(
      :video => payload['uuid']
    )

    render json: { :check => 'good' }
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