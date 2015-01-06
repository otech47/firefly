# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/observer_ticket
  def observer_ticket
    UserMailer.observer_ticket('1')
  end

  def participant_ticket
    UserMailer.participant_ticket('1')
  end

  def participant_invite
    UserMailer.participant_invite('3', 'dan@yovu.co', '1')
  end

end
