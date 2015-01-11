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

  def checkin
    @hackers = User.where(:admin => false, :checked_in => false)
    @observers = Observer.all

    @todos = Array.new
    @hackers.each do |hacker|
      buildhacker = hacker
      @todos.push buildhacker
    end

    @observers.each do |observer|
      buildobserver = observer
      @todos.push buildobserver
    end
  end

  def presenting
    @teams = Team.all
  end

  def set_presenters
    @teams = Team.find(params[:team])

    
  end

  def if_admin
    if current_user.admin == false
      redirect_to dashboard_path
    end
  end
end