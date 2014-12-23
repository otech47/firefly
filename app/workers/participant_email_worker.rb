class ParticipantEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "emails"
  sidekiq_options retry: true
  
  def perform(participant_id)
    UserMailer.participant_ticket(participant_id).deliver
  end
end