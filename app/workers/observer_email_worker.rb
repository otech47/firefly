class ObserverEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "email"
  sidekiq_options retry: true
  
  def perform(observer_id)
    logger.info 'Sup bitch'
    logger.info observer_id
  end
end