class PageController < ApplicationController
  def home
    @observer = Observer.new

    @minerFee = HTTParty.get('https://api.coinbase.com/v1/prices/buy?qty=0.0001')
  end

  def rules
    render :layout => 'lean'
  end

  def land
    render :layout => 'lean'
  end

  def coje
    @participants = User.where(:admin => false)

    @participants.each do |participant|
      ParticipantEmailWorker.perform_in(15.seconds, participant.id)
    end
    render json: { :data => @participants }
  end
end
