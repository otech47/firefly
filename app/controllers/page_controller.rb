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
    @observers = Observer.all

    @observers.each do |observer|
      ObserverEmailWorker.perform_in(15.seconds, observer.id)
    end
    render json: { :data => @observers }
  end
end
