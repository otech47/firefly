class Team < ActiveRecord::Base
  require 'identicon'
  before_create :generate_avatar

  private

    def generate_avatar
      self.avatar = Identicon.data_url_for self.name
    end
end
