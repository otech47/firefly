class Team < ActiveRecord::Base
  require 'identicon'
  extend FriendlyId
  friendly_id :name, use: :slugged
  before_create :generate_avatar
  after_create :set_admin

  has_many :users

  private

    def generate_avatar
      self.avatar = Identicon.data_url_for self.name
    end

    def set_admin
    	@admin = User.find(self.admin)

    	@admin.update_attributes(
        :team_id => self.id
      )
    end
end
