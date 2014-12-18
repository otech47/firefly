class Admin::AdminController < ApplicationController
  layout 'lean'

  def dashboard
    @hackers = User.all
  end

end