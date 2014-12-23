class ObserversController < ApplicationController
  before_action :set_observer, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js, :json

  def index
    @observers = Observer.all
    respond_with(@observers)
  end

  def show
    respond_with(@observer)
  end

  def new
    @observer = Observer.new
    
    respond_to do |format|
      if @observer.save
        format.html { redirect_to @observer, notice: 'Observer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @observer }
        format.js   { render action: 'show', status: :created, location: @observer }
      else
        format.html { render action: 'new' }
        format.json { render json: @observer.errors, status: :unprocessable_entity }
        format.js   { render json: @observer.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def create
    @observer = Observer.new(observer_params)
    flash[:notice] = 'Observer was successfully created.' if @observer.save
    ObserverEmailWorker.perform_in(15.seconds, @observer.id)
    respond_with(@observer)
  end

  def update
    flash[:notice] = 'Observer was successfully updated.' if @observer.update(observer_params)
    respond_with(@observer)
  end

  def destroy
    @observer.destroy
    respond_with(@observer)
  end

  private
    def set_observer
      @observer = Observer.find(params[:id])
    end

    def observer_params
      params.require(:observer).permit(:name, :email, :ticket)
    end
end
