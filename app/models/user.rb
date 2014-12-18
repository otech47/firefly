class User < ActiveRecord::Base
  before_create :generate_ticket #before creating the user generate a unique ticket string

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

    def generate_ticket
      begin
        self.ticket = SecureRandom.hex
      end while self.class.exists?(ticket: ticket)
    end
end