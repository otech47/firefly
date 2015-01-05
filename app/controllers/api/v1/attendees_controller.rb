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

        @response = {
          :status => '200',
          :data => {
            :ticket => {
              :type => @type,
              :ticket => @ticket,
              :raw => @payload
            },
            :person => {
              :name => @name,
              :email => @email
            }
          }
        }
      else
        @response = {
        :status => '500',
          :data => {
            :error => 'No ticket found'
          }
        }
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

        @response = {
          :status => '200',
          :data => {
            :ticket => {
              :type => @type,
              :ticket => @ticket,
              :raw => @payload
            },
            :person => {
              :name => @name,
              :email => @email
            }
          }
        }
      else
        @response = {
        :status => '500',
          :data => {
            :error => 'No ticket found'
          }
        }
      end
    else
      @response = {
        :status => '500',
        :data => {
          :error => 'No ticket found'
        }
      }
    end

    render json: @response
  end

  def hacker_look_up
    @hacker = User.find_by_email(params['email'])

    if @hacker
      @response = {
        :status => '200',
        :data => {
          :name => @hacker.name,
          :email => @hacker.email,
          :btc_address => @hacker.btc_address
        }
      }
    else
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