class UserMailer < ActionMailer::Base
  default from: "hello@miamibitcoinhackathon.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.observer_ticket.subject
  #
  def observer_ticket(observer_id)
    @observer = Observer.find(observer_id)

    mail to: @observer.email
    mail to: @observer.email, subject: "Miami Bitcoin Hackathon - Observer Ticket"
  end
end
