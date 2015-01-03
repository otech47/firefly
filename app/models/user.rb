class User < ActiveRecord::Base
  before_create :generate_ticket #before creating the user generate a unique ticket string
  after_create :send_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def send_email
    ParticipantEmailWorker.perform_in(15.seconds, self.id)
  end
  
  belongs_to :team

  private

    def generate_ticket
      begin
        self.ticket = "participant-#{SecureRandom.hex}"
      end while self.class.exists?(ticket: ticket)
    end
end