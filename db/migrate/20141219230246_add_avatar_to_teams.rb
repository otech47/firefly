class AddAvatarToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :avatar, :text
  end
end
