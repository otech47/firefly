class Team < ActiveRecord::Base
  require 'identicon'
  before_create :generate_avatar

  has_many :users

  private

    def generate_avatar
      self.avatar = Identicon.data_url_for self.name
    end
end
