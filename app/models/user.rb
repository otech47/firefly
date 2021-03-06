class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  before_create :generate_ticket #before creating the user generate a unique ticket string
  after_create :send_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def send_email
    UserMailer.participant_ticket(self.id).deliver
    UserMailer.participant_follow_up(self.id).deliver
  end

  belongs_to :team

  private

    def generate_ticket
      begin
        self.ticket = "participant-#{SecureRandom.hex}"
      end while self.class.exists?(ticket: ticket)
    end
end
