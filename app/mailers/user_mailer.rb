class UserMailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  default from: "Miami Bitcoin Hackathon <hello@mg.miamibitcoinhackathon.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.observer_ticket.subject
  #
  def observer_ticket(observer_id)
    @observer = Observer.find(observer_id)

    mail to: @observer.email, subject: "Miami Bitcoin Hackathon - Observer Ticket"
  end

  def participant_ticket(participant_id)
    @participant = User.find(participant_id)

    mail to: @participant.email, subject: "Miami Bitcoin Hackathon - Participant Ticket"
  end

  def participant_invite(admin_id, participant_email, team_id)
    @admin = User.find(admin_id)
    @team = Team.find(team_id)
    
    mail to: participant_email, subject: "Invite To Miami Bitcoin Hackathon - From #{@admin.name}"
  end

  def hacker_invite(by_who, hacker_id)
    @admin = User.find(by_who)
    @hacker = User.find(hacker_id)
    
    mail to: @hacker.email, subject: "Invite To Miami Bitcoin Hackathon - From #{@admin.name}"
  end

  def participant_follow_up(hacker_id)
    @hacker = User.find(hacker_id)

    mail to: @hacker.email, subject: "Miami Bitcoin Hackathon - Dashboard"
  end
end
