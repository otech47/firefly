class ObserverEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "email"
  sidekiq_options retry: true
  
  def perform(observer_id)
    UserMailer.observer_ticket(observer_id).deliver
  end
end