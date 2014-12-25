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
    sign_out current_user
  end
end
