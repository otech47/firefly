class API::V1::AttendeesController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token
 
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def check_in
    @payload = params[:payload]

    if @payload.include? 'observer'
      @type = 'observer'
      @ticket = @payload.partition('-').last
      @observer = Observer.find_by_ticket(@payload)

      if @observer
        @name = @observer.name
        @email = @observer.email

        @observer.update_attributes(
          :checked_in => true
        )

        redirect_to admin_checkin_path
        flash[:notice] = "#{@name} was checked in."
      else
        redirect_to admin_checkin_path
        flash[:notice] = "That did not work, refresh the page and try again."
      end
    elsif @payload.include? 'participant'
      @type = 'partition'
      @ticket = @payload.partition('-').last
      @partition = User.find_by_ticket(@payload)

      if @partition
        @name = @partition.name
        @email = @partition.email

        @partition.update_attributes(
          :checked_in => true
        )

        redirect_to admin_checkin_path
        flash[:notice] = "#{@name} was checked in."
      else
        redirect_to admin_checkin_path
        flash[:notice] = "That did not work, refresh the page and try again."
      end
    else
      redirect_to admin_checkin_path
        flash[:notice] = "That did not work, refresh the page and try again."
    end

  end

  def hacker_look_up
    @hacker = User.find_by_email(params['email'])

    if @hacker
      @hacker.update_attributes(
        :team_id => params['team_id']
      )

      @email_hash = Digest::MD5.hexdigest("@hacker.email")

      @response = {
        :status => '200',
        :data => {
          :id => @hacker.id,
          :name => @hacker.name,
          :email => @hacker.email,
          :email_hash => @email_hash,
          :btc_address => @hacker.btc_address
        }
      }
    else
      UserMailer.participant_invite(current_user.id, params['email'], params['team_id']).deliver
      
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