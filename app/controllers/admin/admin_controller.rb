class Admin::AdminController < ApplicationController
  layout 'lean'

  def dashboard
    @hackers = User.where(:admin => false)
  end

end