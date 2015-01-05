class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :if_admin
  layout 'admin'

  def hackers
    @hackers = User.where(:admin => false)
  end

  def observers
    @observers = Observer.all
  end


  def if_admin
    if current_user.admin == false
      redirect_to root_url
    end
  end
end