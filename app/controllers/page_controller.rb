class PageController < ApplicationController
  def home
    @observer = Observer.new
  end
end
